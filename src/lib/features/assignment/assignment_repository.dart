import 'package:gyde_app/models/assignment.dart';
import 'package:gyde_app/models/grade.dart';

class AssignmentRepository {
  // Mock data
  final List<Assignment> _assignments = [];
  final List<Grade> _grades = [];

  Future<List<Assignment>> getAssignmentsByStudentId(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _assignments
        .where((assignment) =>
            assignment.courseId == studentId ||
            _isStudentEnrolledInCourse(studentId, assignment.courseId))
        .toList();
  }

  Future<List<Assignment>> getAssignmentsByCourseId(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _assignments
        .where((assignment) => assignment.courseId == courseId)
        .toList();
  }

  Future<Assignment?> getAssignmentById(String assignmentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _assignments.firstWhere((a) => a.id == assignmentId);
    } catch (e) {
      return null;
    }
  }

  Future<void> createAssignment(Assignment assignment) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _assignments.add(assignment);
  }

  Future<void> updateAssignment(Assignment assignment) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _assignments.indexWhere((a) => a.id == assignment.id);
    if (index != -1) {
      _assignments[index] = assignment;
    }
  }

  Future<void> deleteAssignment(String assignmentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _assignments.removeWhere((a) => a.id == assignmentId);
    _grades.removeWhere((g) => g.assignmentId == assignmentId);
  }

  Future<void> submitAssignment(
    String assignmentId,
    String studentId,
    String content,
    List<String> attachments,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _assignments.indexWhere((a) => a.id == assignmentId);
    if (index != -1) {
      _assignments[index] = _assignments[index].copyWith(
        isSubmitted: true,
        submittedAt: DateTime.now(),
        submissionContent: content,
        attachments: attachments,
      );
    }
  }

  Future<void> gradeAssignment(Grade grade) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final existingGradeIndex = _grades.indexWhere(
      (g) =>
          g.assignmentId == grade.assignmentId &&
          g.studentId == grade.studentId,
    );

    if (existingGradeIndex != -1) {
      _grades[existingGradeIndex] = grade;
    } else {
      _grades.add(grade);
    }
  }

  Future<Grade?> getGrade(String assignmentId, String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _grades.firstWhere(
        (grade) =>
            grade.assignmentId == assignmentId && grade.studentId == studentId,
      );
    } catch (e) {
      return null;
    }
  }

  Future<List<Grade>> getGradesByStudentId(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _grades.where((grade) => grade.studentId == studentId).toList();
  }

  bool _isStudentEnrolledInCourse(String studentId, String courseId) {
    // In a real implementation, this would check the course enrollment
    return true;
  }
}
