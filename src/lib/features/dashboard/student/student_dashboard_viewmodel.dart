import 'package:stacked/stacked.dart';
import 'package:gyde_app/models/course.dart';
import 'package:gyde_app/models/assignment.dart';
import 'package:gyde_app/models/progress.dart';
import 'package:gyde_app/services/course_service.dart';
import 'package:gyde_app/services/assignment_service.dart';
import 'package:gyde_app/services/progress_service.dart';
import 'package:gyde_app/app/app.locator.dart';

class StudentDashboardViewModel extends BaseViewModel {
  final _courseService = locator<CourseService>();
  final _assignmentService = locator<AssignmentService>();
  final _progressService = locator<ProgressService>();

  List<Course> _courses = [];
  List<Assignment> _assignments = [];
  List<Progress> _progress = [];

  List<Course> get courses => _courses;
  List<Assignment> get assignments => _assignments;
  List<Progress> get progress => _progress;

  double get overallProgress {
    if (_progress.isEmpty) return 0.0;
    final total = _progress.fold<double>(
      0.0,
      (sum, item) => sum + item.completionPercentage,
    );
    return total / _progress.length;
  }

  List<Assignment> get upcomingAssignments {
    return _assignments
        .where((assignment) =>
            assignment.dueDate.isAfter(DateTime.now()) &&
            !assignment.isSubmitted)
        .toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  Future<void> initialize(String studentId) async {
    setBusy(true);
    try {
      await Future.wait([
        _loadCourses(studentId),
        _loadAssignments(studentId),
        _loadProgress(studentId),
      ]);
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> _loadCourses(String studentId) async {
    _courses = await _courseService.getCoursesByStudentId(studentId);
  }

  Future<void> _loadAssignments(String studentId) async {
    _assignments =
        await _assignmentService.getAssignmentsByStudentId(studentId);
  }

  Future<void> _loadProgress(String studentId) async {
    _progress = await _progressService.getProgressByStudentId(studentId);
  }

  Future<void> refreshDashboard(String studentId) async {
    setBusy(true);
    try {
      await initialize(studentId);
    } finally {
      setBusy(false);
    }
  }
}
