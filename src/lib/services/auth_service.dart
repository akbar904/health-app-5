import '../models/user.dart';

class AuthService {
  // Mock data for demonstration
  final List<User> _users = [
    User(
      id: '1',
      email: 'admin@example.com',
      role: 'admin',
      name: 'Admin User',
    ),
    User(
      id: '2',
      email: 'teacher@example.com',
      role: 'teacher',
      name: 'Teacher User',
    ),
    User(
      id: '3',
      email: 'student@example.com',
      role: 'student',
      name: 'Student User',
    ),
  ];

  Future<User> login(String email, String password, bool rememberMe) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock login logic
    final user = _users.firstWhere(
      (u) => u.email == email,
      orElse: () => throw Exception('Invalid credentials'),
    );
    
    return user;
  }

  Future<void> register(String email, String password, String role) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Check if user already exists
    if (_users.any((u) => u.email == email)) {
      throw Exception('User already exists');
    }
    
    // Mock user creation
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      role: role,
      name: 'New User',
    );
    
    _users.add(newUser);
  }

  Future<void> resetPassword(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Check if user exists
    if (!_users.any((u) => u.email == email)) {
      throw Exception('User not found');
    }
    
    // Mock password reset email
    print('Password reset email sent to $email');
  }

  Future<void> logout() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock logout logic
    print('User logged out');
  }

  Future<void> verifyEmail(String token) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock email verification
    print('Email verified with token: $token');
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock password change
    print('Password changed successfully');
  }

  Future<bool> isAuthenticated() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock authentication check
    return true;
  }
}