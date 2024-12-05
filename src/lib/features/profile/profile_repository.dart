import '../../models/user.dart';
import '../../services/user_service.dart';

class ProfileRepository {
  final UserService _userService;

  ProfileRepository(this._userService);

  Future<Map<String, dynamic>> getProfileStats(String userId) async {
    return await _userService.getUserStats(userId);
  }

  Future<void> updateProfile(String userId, Map<String, dynamic> profileData) async {
    await _userService.updateUser(userId, profileData);
  }

  Future<void> updateProfileImage(String userId, String imagePath) async {
    await _userService.updateUserImage(userId, imagePath);
  }

  Future<void> updateNotificationPreferences(
      String userId, Map<String, bool> preferences) async {
    await _userService.updateNotificationPreferences(userId, preferences);
  }

  Future<void> updatePrivacySettings(
      String userId, Map<String, bool> settings) async {
    await _userService.updatePrivacySettings(userId, settings);
  }

  Future<void> linkParentAccount(String studentId, String parentEmail) async {
    await _userService.linkParentAccount(studentId, parentEmail);
  }

  Future<List<User>> getLinkedAccounts(String userId) async {
    return await _userService.getLinkedAccounts(userId);
  }

  Future<void> updateLanguagePreference(String userId, String language) async {
    await _userService.updateLanguagePreference(userId, language);
  }

  Future<void> updateAccessibilitySettings(
      String userId, Map<String, dynamic> settings) async {
    await _userService.updateAccessibilitySettings(userId, settings);
  }

  Future<Map<String, dynamic>> getProfileAnalytics(String userId) async {
    return await _userService.getProfileAnalytics(userId);
  }
}