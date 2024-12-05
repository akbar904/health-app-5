import '../models/user.dart';

class UserService {
  // Mock data for demonstration
  final List<User> _users = [
    User(
      id: '1',
      email: 'admin@school.com',
      name: 'Admin User',
      role: 'admin',
      isVerified: true,
    ),
    User(
      id: '2',
      email: 'teacher@school.com',
      name: 'Teacher User',
      role: 'teacher',
      isVerified: true,
    ),
  ];

  User? _currentUser;

  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(seconds: 1));
    return _currentUser;
  }

  Future<void> setCurrentUser(User user) async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = user;
  }

  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return _users;
  }

  Future<User> getUser(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return _users.firstWhere(
      (u) => u.id == id,
      orElse: () => throw Exception('User not found'),
    );
  }

  Future<void> createUser(User user) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_users.any((u) => u.email == user.email)) {
      throw Exception('User already exists');
    }
    _users.add(user);
  }

  Future<void> updateUser(User user) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
    } else {
      throw Exception('User not found');
    }
  }

  Future<void> deleteUser(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    _users.removeWhere((u) => u.id == id);
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_currentUser == null) {
      throw Exception('No user logged in');
    }
    // In a real implementation, verify current password and hash new password
    print('Password changed for user ${_currentUser!.id}');
  }

  Future<List<User>> getUsersByRole(String role) async {
    await Future.delayed(const Duration(seconds: 1));
    return _users.where((u) => u.role == role).toList();
  }

  Future<Map<String, int>> getUserStatistics() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'total': _users.length,
      'admin': _users.where((u) => u.role == 'admin').length,
      'teacher': _users.where((u) => u.role == 'teacher').length,
      'student': _users.where((u) => u.role == 'student').length,
      'parent': _users.where((u) => u.role == 'parent').length,
    };
  }

  Future<List<User>> searchUsers(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    final lowercaseQuery = query.toLowerCase();
    return _users.where((u) {
      return u.name.toLowerCase().contains(lowercaseQuery) ||
          u.email.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}