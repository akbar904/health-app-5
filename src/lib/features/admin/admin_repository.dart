import 'package:flutter/foundation.dart';
import '../../services/api_service.dart';
import '../../models/user.dart';

class AdminRepository {
  final ApiService _apiService;

  AdminRepository({required ApiService apiService}) : _apiService = apiService;

  Future<void> createUser(Map<String, dynamic> userData) async {
    try {
      await _apiService.post('/admin/users', userData);
    } catch (e) {
      debugPrint('Error creating user: $e');
      throw Exception('Failed to create user');
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> userData) async {
    try {
      await _apiService.put('/admin/users/$userId', userData);
    } catch (e) {
      debugPrint('Error updating user: $e');
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _apiService.delete('/admin/users/$userId');
    } catch (e) {
      debugPrint('Error deleting user: $e');
      throw Exception('Failed to delete user');
    }
  }

  Future<Map<String, dynamic>> getSystemSettings() async {
    try {
      return await _apiService.get('/admin/settings');
    } catch (e) {
      debugPrint('Error getting system settings: $e');
      throw Exception('Failed to get system settings');
    }
  }

  Future<void> updateSystemSetting(String key, dynamic value) async {
    try {
      await _apiService.put('/admin/settings/$key', {'value': value});
    } catch (e) {
      debugPrint('Error updating system setting: $e');
      throw Exception('Failed to update system setting');
    }
  }

  Future<Map<String, dynamic>> runSecurityAudit() async {
    try {
      return await _apiService.post('/admin/security/audit', {});
    } catch (e) {
      debugPrint('Error running security audit: $e');
      throw Exception('Failed to run security audit');
    }
  }

  Future<void> backupDatabase() async {
    try {
      await _apiService.post('/admin/backup', {});
    } catch (e) {
      debugPrint('Error backing up database: $e');
      throw Exception('Failed to backup database');
    }
  }

  Future<Map<String, dynamic>> getApiConfiguration() async {
    try {
      return await _apiService.get('/admin/api-config');
    } catch (e) {
      debugPrint('Error getting API configuration: $e');
      throw Exception('Failed to get API configuration');
    }
  }

  Future<Map<String, dynamic>> getExternalServicesConfig() async {
    try {
      return await _apiService.get('/admin/external-services');
    } catch (e) {
      debugPrint('Error getting external services config: $e');
      throw Exception('Failed to get external services config');
    }
  }

  Future<Map<String, dynamic>> getSystemMetrics() async {
    try {
      return await _apiService.get('/admin/metrics');
    } catch (e) {
      debugPrint('Error getting system metrics: $e');
      throw Exception('Failed to get system metrics');
    }
  }

  Future<void> updatePermissions(String userId, List<String> permissions) async {
    try {
      await _apiService.put('/admin/users/$userId/permissions', {
        'permissions': permissions,
      });
    } catch (e) {
      debugPrint('Error updating permissions: $e');
      throw Exception('Failed to update permissions');
    }
  }

  Future<void> configureIntegration(
    String integrationId,
    Map<String, dynamic> config,
  ) async {
    try {
      await _apiService.put(
        '/admin/integrations/$integrationId',
        config,
      );
    } catch (e) {
      debugPrint('Error configuring integration: $e');
      throw Exception('Failed to configure integration');
    }
  }

  Future<List<Map<String, dynamic>>> getAuditLogs({
    DateTime? startDate,
    DateTime? endDate,
    String? userId,
    String? action,
  }) async {
    try {
      final queryParams = {
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
        if (userId != null) 'userId': userId,
        if (action != null) 'action': action,
      };

      final response = await _apiService.get(
        '/admin/audit-logs',
        queryParams: queryParams,
      );
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('Error getting audit logs: $e');
      throw Exception('Failed to get audit logs');
    }
  }

  Future<void> restoreBackup(String backupId) async {
    try {
      await _apiService.post('/admin/restore/$backupId', {});
    } catch (e) {
      debugPrint('Error restoring backup: $e');
      throw Exception('Failed to restore backup');
    }
  }

  Future<Map<String, dynamic>> getSystemHealth() async {
    try {
      return await _apiService.get('/admin/health');
    } catch (e) {
      debugPrint('Error getting system health: $e');
      throw Exception('Failed to get system health');
    }
  }

  Future<void> purgeData(String dataType, {DateTime? olderThan}) async {
    try {
      await _apiService.delete(
        '/admin/purge/$dataType',
        queryParams: olderThan != null
            ? {'olderThan': olderThan.toIso8601String()}
            : null,
      );
    } catch (e) {
      debugPrint('Error purging data: $e');
      throw Exception('Failed to purge data');
    }
  }
}