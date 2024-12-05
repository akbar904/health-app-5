import 'package:stacked/stacked.dart';
import '../../services/course_service.dart';
import '../../models/course.dart';

class CourseViewModel extends BaseViewModel {
  final CourseService _courseService;
  List<Course> _courses = [];
  Course? _selectedCourse;
  
  CourseViewModel(this._courseService);

  List<Course> get courses => _courses;
  Course? get selectedCourse => _selectedCourse;

  Future<void> initialize() async {
    setBusy(true);
    try {
      _courses = await _courseService.getAllCourses();
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
      _courses = await _courseService.getAllCourses();
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
      _courses = await _courseService.getAllCourses();
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
      _courses = await _courseService.getAllCourses();
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

  Future<List<Course>> searchCourses(String query) async {
    setBusy(true);
    try {
      final results = await _courseService.searchCourses(query);
      return results;
    } catch (e) {
      setError(e);
      return [];
    } finally {
      setBusy(false);
    }
  }

  Future<void> enrollStudent(String courseId, String studentId) async {
    setBusy(true);
    try {
      await _courseService.enrollStudent(courseId, studentId);
      _courses = await _courseService.getAllCourses();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> unenrollStudent(String courseId, String studentId) async {
    setBusy(true);
    try {
      await _courseService.unenrollStudent(courseId, studentId);
      _courses = await _courseService.getAllCourses();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}