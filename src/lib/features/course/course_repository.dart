import 'package:flutter/foundation.dart';
import '../../models/course.dart';
import '../../services/api_service.dart';

class CourseRepository {
  final ApiService _apiService;

  CourseRepository({required ApiService apiService}) : _apiService = apiService;

  Future<List<Course>> getAllCourses() async {
    try {
      final response = await _apiService.get('/courses');
      return (response as List).map((json) => Course.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching all courses: $e');
      throw Exception('Failed to fetch courses');
    }
  }

  Future<Course> getCourseById(String courseId) async {
    try {
      final response = await _apiService.get('/courses/$courseId');
      return Course.fromJson(response);
    } catch (e) {
      debugPrint('Error fetching course by ID: $e');
      throw Exception('Failed to fetch course');
    }
  }

  Future<List<Course>> getTeacherCourses(String teacherId) async {
    try {
      final response = await _apiService.get('/courses/teacher/$teacherId');
      return (response as List).map((json) => Course.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching teacher courses: $e');
      throw Exception('Failed to fetch teacher courses');
    }
  }

  Future<List<Course>> getEnrolledCourses(String studentId) async {
    try {
      final response = await _apiService.get('/courses/student/$studentId');
      return (response as List).map((json) => Course.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching enrolled courses: $e');
      throw Exception('Failed to fetch enrolled courses');
    }
  }

  Future<Course> createCourse(Course course) async {
    try {
      final response = await _apiService.post('/courses', course.toJson());
      return Course.fromJson(response);
    } catch (e) {
      debugPrint('Error creating course: $e');
      throw Exception('Failed to create course');
    }
  }

  Future<Course> updateCourse(Course course) async {
    try {
      final response = await _apiService.put(
        '/courses/${course.id}',
        course.toJson(),
      );
      return Course.fromJson(response);
    } catch (e) {
      debugPrint('Error updating course: $e');
      throw Exception('Failed to update course');
    }
  }

  Future<void> deleteCourse(String courseId) async {
    try {
      await _apiService.delete('/courses/$courseId');
    } catch (e) {
      debugPrint('Error deleting course: $e');
      throw Exception('Failed to delete course');
    }
  }

  Future<void> enrollStudent(String courseId, String studentId) async {
    try {
      await _apiService.post('/courses/$courseId/enroll', {
        'studentId': studentId,
      });
    } catch (e) {
      debugPrint('Error enrolling student: $e');
      throw Exception('Failed to enroll student');
    }
  }

  Future<void> unenrollStudent(String courseId, String studentId) async {
    try {
      await _apiService.delete('/courses/$courseId/enroll/$studentId');
    } catch (e) {
      debugPrint('Error unenrolling student: $e');
      throw Exception('Failed to unenroll student');
    }
  }

  Future<List<Map<String, dynamic>>> getCourseResources(String courseId) async {
    try {
      final response = await _apiService.get('/courses/$courseId/resources');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('Error fetching course resources: $e');
      throw Exception('Failed to fetch course resources');
    }
  }

  Future<void> addCourseResource(
    String courseId,
    Map<String, dynamic> resource,
  ) async {
    try {
      await _apiService.post('/courses/$courseId/resources', resource);
    } catch (e) {
      debugPrint('Error adding course resource: $e');
      throw Exception('Failed to add course resource');
    }
  }

  Future<void> updateCourseSchedule(
    String courseId,
    Map<String, dynamic> schedule,
  ) async {
    try {
      await _apiService.put('/courses/$courseId/schedule', schedule);
    } catch (e) {
      debugPrint('Error updating course schedule: $e');
      throw Exception('Failed to update course schedule');
    }
  }

  Future<Map<String, dynamic>> getCourseAnalytics(String courseId) async {
    try {
      return await _apiService.get('/courses/$courseId/analytics');
    } catch (e) {
      debugPrint('Error fetching course analytics: $e');
      throw Exception('Failed to fetch course analytics');
    }
  }

  Future<void> archiveCourse(String courseId) async {
    try {
      await _apiService.put('/courses/$courseId/archive', {});
    } catch (e) {
      debugPrint('Error archiving course: $e');
      throw Exception('Failed to archive course');
    }
  }

  Future<void> restoreCourse(String courseId) async {
    try {
      await _apiService.put('/courses/$courseId/restore', {});
    } catch (e) {
      debugPrint('Error restoring course: $e');
      throw Exception('Failed to restore course');
    }
  }
}