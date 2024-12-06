import 'package:stacked/stacked.dart';
import 'package:gyde_app/models/user.dart';
import 'package:gyde_app/features/profile/profile_repository.dart';
import 'package:gyde_app/services/user_service.dart';
import 'package:gyde_app/app/app.locator.dart';

class ProfileViewModel extends BaseViewModel {
  final _profileRepository = locator<ProfileRepository>();
  final _userService = locator<UserService>();

  User? _user;
  Map<String, dynamic>? _profileSettings;
  bool _isEditing = false;

  User? get user => _user;
  Map<String, dynamic>? get profileSettings => _profileSettings;
  bool get isEditing => _isEditing;

  Future<void> initialize(String userId) async {
    setBusy(true);
    try {
      await Future.wait([
        _loadUser(userId),
        _loadProfileSettings(userId),
      ]);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> _loadUser(String userId) async {
    _user = await _userService.getUserById(userId);
    notifyListeners();
  }

  Future<void> _loadProfileSettings(String userId) async {
    _profileSettings = await _profileRepository.getProfileSettings(userId);
    notifyListeners();
  }

  void toggleEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<void> updateProfile(Map<String, dynamic> updates) async {
    setBusy(true);
    try {
      await _profileRepository.updateProfileSettings(_user!.id, updates);
      _profileSettings = await _profileRepository.getProfileSettings(_user!.id);
      _isEditing = false;
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateNotificationSettings(
    Map<String, bool> notificationSettings,
  ) async {
    setBusy(true);
    try {
      await _profileRepository.updateNotificationSettings(
        _user!.id,
        notificationSettings,
      );
      await _loadProfileSettings(_user!.id);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateAccessibilitySettings(
    Map<String, dynamic> accessibilitySettings,
  ) async {
    setBusy(true);
    try {
      await _profileRepository.updateAccessibilitySettings(
        _user!.id,
        accessibilitySettings,
      );
      await _loadProfileSettings(_user!.id);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateProfileImage(String imageUrl) async {
    setBusy(true);
    try {
      await _profileRepository.updateProfileImage(_user!.id, imageUrl);
      await _loadProfileSettings(_user!.id);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateTheme(String theme) async {
    setBusy(true);
    try {
      await _profileRepository.updateThemePreference(_user!.id, theme);
      await _loadProfileSettings(_user!.id);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateLanguage(String language) async {
    setBusy(true);
    try {
      await _profileRepository.updateLanguagePreference(_user!.id, language);
      await _loadProfileSettings(_user!.id);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}
