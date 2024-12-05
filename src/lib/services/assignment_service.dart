import '../models/assignment.dart';

class AssignmentService {
  // Mock data for demonstration
  final List<Assignment> _assignments = [
    Assignment(
      id: '1',
      title: 'Math Homework',
      description: 'Complete exercises 1-10',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      courseId: '1',
      status: 'pending',
    ),
    Assignment(
      id: '2',
      title: 'Science Project',
      description: 'Create a solar system model',
      dueDate: DateTime.now().add(const Duration(days: 14)),
      courseId: '2',
      status: 'submitted',
      grade: 85,
    ),
  ];

  Future<List<Assignment>> getAssignments() async {
    await Future.delayed(const Duration(seconds: 1));
    return _assignments;
  }

  Future<Assignment> getAssignment(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return _assignments.firstWhere(
      (a) => a.id == id,
      orElse: () => throw Exception('Assignment not found'),
    );
  }

  Future<void> createAssignment(Assignment assignment) async {
    await Future.delayed(const Duration(seconds: 1));
    _assignments.add(assignment);
  }

  Future<void> updateAssignment(Assignment assignment) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _assignments.indexWhere((a) => a.id == assignment.id);
    if (index != -1) {
      _assignments[index] = assignment;
    } else {
      throw Exception('Assignment not found');
    }
  }

  Future<void> deleteAssignment(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    _assignments.removeWhere((a) => a.id == id);
  }

  Future<void> submitAssignment(String id, String submission) async {
    await Future.delayed(const Duration(seconds: 1));
    final assignment = await getAssignment(id);
    final updatedAssignment = assignment.copyWith(
      status: 'submitted',
      submission: submission,
    );
    await updateAssignment(updatedAssignment);
  }

  Future<void> gradeAssignment(String id, double grade, String feedback) async {
    await Future.delayed(const Duration(seconds: 1));
    final assignment = await getAssignment(id);
    final updatedAssignment = assignment.copyWith(
      status: 'graded',
      grade: grade,
      feedback: feedback,
    );
    await updateAssignment(updatedAssignment);
  }

  Future<List<Assignment>> getStudentAssignments(String studentId) async {
    await Future.delayed(const Duration(seconds: 1));
    return _assignments.where((a) => a.id == studentId).toList();
  }

  Future<List<Assignment>> getCourseAssignments(String courseId) async {
    await Future.delayed(const Duration(seconds: 1));
    return _assignments.where((a) => a.courseId == courseId).toList();
  }

  Future<Map<String, List<Assignment>>> getAssignmentsByStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'pending': _assignments.where((a) => a.status == 'pending').toList(),
      'submitted': _assignments.where((a) => a.status == 'submitted').toList(),
      'graded': _assignments.where((a) => a.status == 'graded').toList(),
    };
  }
}