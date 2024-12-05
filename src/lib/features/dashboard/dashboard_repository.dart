import 'package:flutter/foundation.dart';
import '../../services/api_service.dart';
import '../../models/user.dart';

class DashboardRepository {
  final ApiService _apiService;

  DashboardRepository({required ApiService apiService}) : _apiService = apiService;

  Future<Map<String, dynamic>> getStudentDashboardData(String studentId) async {
    try {
      final response = await _apiService.get('/dashboard/student/$studentId');
      return response as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error fetching student dashboard data: $e');
      throw Exception('Failed to fetch student dashboard data');
    }
  }

  Future<Map<String, dynamic>> getTeacherDashboardData(String teacherId) async {
    try {
      final response = await _apiService.get('/dashboard/teacher/$teacherId');
      return response as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error fetching teacher dashboard data: $e');
      throw Exception('Failed to fetch teacher dashboard data');
    }
  }

  Future<Map<String, dynamic>> getAdminDashboardData() async {
    try {
      final response = await _apiService.get('/dashboard/admin');
      return response as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error fetching admin dashboard data: $e');
      throw Exception('Failed to fetch admin dashboard data');
    }
  }

  Future<Map<String, dynamic>> getParentDashboardData(String parentId) async {
    try {
      final response = await _apiService.get('/dashboard/parent/$parentId');
      return response as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error fetching parent dashboard data: $e');
      throw Exception('Failed to fetch parent dashboard data');
    }
  }

  Future<List<Map<String, dynamic>>> getRecentActivity(String userId) async {
    try {
      final response = await _apiService.get('/dashboard/activity/$userId');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('Error fetching recent activity: $e');
      throw Exception('Failed to fetch recent activity');
    }
  }

  Future<Map<String, dynamic>> getDashboardAnalytics(
    String userId,
    String role,
  ) async {
    try {
      final response = await _apiService.get(
        '/dashboard/analytics',
        queryParams: {'userId': userId, 'role': role},
      );
      return response as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error fetching dashboard analytics: $e');
      throw Exception('Failed to fetch dashboard analytics');
    }
  }

  Future<void> updateDashboardPreferences(
    String userId,
    Map<String, dynamic> preferences,
  ) async {
    try {
      await _apiService.put(
        '/dashboard/preferences/$userId',
        preferences,
      );
    } catch (e) {
      debugPrint('Error updating dashboard preferences: $e');
      throw Exception('Failed to update dashboard preferences');
    }
  }

  Future<Map<String, dynamic>> getDashboardNotifications(String userId) async {
    try {
      final response = await _apiService.get('/dashboard/notifications/$userId');
      return response as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error fetching dashboard notifications: $e');
      throw Exception('Failed to fetch dashboard notifications');
    }
  }

  Future<void> markNotificationAsRead(String userId, String notificationId) async {
    try {
      await _apiService.put(
        '/dashboard/notifications/$userId/$notificationId/read',
        {},
      );
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
      throw Exception('Failed to mark notification as read');
    }
  }

  Future<void> exportDashboardData({
    required String userId,
    required String format,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _apiService.post(
        '/dashboard/export',
        {
          'userId': userId,
          'format': format,
          'data': data,
        },
      );
    } catch (e) {
      debugPrint('Error exporting dashboard data: $e');
      throw Exception('Failed to export dashboard data');
    }
  }

  Future<Map<String, dynamic>> getPerformanceMetrics(String userId) async {
    try {
      final response = await _apiService.get('/dashboard/performance/$userId');
      return response as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error fetching performance metrics: $e');
      throw Exception('Failed to fetch performance metrics');
    }
  }

  Future<List<Map<String, dynamic>>> getUpcomingEvents(String userId) async {
    try {
      final response = await _apiService.get('/dashboard/events/$userId');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('Error fetching upcoming events: $e');
      throw Exception('Failed to fetch upcoming events');
    }
  }

  Future<Map<String, dynamic>> getResourceUsage(String userId) async {
    try {
      final response = await _apiService.get('/dashboard/resources/$userId');
      return response as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error fetching resource usage: $e');
      throw Exception('Failed to fetch resource usage');
    }
  }
}