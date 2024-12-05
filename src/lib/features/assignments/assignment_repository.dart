import '../../models/assignment.dart';
import '../../services/assignment_service.dart';

class AssignmentRepository {
  final AssignmentService _assignmentService;

  AssignmentRepository(this._assignmentService);

  Future<List<Assignment>> getAllAssignments() async {
    return await _assignmentService.getAllAssignments();
  }

  Future<Assignment> getAssignmentById(String id) async {
    return await _assignmentService.getAssignmentById(id);
  }

  Future<void> createAssignment(Assignment assignment) async {
    await _assignmentService.createAssignment(assignment);
  }

  Future<void> updateAssignment(Assignment assignment) async {
    await _assignmentService.updateAssignment(assignment);
  }

  Future<void> deleteAssignment(String id) async {
    await _assignmentService.deleteAssignment(id);
  }

  Future<void> submitAssignment(String assignmentId, String studentId, Map<String, dynamic> submission) async {
    await _assignmentService.submitAssignment(assignmentId, studentId, submission);
  }

  Future<void> gradeAssignment(String assignmentId, String studentId, double grade, String feedback) async {
    await _assignmentService.gradeAssignment(assignmentId, studentId, grade, feedback);
  }

  Future<List<Assignment>> getAssignmentsByStudent(String studentId) async {
    return await _assignmentService.getAssignmentsByStudent(studentId);
  }

  Future<List<Assignment>> getAssignmentsByTeacher(String teacherId) async {
    return await _assignmentService.getAssignmentsByTeacher(teacherId);
  }

  Future<List<Assignment>> getAssignmentsByCourse(String courseId) async {
    return await _assignmentService.getAssignmentsByCourse(courseId);
  }

  Future<Map<String, dynamic>> getAssignmentStatistics(String assignmentId) async {
    return await _assignmentService.getAssignmentStatistics(assignmentId);
  }
}

