import 'package:gyde_app/models/user.dart';

class UserManagementRepository {
  // Mock data
  final List<User> _users = [
    User(
      id: '1',
      email: 'admin@school.com',
      name: 'Admin User',
      role: UserRole.admin,
      gradeLevel: GradeLevel.none,
    ),
    User(
      id: '2',
      email: 'teacher@school.com',
      name: 'Teacher User',
      role: UserRole.teacher,
      gradeLevel: GradeLevel.none,
    ),
    User(
      id: '3',
      email: 'student@school.com',
      name: 'Student User',
      role: UserRole.student,
      gradeLevel: GradeLevel.grade8,
    ),
  ];

  Future<List<User>> getAllUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return _users;
  }

  Future<User?> getUserById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _users.firstWhere((user) => user.id == id);
  }

  Future<void> createUser(User user) async {
    await Future.delayed(const Duration(seconds: 1));
    _users.add(user);
  }

  Future<void> updateUser(User user) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
    }
  }

  Future<void> deleteUser(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    _users.removeWhere((user) => user.id == id);
  }

  Future<List<User>> getUsersByRole(UserRole role) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _users.where((user) => user.role == role).toList();
  }

  Future<void> updateUserRole(String userId, UserRole newRole) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _users.indexWhere((u) => u.id == userId);
    if (index != -1) {
      _users[index] = _users[index].copyWith(role: newRole);
    }
  }

  Future<void> bulkUpdateUsers(List<User> users) async {
    await Future.delayed(const Duration(seconds: 1));
    for (var user in users) {
      final index = _users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        _users[index] = user;
      }
    }
  }

  Future<List<User>> searchUsers(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _users
        .where((user) =>
            user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
