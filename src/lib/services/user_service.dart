import 'package:gyde_app/models/user.dart';
import 'package:gyde_app/utils/enums/role_enum.dart';

class UserService {
  // Mock data
  final List<User> _users = [
    User(
      id: '1',
      email: 'admin@example.com',
      name: 'Admin User',
      role: UserRole.admin,
      gradeLevel: GradeLevel.none,
    ),
    User(
      id: '2',
      email: 'teacher@example.com',
      name: 'Teacher User',
      role: UserRole.teacher,
      gradeLevel: GradeLevel.none,
    ),
    User(
      id: '3',
      email: 'student@example.com',
      name: 'Student User',
      role: UserRole.student,
      gradeLevel: GradeLevel.grade8,
    ),
  ];

  Future<List<User>> getAllUsers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _users;
  }

  Future<User?> getUserById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<User?> getUserByEmail(String email) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _users.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  Future<void> createUser(User user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _users.add(user);
  }

  Future<void> updateUser(User user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
    }
  }

  Future<void> deleteUser(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _users.removeWhere((user) => user.id == id);
  }

  Future<List<User>> getUsersByRole(UserRole role) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _users.where((user) => user.role == role).toList();
  }

  Future<List<User>> searchUsers(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _users
        .where((user) =>
            user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> linkParentToStudent(String parentId, String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final studentIndex = _users.indexWhere((user) => user.id == studentId);
    if (studentIndex != -1) {
      final student = _users[studentIndex];
      if (student.role != UserRole.student) {
        throw Exception('User is not a student');
      }
      _users[studentIndex] = student.copyWith(parentId: parentId);
    }
  }

  Future<List<User>> getStudentsByParentId(String parentId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _users
        .where((user) =>
            user.role == UserRole.student && user.parentId == parentId)
        .toList();
  }

  Future<bool> isEmailAvailable(String email) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return !_users.any((user) => user.email == email);
  }
}
