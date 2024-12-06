import 'package:stacked/stacked.dart';
import 'package:gyde_app/models/course.dart';
import 'package:gyde_app/models/assignment.dart';
import 'package:gyde_app/models/user.dart';
import 'package:gyde_app/services/course_service.dart';
import 'package:gyde_app/services/assignment_service.dart';
import 'package:gyde_app/services/user_service.dart';
import 'package:gyde_app/app/app.locator.dart';

class TeacherDashboardViewModel extends BaseViewModel {
  final _courseService = locator<CourseService>();
  final _assignmentService = locator<AssignmentService>();
  final _userService = locator<UserService>();

  List<Course> _courses = [];
  List<Assignment> _assignments = [];
  List<User> _students = [];

  List<Course> get courses => _courses;
  List<Assignment> get assignments => _assignments;
  List<User> get students => _students;

  int get totalStudents => _students.length;
  int get totalCourses => _courses.length;
  int get pendingAssignments =>
      _assignments.where((assignment) => !assignment.isSubmitted).length;

  Future<void> initialize(String teacherId) async {
    setBusy(true);
    try {
      await Future.wait([
        _loadCourses(teacherId),
        _loadAssignments(teacherId),
        _loadStudents(),
      ]);
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> _loadCourses(String teacherId) async {
    _courses = await _courseService.getCoursesByTeacherId(teacherId);
  }

  Future<void> _loadAssignments(String teacherId) async {
    final coursesIds = _courses.map((course) => course.id).toList();
    _assignments = [];
    for (final courseId in coursesIds) {
      final courseAssignments =
          await _assignmentService.getAssignmentsByCourseId(courseId);
      _assignments.addAll(courseAssignments);
    }
  }

  Future<void> _loadStudents() async {
    final studentIds =
        _courses.expand((course) => course.studentIds).toSet().toList();
    _students = [];
    for (final studentId in studentIds) {
      final student = await _userService.getUserById(studentId);
      if (student != null) {
        _students.add(student);
      }
    }
  }

  Future<void> refreshDashboard(String teacherId) async {
    setBusy(true);
    try {
      await initialize(teacherId);
    } finally {
      setBusy(false);
    }
  }

  List<Assignment> getAssignmentsByCourse(String courseId) {
    return _assignments
        .where((assignment) => assignment.courseId == courseId)
        .toList();
  }

  List<User> getStudentsByCourse(String courseId) {
    final course = _courses.firstWhere((course) => course.id == courseId);
    return _students
        .where((student) => course.studentIds.contains(student.id))
        .toList();
  }

  double getCourseCompletionRate(String courseId) {
    final courseAssignments = getAssignmentsByCourse(courseId);
    if (courseAssignments.isEmpty) return 0.0;

    final submitted =
        courseAssignments.where((assignment) => assignment.isSubmitted).length;
    return submitted / courseAssignments.length * 100;
  }
}
