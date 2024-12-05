import 'package:stacked/stacked.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../../models/user.dart';
import '../../utils/validators.dart';

class AuthViewModel extends BaseViewModel {
  final AuthService _authService;
  final UserService _userService;

  AuthViewModel({
    required AuthService authService,
    required UserService userService,
  })  : _authService = authService,
        _userService = userService;

  UserRole _selectedRole = UserRole.student;
  UserRole get selectedRole => _selectedRole;

  bool _isEmailVerified = false;
  bool get isEmailVerified => _isEmailVerified;

  Future<void> register({
    required String email,
    required String password,
    required String name,
    String? parentEmail,
  }) async {
    if (!Validators.isValidEmail(email)) {
      setError('Invalid email format');
      return;
    }

    if (!Validators.isValidPassword(password)) {
      setError('Password must be at least 8 characters long and contain letters and numbers');
      return;
    }

    setBusy(true);
    try {
      final user = await _authService.register(
        email: email,
        password: password,
        name: name,
        role: _selectedRole,
        parentEmail: parentEmail,
      );
      
      await _authService.sendVerificationEmail(email);
      _isEmailVerified = false;
      notifyListeners();
      
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> login(String email, String password) async {
    setBusy(true);
    try {
      final user = await _authService.login(email, password);
      _isEmailVerified = user.isEmailVerified;
      
      if (!_isEmailVerified) {
        setError('Please verify your email before logging in');
        return;
      }
      
      await _userService.setCurrentUser(user);
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> resetPassword(String email) async {
    if (!Validators.isValidEmail(email)) {
      setError('Invalid email format');
      return;
    }

    setBusy(true);
    try {
      await _authService.resetPassword(email);
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> verifyEmail(String token) async {
    setBusy(true);
    try {
      await _authService.verifyEmail(token);
      _isEmailVerified = true;
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> logout() async {
    setBusy(true);
    try {
      await _authService.logout();
      await _userService.clearCurrentUser();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void setSelectedRole(UserRole role) {
    _selectedRole = role;
    notifyListeners();
  }

  Future<void> linkParentAccount(String parentEmail, String studentId) async {
    setBusy(true);
    try {
      await _userService.linkParentToStudent(parentEmail, studentId);
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> unlinkParentAccount(String parentId, String studentId) async {
    setBusy(true);
    try {
      await _userService.unlinkParentFromStudent(parentId, studentId);
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<bool> checkEmailVerification() async {
    try {
      _isEmailVerified = await _authService.checkEmailVerification();
      notifyListeners();
      return _isEmailVerified;
    } catch (e) {
      setError(e.toString());
      return false;
    }
  }

  Future<void> resendVerificationEmail(String email) async {
    setBusy(true);
    try {
      await _authService.sendVerificationEmail(email);
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> updatePassword(String currentPassword, String newPassword) async {
    if (!Validators.isValidPassword(newPassword)) {
      setError('New password must be at least 8 characters long and contain letters and numbers');
      return;
    }

    setBusy(true);
    try {
      await _authService.updatePassword(currentPassword, newPassword);
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }
}