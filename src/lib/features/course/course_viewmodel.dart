import 'package:stacked/stacked.dart';
import 'package:gyde_app/models/course.dart';
import 'package:gyde_app/services/course_service.dart';
import 'package:gyde_app/app/app.locator.dart';

class CourseViewModel extends BaseViewModel {
  final _courseService = locator<CourseService>();
  Course? _course;
  bool _isEditing = false;

  Course? get course => _course;
  bool get isEditing => _isEditing;

  Future<void> initialize(String courseId) async {
    setBusy(true);
    try {
      _course = await _courseService.getCourseById(courseId);
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  void toggleEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<void> updateCourse(Course updatedCourse) async {
    setBusy(true);
    try {
      await _courseService.updateCourse(updatedCourse);
      _course = updatedCourse;
      _isEditing = false;
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> addStudent(String studentId) async {
    if (_course == null) return;

    setBusy(true);
    try {
      final updatedStudentIds = List<String>.from(_course!.studentIds)
        ..add(studentId);
      final updatedCourse = _course!.copyWith(studentIds: updatedStudentIds);
      await _courseService.updateCourse(updatedCourse);
      _course = updatedCourse;
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> removeStudent(String studentId) async {
    if (_course == null) return;

    setBusy(true);
    try {
      final updatedStudentIds = List<String>.from(_course!.studentIds)
        ..remove(studentId);
      final updatedCourse = _course!.copyWith(studentIds: updatedStudentIds);
      await _courseService.updateCourse(updatedCourse);
      _course = updatedCourse;
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> addResource(String resourceUrl) async {
    if (_course == null) return;

    setBusy(true);
    try {
      final updatedResourceUrls = List<String>.from(_course!.resourceUrls)
        ..add(resourceUrl);
      final updatedCourse =
          _course!.copyWith(resourceUrls: updatedResourceUrls);
      await _courseService.updateCourse(updatedCourse);
      _course = updatedCourse;
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> removeResource(String resourceUrl) async {
    if (_course == null) return;

    setBusy(true);
    try {
      final updatedResourceUrls = List<String>.from(_course!.resourceUrls)
        ..remove(resourceUrl);
      final updatedCourse =
          _course!.copyWith(resourceUrls: updatedResourceUrls);
      await _courseService.updateCourse(updatedCourse);
      _course = updatedCourse;
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}
