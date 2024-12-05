import 'package:flutter/foundation.dart';
import '../models/assignment.dart';
import '../services/api_service.dart';
import '../models/grade.dart';

class AssignmentRepository {
  final ApiService _apiService;

  AssignmentRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<Assignment>> getTeacherAssignments(String teacherId) async {
    try {
      final response = await _apiService.get('/assignments/teacher/$teacherId');
      return (response as List)
          .map((json) => Assignment.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint('Error fetching teacher assignments: $e');
      throw Exception('Failed to fetch teacher assignments');
    }
  }

  Future<List<Assignment>> getStudentAssignments(String studentId) async {
    try {
      final response = await _apiService.get('/assignments/student/$studentId');
      return (response as List)
          .map((json) => Assignment.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint('Error fetching student assignments: $e');
      throw Exception('Failed to fetch student assignments');
    }
  }

  Future<Assignment> createAssignment(Assignment assignment) async {
    try {
      final response = await _apiService.post(
        '/assignments',
        assignment.toJson(),
      );
      return Assignment.fromJson(response);
    } catch (e) {
      debugPrint('Error creating assignment: $e');
      throw Exception('Failed to create assignment');
    }
  }

  Future<Assignment> updateAssignment(Assignment assignment) async {
    try {
      final response = await _apiService.put(
        '/assignments/${assignment.id}',
        assignment.toJson(),
      );
      return Assignment.fromJson(response);
    } catch (e) {
      debugPrint('Error updating assignment: $e');
      throw Exception('Failed to update assignment');
    }
  }

  Future<void> deleteAssignment(String assignmentId) async {
    try {
      await _apiService.delete('/assignments/$assignmentId');
    } catch (e) {
      debugPrint('Error deleting assignment: $e');
      throw Exception('Failed to delete assignment');
    }
  }

  Future<void> submitAssignment(
    String assignmentId,
    String studentId,
    String submission,
  ) async {
    try {
      await _apiService.post('/assignments/$assignmentId/submit', {
        'studentId': studentId,
        'submission': submission,
      });
    } catch (e) {
      debugPrint('Error submitting assignment: $e');
      throw Exception('Failed to submit assignment');
    }
  }

  Future<void> gradeAssignment(
    String assignmentId,
    String studentId,
    double grade,
    String feedback,
  ) async {
    try {
      await _apiService.post('/assignments/$assignmentId/grade', {
        'studentId': studentId,
        'grade': grade,
        'feedback': feedback,
      });
    } catch (e) {
      debugPrint('Error grading assignment: $e');
      throw Exception('Failed to grade assignment');
    }
  }

  Future<List<Grade>> getAssignmentGrades(String assignmentId) async {
    try {
      final response = await _apiService.get('/assignments/$assignmentId/grades');
      return (response as List).map((json) => Grade.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching assignment grades: $e');
      throw Exception('Failed to fetch assignment grades');
    }
  }

  Future<Map<String, dynamic>> getAssignmentAnalytics(String assignmentId) async {
    try {
      return await _apiService.get('/assignments/$assignmentId/analytics');
    } catch (e) {
      debugPrint('Error fetching assignment analytics: $e');
      throw Exception('Failed to fetch assignment analytics');
    }
  }

  Future<void> bulkCreateAssignments(List<Assignment> assignments) async {
    try {
      await _apiService.post(
        '/assignments/bulk',
        assignments.map((a) => a.toJson()).toList(),
      );
    } catch (e) {
      debugPrint('Error bulk creating assignments: $e');
      throw Exception('Failed to bulk create assignments');
    }
  }

  Future<void> extendDeadline(
    String assignmentId,
    DateTime newDeadline,
  ) async {
    try {
      await _apiService.put('/assignments/$assignmentId/deadline', {
        'newDeadline': newDeadline.toIso8601String(),
      });
    } catch (e) {
      debugPrint('Error extending deadline: $e');
      throw Exception('Failed to extend deadline');
    }
  }
}