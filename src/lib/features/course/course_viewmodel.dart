import 'package:stacked/stacked.dart';
import '../../models/course.dart';
import '../../services/course_service.dart';
import '../../app/app.locator.dart';

class CourseViewModel extends BaseViewModel {
  final _courseService = locator<CourseService>();
  
  List<Course> _courses = [];
  List<Course> get courses => _courses;
  
  Course? _selectedCourse;
  Course? get selectedCourse => _selectedCourse;

  bool _isTeacher = false;
  bool get isTeacher => _isTeacher;

  Future<void> initialize() async {
    setBusy(true);
    try {
      _courses = await _courseService.getCourses();
      _isTeacher = await _courseService.isTeacher();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> createCourse(Course course) async {
    setBusy(true);
    try {
      await _courseService.createCourse(course);
      _courses = await _courseService.getCourses();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateCourse(Course course) async {
    setBusy(true);
    try {
      await _courseService.updateCourse(course);
      _courses = await _courseService.getCourses();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> deleteCourse(String courseId) async {
    setBusy(true);
    try {
      await _courseService.deleteCourse(courseId);
      _courses.removeWhere((c) => c.id == courseId);
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  void selectCourse(Course course) {
    _selectedCourse = course;
    notifyListeners();
  }

  Future<void> enrollInCourse(String courseId) async {
    setBusy(true);
    try {
      await _courseService.enrollInCourse(courseId);
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> unenrollFromCourse(String courseId) async {
    setBusy(true);
    try {
      await _courseService.unenrollFromCourse(courseId);
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}