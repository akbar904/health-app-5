import 'package:gyde_app/models/course.dart';
import 'package:gyde_app/models/assignment.dart';
import 'package:gyde_app/models/user.dart';
import 'package:gyde_app/models/grade.dart';

class TeacherDashboardRepository {
  // Mock data
  final List<Course> _courses = [];
  final List<Assignment> _assignments = [];
  final List<User> _students = [];
  final List<Grade> _grades = [];

  Future<List<Course>> getCoursesByTeacherId(String teacherId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _courses.where((course) => course.teacherId == teacherId).toList();
  }

  Future<List<Assignment>> getAssignmentsByTeacherId(String teacherId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final teacherCourses = await getCoursesByTeacherId(teacherId);
    final courseIds = teacherCourses.map((course) => course.id).toSet();
    return _assignments
        .where((assignment) => courseIds.contains(assignment.courseId))
        .toList();
  }

  Future<List<User>> getStudentsByTeacherId(String teacherId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final teacherCourses = await getCoursesByTeacherId(teacherId);
    final studentIds =
        teacherCourses.expand((course) => course.studentIds).toSet();
    return _students
        .where((student) => studentIds.contains(student.id))
        .toList();
  }

  Future<Map<String, double>> getClassPerformanceMetrics(
      String courseId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final courseAssignments = _assignments
        .where((assignment) => assignment.courseId == courseId)
        .map((assignment) => assignment.id)
        .toList();

    final courseGrades = _grades
        .where((grade) => courseAssignments.contains(grade.assignmentId));

    if (courseGrades.isEmpty) return {};

    final Map<String, List<double>> studentScores = {};
    for (var grade in courseGrades) {
      if (!studentScores.containsKey(grade.studentId)) {
        studentScores[grade.studentId] = [];
      }
      studentScores[grade.studentId]!.add(grade.score);
    }

    return studentScores.map((studentId, scores) {
      final average = scores.reduce((a, b) => a + b) / scores.length;
      return MapEntry(studentId, average);
    });
  }

  Future<int> getPendingAssignmentsCount(String teacherId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final assignments = await getAssignmentsByTeacherId(teacherId);
    return assignments.where((assignment) => !assignment.isSubmitted).length;
  }

  Future<List<Assignment>> getRecentSubmissions(String teacherId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final assignments = await getAssignmentsByTeacherId(teacherId);
    return assignments
        .where((assignment) =>
            assignment.isSubmitted && assignment.submittedAt != null)
        .toList()
      ..sort((a, b) => b.submittedAt!.compareTo(a.submittedAt!));
  }
}
