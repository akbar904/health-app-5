import '../../../models/user.dart';
import '../../../services/user_service.dart';

class UserManagementRepository {
  final UserService _userService;

  UserManagementRepository(this._userService);

  Future<List<User>> getAllUsers() async {
    return await _userService.getAllUsers();
  }

  Future<User> getUserById(String id) async {
    return await _userService.getUserById(id);
  }

  Future<void> createUser(Map<String, dynamic> userData) async {
    await _userService.createUser(userData);
  }

  Future<void> updateUser(String userId, Map<String, dynamic> userData) async {
    await _userService.updateUser(userId, userData);
  }

  Future<void> deleteUser(String userId) async {
    await _userService.deleteUser(userId);
  }

  Future<void> resetUserPassword(String userId) async {
    await _userService.resetUserPassword(userId);
  }

  Future<List<User>> getUsersByRole(UserRole role) async {
    return await _userService.getUsersByRole(role);
  }

  Future<void> updateUserRole(String userId, UserRole newRole) async {
    await _userService.updateUserRole(userId, newRole);
  }

  Future<void> deactivateUser(String userId) async {
    await _userService.updateUser(userId, {'isActive': false});
  }

  Future<void> activateUser(String userId) async {
    await _userService.updateUser(userId, {'isActive': true});
  }

  Future<List<User>> searchUsers(String query) async {
    return await _userService.searchUsers(query);
  }

  Future<Map<String, dynamic>> getUserAnalytics(String userId) async {
    return await _userService.getUserAnalytics(userId);
  }

  Future<void> updateUserPermissions(
      String userId, List<String> permissions) async {
    await _userService.updateUserPermissions(userId, permissions);
  }

  Future<List<String>> getUserPermissions(String userId) async {
    return await _userService.getUserPermissions(userId);
  }
}