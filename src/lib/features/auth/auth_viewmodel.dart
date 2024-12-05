import 'package:stacked/stacked.dart';
import '../../services/authentication_service.dart';
import '../../models/user.dart';

class AuthViewModel extends BaseViewModel {
  final AuthenticationService _authService;

  AuthViewModel(this._authService);

  User? _currentUser;
  User? get currentUser => _currentUser;

  Future<void> initialize() async {
    setBusy(true);
    try {
      _currentUser = await _authService.getCurrentUser();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<bool> login(String email, String password) async {
    setBusy(true);
    try {
      _currentUser = await _authService.login(email, password);
      notifyListeners();
      return true;
    } catch (e) {
      setError(e);
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> register(Map<String, dynamic> userData) async {
    setBusy(true);
    try {
      _currentUser = await _authService.register(userData);
      notifyListeners();
      return true;
    } catch (e) {
      setError(e);
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<void> logout() async {
    setBusy(true);
    try {
      await _authService.logout();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<bool> resetPassword(String email) async {
    setBusy(true);
    try {
      await _authService.resetPassword(email);
      return true;
    } catch (e) {
      setError(e);
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> verifyEmail(String token) async {
    setBusy(true);
    try {
      await _authService.verifyEmail(token);
      return true;
    } catch (e) {
      setError(e);
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> changePassword(String currentPassword, String newPassword) async {
    setBusy(true);
    try {
      await _authService.changePassword(currentPassword, newPassword);
      return true;
    } catch (e) {
      setError(e);
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<bool> linkParentAccount(String parentEmail, String studentId) async {
    setBusy(true);
    try {
      await _authService.linkParentAccount(parentEmail, studentId);
      return true;
    } catch (e) {
      setError(e);
      return false;
    } finally {
      setBusy(false);
    }
  }

  void navigateToLogin() {
    // Navigation logic implemented through router
  }

  void navigateToRegister() {
    // Navigation logic implemented through router
  }

  bool isAuthenticated() {
    return _currentUser != null;
  }

  bool hasRole(UserRole role) {
    return _currentUser?.role == role;
  }
}