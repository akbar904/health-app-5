import 'package:gyde_app/models/user.dart';
import 'package:gyde_app/utils/enums/role_enum.dart';

class AuthService {
  User? _currentUser;
  User? get currentUser => _currentUser;

  // Mock data
  final Map<String, String> _userCredentials = {
    'admin@example.com': 'admin123',
    'teacher@example.com': 'teacher123',
    'student@example.com': 'student123',
  };

  Future<User?> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (!_userCredentials.containsKey(email) ||
        _userCredentials[email] != password) {
      throw Exception('Invalid email or password');
    }

    _currentUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: 'Test User',
      role: email.contains('admin')
          ? UserRole.admin
          : email.contains('teacher')
              ? UserRole.teacher
              : UserRole.student,
      gradeLevel: GradeLevel.none,
    );

    return _currentUser;
  }

  Future<User> register(
      String email, String password, String name, UserRole role) async {
    await Future.delayed(const Duration(seconds: 1));

    if (_userCredentials.containsKey(email)) {
      throw Exception('Email already exists');
    }

    _userCredentials[email] = password;
    _currentUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      role: role,
      gradeLevel: GradeLevel.none,
    );

    return _currentUser!;
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    if (!_userCredentials.containsKey(email)) {
      throw Exception('Email not found');
    }
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_currentUser == null) {
      throw Exception('No user logged in');
    }
    if (_userCredentials[_currentUser!.email] != currentPassword) {
      throw Exception('Current password is incorrect');
    }
    _userCredentials[_currentUser!.email] = newPassword;
  }

  Future<bool> isEmailVerified() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  Future<void> sendEmailVerification() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  bool isAuthenticated() {
    return _currentUser != null;
  }
}
