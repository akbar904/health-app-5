import '../../models/user.dart';
import '../../services/authentication_service.dart';

class AuthRepository {
  final AuthenticationService _authService;

  AuthRepository(this._authService);

  Future<User> login(String email, String password) async {
    return await _authService.login(email, password);
  }

  Future<User> register(Map<String, dynamic> userData) async {
    return await _authService.register(userData);
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  Future<void> resetPassword(String email) async {
    await _authService.resetPassword(email);
  }

  Future<void> verifyEmail(String token) async {
    await _authService.verifyEmail(token);
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    await _authService.changePassword(currentPassword, newPassword);
  }

  Future<User?> getCurrentUser() async {
    return await _authService.getCurrentUser();
  }

  Future<void> sendVerificationEmail(String email) async {
    await _authService.sendVerificationEmail(email);
  }

  Future<void> refreshToken() async {
    await _authService.refreshToken();
  }

  Future<void> linkParentAccount(String parentEmail, String studentId) async {
    await _authService.linkParentAccount(parentEmail, studentId);
  }

  bool isAuthenticated() {
    return _authService.isAuthenticated();
  }

  Future<void> updateUserRole(String userId, UserRole newRole) async {
    await _authService.updateUserRole(userId, newRole);
  }
}