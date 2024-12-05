import '../../services/analytics_service.dart';
import '../../services/user_service.dart';

class DashboardRepository {
  final AnalyticsService _analyticsService;
  final UserService _userService;

  DashboardRepository(this._analyticsService, this._userService);

  Future<Map<String, dynamic>> getStudentDashboardData(String studentId) async {
    final stats = await _analyticsService.getStudentStats(studentId);
    final userData = await _userService.getUserById(studentId);
    return {
      ...stats,
      'user': userData,
    };
  }

  Future<Map<String, dynamic>> getTeacherDashboardData(String teacherId) async {
    final stats = await _analyticsService.getTeacherStats(teacherId);
    final userData = await _userService.getUserById(teacherId);
    return {
      ...stats,
      'user': userData,
    };
  }

  Future<Map<String, dynamic>> getAdminDashboardData() async {
    final stats = await _analyticsService.getSystemStats();
    return stats;
  }

  Future<Map<String, dynamic>> getParentDashboardData(String parentId) async {
    final stats = await _analyticsService.getParentStats(parentId);
    final userData = await _userService.getUserById(parentId);
    return {
      ...stats,
      'user': userData,
    };
  }

  Future<List<Map<String, dynamic>>> getRecentActivities(String userId) async {
    // Implementation for getting recent activities
    return [];
  }

  Future<Map<String, dynamic>> getDashboardAnalytics(String userId) async {
    // Implementation for getting dashboard analytics
    return {};
  }

  Future<void> updateDashboardPreferences(
      String userId, Map<String, dynamic> preferences) async {
    await _userService.updateUser(userId, {'dashboardPreferences': preferences});
  }
}