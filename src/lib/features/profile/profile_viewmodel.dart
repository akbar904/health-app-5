import 'package:stacked/stacked.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';
import '../../app/app.locator.dart';

class ProfileViewModel extends BaseViewModel {
  final _userService = locator<UserService>();

  User? _user;
  User? get user => _user;

  String _newName = '';
  String _newEmail = '';
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  void setNewName(String value) => _newName = value;
  void setNewEmail(String value) => _newEmail = value;
  void setCurrentPassword(String value) => _currentPassword = value;
  void setNewPassword(String value) => _newPassword = value;
  void setConfirmPassword(String value) => _confirmPassword = value;

  Future<void> initialize() async {
    setBusy(true);
    try {
      _user = await _userService.getCurrentUser();
      _newName = _user?.name ?? '';
      _newEmail = _user?.email ?? '';
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateProfile() async {
    if (_user == null) return;

    setBusy(true);
    try {
      final updatedUser = User(
        id: _user!.id,
        name: _newName,
        email: _newEmail,
        role: _user!.role,
      );
      await _userService.updateUser(updatedUser);
      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> changePassword() async {
    if (_newPassword != _confirmPassword) {
      setError('Passwords do not match');
      return;
    }

    setBusy(true);
    try {
      await _userService.changePassword(_currentPassword, _newPassword);
      // Show success message
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  bool get canUpdateProfile {
    if (_user == null) return false;
    return _newName.isNotEmpty && _newEmail.isNotEmpty;
  }

  bool get canChangePassword {
    return _currentPassword.isNotEmpty &&
        _newPassword.isNotEmpty &&
        _confirmPassword.isNotEmpty &&
        _newPassword == _confirmPassword;
  }
}