import 'package:gyde_app/models/user.dart';

class AuthRepository {
  // Mock data for demonstration
  final Map<String, User> _users = {
    'teacher@example.com': User(
      id: '1',
      email: 'teacher@example.com',
      name: 'John Doe',
      role: UserRole.teacher,
      gradeLevel: GradeLevel.none,
    ),
    'student@example.com': User(
      id: '2',
      email: 'student@example.com',
      name: 'Jane Smith',
      role: UserRole.student,
      gradeLevel: GradeLevel.grade8,
    ),
  };

  Future<User?> signIn(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return _users[email];
  }

  Future<User> register(String email, String password, String name,
      UserRole role, GradeLevel gradeLevel) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      role: role,
      gradeLevel: gradeLevel,
    );

    _users[email] = user;
    return user;
  }

  Future<void> resetPassword(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real implementation, this would trigger a password reset email
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real implementation, this would update the user's password
  }

  Future<void> signOut() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real implementation, this would clear the user's session
  }

  Future<bool> isEmailVerified(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<void> sendEmailVerification() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real implementation, this would send a verification email
  }
}
