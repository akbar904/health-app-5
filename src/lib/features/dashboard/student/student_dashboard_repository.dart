import 'package:gyde_app/models/course.dart';
import 'package:gyde_app/models/assignment.dart';
import 'package:gyde_app/models/progress.dart';

class StudentDashboardRepository {
  // Mock data
  final List<Course> _courses = [];
  final List<Assignment> _assignments = [];
  final List<Progress> _progress = [];

  Future<List<Course>> getEnrolledCourses(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _courses
        .where((course) => course.studentIds.contains(studentId))
        .toList();
  }

  Future<List<Assignment>> getUpcomingAssignments(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final now = DateTime.now();
    return _assignments
        .where((assignment) =>
            _isStudentEnrolledInCourse(studentId, assignment.courseId) &&
            assignment.dueDate.isAfter(now) &&
            !assignment.isSubmitted)
        .toList();
  }

  Future<List<Progress>> getStudentProgress(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _progress
        .where((progress) => progress.studentId == studentId)
        .toList();
  }

  Future<double> getOverallProgress(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final progressList = await getStudentProgress(studentId);
    if (progressList.isEmpty) return 0.0;

    final total = progressList.fold<double>(
      0.0,
      (sum, progress) => sum + progress.completionPercentage,
    );
    return total / progressList.length;
  }

  bool _isStudentEnrolledInCourse(String studentId, String courseId) {
    final course = _courses.firstWhere(
      (course) => course.id == courseId,
      orElse: () => Course(
        id: '',
        title: '',
        description: '',
        teacherId: '',
        gradeLevel: GradeLevel.none,
        subject: '',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        studentIds: [],
        resourceUrls: [],
        isActive: false,
      ),
    );
    return course.studentIds.contains(studentId);
  }
}
