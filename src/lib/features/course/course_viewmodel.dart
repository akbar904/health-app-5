import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../models/course.dart';
import '../../services/api_service.dart';
import '../../services/analytics_service.dart';
import 'course_repository.dart';

class CourseViewModel extends BaseViewModel {
  final CourseRepository _courseRepository;
  final ApiService _apiService;
  final AnalyticsService _analyticsService;

  Course? _course;
  List<Course> _courses = [];
  
  Course? get course => _course;
  List<Course> get courses => _courses;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final gradeController = TextEditingController();

  CourseViewModel({
    required CourseRepository courseRepository,
    required ApiService apiService,
    required AnalyticsService analyticsService,
  }) : _courseRepository = courseRepository,
       _apiService = apiService,
       _analyticsService = analyticsService;

  Future<void> initializeCourse(String courseId) async {
    setBusy(true);
    try {
      _course = await _courseRepository.getCourseById(courseId);
      _populateControllers();
      _analyticsService.logEvent('course_viewed', {'course_id': courseId});
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  void _populateControllers() {
    if (_course != null) {
      titleController.text = _course!.title;
      descriptionController.text = _course!.description;
      gradeController.text = _course!.grade.toString();
    }
  }

  Future<void> loadCourses() async {
    setBusy(true);
    try {
      _courses = await _courseRepository.getAllCourses();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> saveCourse() async {
    if (!_validateInputs()) return;

    setBusy(true);
    try {
      final courseData = Course(
        id: _course?.id ?? '',
        title: titleController.text,
        description: descriptionController.text,
        grade: int.parse(gradeController.text),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (_course == null) {
        await _courseRepository.createCourse(courseData);
        _analyticsService.logEvent('course_created', {'title': courseData.title});
      } else {
        await _courseRepository.updateCourse(courseData);
        _analyticsService.logEvent('course_updated', {'course_id': courseData.id});
      }

      await loadCourses();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  bool _validateInputs() {
    if (titleController.text.isEmpty) {
      setError('Title is required');
      return false;
    }
    if (descriptionController.text.isEmpty) {
      setError('Description is required');
      return false;
    }
    if (gradeController.text.isEmpty) {
      setError('Grade is required');
      return false;
    }
    return true;
  }

  Future<void> deleteCourse(String courseId) async {
    setBusy(true);
    try {
      await _courseRepository.deleteCourse(courseId);
      _analyticsService.logEvent('course_deleted', {'course_id': courseId});
      await loadCourses();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    gradeController.dispose();
    super.dispose();
  }
}