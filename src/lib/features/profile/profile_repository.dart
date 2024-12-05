import 'package:flutter/foundation.dart';
import '../../models/user.dart';
import '../../services/api_service.dart';
import '../../services/storage_service.dart';

class ProfileRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  ProfileRepository({
    required ApiService apiService,
    required StorageService storageService,
  })  : _apiService = apiService,
        _storageService = storageService;

  Future<User> getProfile(String userId) async {
    try {
      final response = await _apiService.get('/profile/$userId');
      return User.fromJson(response);
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      throw Exception('Failed to fetch profile');
    }
  }

  Future<void> updateProfile(String userId, Map<String, dynamic> profileData) async {
    try {
      await _apiService.put('/profile/$userId', profileData);
      
      // Update cached user data
      final currentUser = await _storageService.getUser();
      if (currentUser != null && currentUser.id == userId) {
        final updatedUser = currentUser.copyWith(
          name: profileData['name'],
          email: profileData['email'],
          avatarUrl: profileData['avatarUrl'],
          preferences: profileData['preferences'],
        );
        await _storageService.saveUser(updatedUser);
      }
    } catch (e) {
      debugPrint('Error updating profile: $e');
      throw Exception('Failed to update profile');
    }
  }

  Future<void> updateAvatar(String userId, String avatarPath) async {
    try {
      final formData = {
        'avatar': await _apiService.uploadFile(avatarPath),
      };
      await _apiService.put('/profile/$userId/avatar', formData);
    } catch (e) {
      debugPrint('Error updating avatar: $e');
      throw Exception('Failed to update avatar');
    }
  }

  Future<void> updatePreferences(String userId, Map<String, dynamic> preferences) async {
    try {
      await _apiService.put('/profile/$userId/preferences', preferences);
    } catch (e) {
      debugPrint('Error updating preferences: $e');
      throw Exception('Failed to update preferences');
    }
  }

  Future<List<User>> getLinkedAccounts(String userId) async {
    try {
      final response = await _apiService.get('/profile/$userId/linked-accounts');
      return (response as List).map((json) => User.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching linked accounts: $e');
      throw Exception('Failed to fetch linked accounts');
    }
  }

  Future<void> linkAccount(String userId, String targetUserId) async {
    try {
      await _apiService.post('/profile/$userId/link', {
        'targetUserId': targetUserId,
      });
    } catch (e) {
      debugPrint('Error linking account: $e');
      throw Exception('Failed to link account');
    }
  }

  Future<void> unlinkAccount(String userId, String targetUserId) async {
    try {
      await _apiService.delete('/profile/$userId/link/$targetUserId');
    } catch (e) {
      debugPrint('Error unlinking account: $e');
      throw Exception('Failed to unlink account');
    }
  }

  Future<Map<String, dynamic>> getProfileStats(String userId) async {
    try {
      return await _apiService.get('/profile/$userId/stats');
    } catch (e) {
      debugPrint('Error fetching profile stats: $e');
      throw Exception('Failed to fetch profile statistics');
    }
  }

  Future<void> updateNotificationSettings(
    String userId,
    Map<String, bool> notificationSettings,
  ) async {
    try {
      await _apiService.put(
        '/profile/$userId/notifications',
        notificationSettings,
      );
    } catch (e) {
      debugPrint('Error updating notification settings: $e');
      throw Exception('Failed to update notification settings');
    }
  }

  Future<void> deleteProfile(String userId) async {
    try {
      await _apiService.delete('/profile/$userId');
      await _storageService.clearUser();
    } catch (e) {
      debugPrint('Error deleting profile: $e');
      throw Exception('Failed to delete profile');
    }
  }
}