import 'package:flutter/foundation.dart';
import '../utils/constants.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AnalyticsService {
  final ApiService _apiService;
  final StorageService _storageService;
  
  AnalyticsService({
    required ApiService apiService,
    required StorageService storageService,
  })  : _apiService = apiService,
        _storageService = storageService;

  Future<void> logEvent(String eventName, Map<String, dynamic> parameters) async {
    if (!AppConstants.enableAnalytics) return;

    try {
      await _apiService.post('/analytics/events', {
        'eventName': eventName,
        'parameters': parameters,
        'timestamp': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Error logging analytics event: $e');
    }
  }

  Future<void> logUserAction(String userId, String action) async {
    await logEvent('user_action', {
      'userId': userId,
      'action': action,
    });
  }

  Future<void> logError(String errorType, String errorMessage, StackTrace? stackTrace) async {
    await logEvent('error', {
      'type': errorType,
      'message': errorMessage,
      'stackTrace': stackTrace?.toString(),
    });
  }

  Future<void> logPageView(String pageName) async {
    await logEvent('page_view', {
      'pageName': pageName,
    });
  }

  Future<void> logFeatureUsage(String featureName) async {
    await logEvent('feature_usage', {
      'featureName': featureName,
    });
  }

  Future<Map<String, dynamic>> getMetricData({
    required String userId,
    required String metric,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final response = await _apiService.get('/analytics/metrics/$metric', );
      return response;
    } catch (e) {
      debugPrint('Error fetching metric data: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getUserAnalytics(String userId) async {
    try {
      final response = await _apiService.get('/analytics/users/$userId');
      return response;
    } catch (e) {
      debugPrint('Error fetching user analytics: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getCourseAnalytics(String courseId) async {
    try {
      final response = await _apiService.get('/analytics/courses/$courseId');
      return response;
    } catch (e) {
      debugPrint('Error fetching course analytics: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getSystemAnalytics() async {
    try {
      final response = await _apiService.get('/analytics/system');
      return response;
    } catch (e) {
      debugPrint('Error fetching system analytics: $e');
      return {};
    }
  }

  Future<void> logDashboardAccess(String userId) async {
    await logEvent('dashboard_access', {
      'userId': userId,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<void> logAssignmentSubmission(String userId, String assignmentId) async {
    await logEvent('assignment_submission', {
      'userId': userId,
      'assignmentId': assignmentId,
    });
  }

  Future<void> logGradePosted(String teacherId, String studentId, String assignmentId) async {
    await logEvent('grade_posted', {
      'teacherId': teacherId,
      'studentId': studentId,
      'assignmentId': assignmentId,
    });
  }

  Future<void> logResourceAccess(String userId, String resourceId) async {
    await logEvent('resource_access', {
      'userId': userId,
      'resourceId': resourceId,
    });
  }

  Future<Map<String, dynamic>> getPerformanceMetrics() async {
    try {
      final response = await _apiService.get('/analytics/performance');
      return response;
    } catch (e) {
      debugPrint('Error fetching performance metrics: $e');
      return {};
    }
  }
}