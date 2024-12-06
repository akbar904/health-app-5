import 'package:stacked/stacked.dart';
import 'package:gyde_app/services/auth_service.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/utils/enums/role_enum.dart';

class AuthViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();

  String _email = '';
  String _password = '';
  String _name = '';
  UserRole _selectedRole = UserRole.student;
  bool _isRegistering = false;

  bool get isRegistering => _isRegistering;
  UserRole get selectedRole => _selectedRole;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setRole(UserRole? role) {
    if (role != null) {
      _selectedRole = role;
      notifyListeners();
    }
  }

  void toggleAuthMode() {
    _isRegistering = !_isRegistering;
    notifyListeners();
  }

  Future<void> login() async {
    if (_email.isEmpty || _password.isEmpty) {
      setError('Please fill in all fields');
      return;
    }

    setBusy(true);
    try {
      final user = await _authService.signIn(_email, _password);
      if (user == null) {
        setError('Invalid credentials');
        return;
      }
      // Navigate to appropriate dashboard based on user role
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> register() async {
    if (_email.isEmpty || _password.isEmpty || _name.isEmpty) {
      setError('Please fill in all fields');
      return;
    }

    setBusy(true);
    try {
      await _authService.register(_email, _password, _name, _selectedRole);
      // Navigate to email verification screen or login
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      setError('Please enter your email');
      return;
    }

    setBusy(true);
    try {
      await _authService.resetPassword(email);
      // Show success message
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> verifyEmail() async {
    setBusy(true);
    try {
      await _authService.sendEmailVerification();
      // Show success message
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void showForgotPasswordDialog() {
    // Implementation for showing forgot password dialog
  }
}
