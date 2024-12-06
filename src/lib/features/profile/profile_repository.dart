import 'package:gyde_app/models/user.dart';

class ProfileRepository {
  // Mock data
  final Map<String, Map<String, dynamic>> _profileData = {};

  Future<Map<String, dynamic>?> getProfileSettings(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _profileData[userId];
  }

  Future<void> updateProfileSettings(
    String userId,
    Map<String, dynamic> settings,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _profileData[userId] = settings;
  }

  Future<void> updatePreferences(
    String userId,
    Map<String, dynamic> preferences,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final currentData = _profileData[userId] ?? {};
    currentData['preferences'] = preferences;
    _profileData[userId] = currentData;
  }

  Future<void> updateNotificationSettings(
    String userId,
    Map<String, bool> notificationSettings,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final currentData = _profileData[userId] ?? {};
    currentData['notificationSettings'] = notificationSettings;
    _profileData[userId] = currentData;
  }

  Future<void> updateAccessibilitySettings(
    String userId,
    Map<String, dynamic> accessibilitySettings,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final currentData = _profileData[userId] ?? {};
    currentData['accessibilitySettings'] = accessibilitySettings;
    _profileData[userId] = currentData;
  }

  Future<void> updateProfileImage(String userId, String imageUrl) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final currentData = _profileData[userId] ?? {};
    currentData['profileImage'] = imageUrl;
    _profileData[userId] = currentData;
  }

  Future<void> updateThemePreference(String userId, String theme) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final currentData = _profileData[userId] ?? {};
    currentData['theme'] = theme;
    _profileData[userId] = currentData;
  }

  Future<void> updateLanguagePreference(String userId, String language) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final currentData = _profileData[userId] ?? {};
    currentData['language'] = language;
    _profileData[userId] = currentData;
  }
}
