import '../../models/user.dart';

class AuthRepository {
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
    User(
      id: '3',
      email: 'student@school.com',
      name: 'Student User',
      role: 'student',
      isVerified: true,
    ),
  ];

  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return _users.firstWhere(
      (user) => user.email == email,
      orElse: () => throw Exception('Invalid credentials'),
    );
  }

  Future<User> register(String email, String password, String role) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (_users.any((user) => user.email == email)) {
      throw Exception('User already exists');
    }

    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: email.split('@')[0],
      role: role,
      isVerified: false,
    );

    _users.add(newUser);
    return newUser;
  }

  Future<void> sendVerificationEmail(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    print('Verification email sent to $email');
  }

  Future<void> verifyEmail(String token) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = _users.firstWhere(
      (user) => user.id == token,
      orElse: () => throw Exception('Invalid token'),
    );
    user.isVerified = true;
  }

  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    if (!_users.any((user) => user.email == email)) {
      throw Exception('User not found');
    }
    print('Password reset email sent to $email');
  }

  Future<void> changePassword(String userId, String currentPassword, String newPassword) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = _users.firstWhere(
      (user) => user.id == userId,
      orElse: () => throw Exception('User not found'),
    );
    // In a real implementation, verify current password and hash new password
    print('Password changed for user ${user.id}');
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    // Clear session/token
  }

  Future<bool> isEmailVerified(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = _users.firstWhere(
      (user) => user.id == userId,
      orElse: () => throw Exception('User not found'),
    );
    return user.isVerified;
  }

  Future<void> linkParentAccount(String parentUserId, String studentUserId) async {
    await Future.delayed(const Duration(seconds: 1));
    final parent = _users.firstWhere(
      (user) => user.id == parentUserId && user.role == 'parent',
      orElse: () => throw Exception('Parent not found'),
    );
    final student = _users.firstWhere(
      (user) => user.id == studentUserId && user.role == 'student',
      orElse: () => throw Exception('Student not found'),
    );
    // Link accounts
    print('Linked parent ${parent.id} to student ${student.id}');
  }
}