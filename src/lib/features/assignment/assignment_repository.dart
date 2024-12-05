import '../../models/assignment.dart';

class AssignmentRepository {
  // Mock data for demonstration
  final List<Assignment> _assignments = [
    Assignment(
      id: '1',
      title: 'Math Homework',
      description: 'Complete exercises 1-10',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      courseId: '1',
      status: 'pending',
      grade: null,
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
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return _assignments;
  }

  Future<Assignment> getAssignment(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    return _assignments.firstWhere(
      (a) => a.id == id,
      orElse: () => throw Exception('Assignment not found'),
    );
  }

  Future<void> createAssignment(Assignment assignment) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    _assignments.add(assignment);
  }

  Future<void> updateAssignment(Assignment assignment) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    final index = _assignments.indexWhere((a) => a.id == assignment.id);
    if (index != -1) {
      _assignments[index] = assignment;
    } else {
      throw Exception('Assignment not found');
    }
  }

  Future<void> deleteAssignment(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    _assignments.removeWhere((a) => a.id == id);
  }

  Future<void> submitAssignment(String id, String submission) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    final index = _assignments.indexWhere((a) => a.id == id);
    if (index != -1) {
      _assignments[index] = _assignments[index].copyWith(
        status: 'submitted',
        submission: submission,
      );
    } else {
      throw Exception('Assignment not found');
    }
  }

  Future<void> gradeAssignment(String id, double grade, String feedback) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    final index = _assignments.indexWhere((a) => a.id == id);
    if (index != -1) {
      _assignments[index] = _assignments[index].copyWith(
        grade: grade,
        feedback: feedback,
        status: 'graded',
      );
    } else {
      throw Exception('Assignment not found');
    }
  }
}