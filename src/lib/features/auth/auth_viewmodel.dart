import 'package:stacked/stacked.dart';
import '../../services/auth_service.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../services/user_service.dart';

class AuthViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _userService = locator<UserService>();
  
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _selectedRole = 'student';
  bool _rememberMe = false;

  String get selectedRole => _selectedRole;
  bool get rememberMe => _rememberMe;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  void setRole(String? role) {
    if (role != null) {
      _selectedRole = role;
      notifyListeners();
    }
  }

  void setRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  Future<void> login() async {
    if (_email.isEmpty || _password.isEmpty) {
      setError('Please fill in all fields');
      return;
    }

    setBusy(true);
    try {
      final user = await _authService.login(_email, _password, _rememberMe);
      await _userService.setCurrentUser(user);
      // Navigate based on user role
      switch (user.role) {
        case 'admin':
          // Navigate to admin dashboard
          break;
        case 'teacher':
          // Navigate to teacher dashboard
          break;
        case 'student':
          // Navigate to student dashboard
          break;
        case 'parent':
          // Navigate to parent dashboard
          break;
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> register() async {
    if (_email.isEmpty || _password.isEmpty || _confirmPassword.isEmpty) {
      setError('Please fill in all fields');
      return;
    }

    if (_password != _confirmPassword) {
      setError('Passwords do not match');
      return;
    }

    setBusy(true);
    try {
      await _authService.register(_email, _password, _selectedRole);
      // Navigate to login view
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> resetPassword() async {
    if (_email.isEmpty) {
      setError('Please enter your email address');
      return;
    }

    setBusy(true);
    try {
      await _authService.resetPassword(_email);
      // Show success message
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void navigateToLogin() {
    // Navigate to login view
  }

  void navigateToRegister() {
    // Navigate to register view
  }

  void navigateToForgotPassword() {
    // Navigate to forgot password view
  }
}