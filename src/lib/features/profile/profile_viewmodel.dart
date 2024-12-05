import 'package:stacked/stacked.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';
import 'profile_repository.dart';

class ProfileViewModel extends BaseViewModel {
  final ProfileRepository _repository;
  final UserService _userService;

  User? _user;
  Map<String, dynamic> _profileStats = {};

  ProfileViewModel(this._repository, this._userService);

  User? get user => _user;
  Map<String, dynamic> get profileStats => _profileStats;

  Future<void> initialize() async {
    setBusy(true);
    try {
      _user = await _userService.getCurrentUser();
      await _loadProfileStats();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> _loadProfileStats() async {
    if (_user == null) return;
    _profileStats = await _repository.getProfileStats(_user!.id);
  }

  Future<void> updateProfile(Map<String, dynamic> profileData) async {
    setBusy(true);
    try {
      await _repository.updateProfile(_user!.id, profileData);
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateProfileImage(String imagePath) async {
    setBusy(true);
    try {
      await _repository.updateProfileImage(_user!.id, imagePath);
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateNotificationPreferences(Map<String, bool> preferences) async {
    setBusy(true);
    try {
      await _repository.updateNotificationPreferences(_user!.id, preferences);
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updatePrivacySettings(Map<String, bool> settings) async {
    setBusy(true);
    try {
      await _repository.updatePrivacySettings(_user!.id, settings);
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> linkParentAccount(String parentEmail) async {
    setBusy(true);
    try {
      await _repository.linkParentAccount(_user!.id, parentEmail);
      await initialize();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  bool canEditProfile() {
    return _userService.hasPermission('edit_profile');
  }

  String getAvatarUrl() {
    return _user?.avatarUrl ?? 'assets/images/default_avatar.png';
  }
}