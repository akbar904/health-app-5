import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../utils/encryption.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  final ApiService _apiService;
  final StorageService _storageService;
  final EncryptionUtil _encryptionUtil;
  
  AuthService({
    required ApiService apiService,
    required StorageService storageService,
    required EncryptionUtil encryptionUtil,
  })  : _apiService = apiService,
        _storageService = storageService,
        _encryptionUtil = encryptionUtil;

  Future<User> register({
    required String email,
    required String password,
    required String name,
    required UserRole role,
    String? parentEmail,
  }) async {
    try {
      final hashedPassword = await _encryptionUtil.hashPassword(password);
      
      final response = await _apiService.post('/auth/register', {
        'email': email,
        'password': hashedPassword,
        'name': name,
        'role': role.toString(),
        if (parentEmail != null) 'parentEmail': parentEmail,
      });

      final user = User.fromJson(response);
      await _storageService.saveUser(user);
      return user;
    } catch (e) {
      debugPrint('Registration error: $e');
      throw Exception('Failed to register user');
    }
  }

  Future<User> login(String email, String password) async {
    try {
      final hashedPassword = await _encryptionUtil.hashPassword(password);
      
      final response = await _apiService.post('/auth/login', {
        'email': email,
        'password': hashedPassword,
      });

      final user = User.fromJson(response);
      await _storageService.saveUser(user);
      if (response['token'] != null) {
        await _storageService.saveToken(response['token']);
      }
      return user;
    } catch (e) {
      debugPrint('Login error: $e');
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.post('/auth/logout', {});
      await _storageService.clearToken();
      await _storageService.clearUser();
    } catch (e) {
      debugPrint('Logout error: $e');
      throw Exception('Failed to logout');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _apiService.post('/auth/reset-password', {
        'email': email,
      });
    } catch (e) {
      debugPrint('Password reset error: $e');
      throw Exception('Failed to reset password');
    }
  }

  Future<void> verifyEmail(String token) async {
    try {
      await _apiService.post('/auth/verify-email', {
        'token': token,
      });
    } catch (e) {
      debugPrint('Email verification error: $e');
      throw Exception('Failed to verify email');
    }
  }

  Future<void> sendVerificationEmail(String email) async {
    try {
      await _apiService.post('/auth/send-verification', {
        'email': email,
      });
    } catch (e) {
      debugPrint('Send verification email error: $e');
      throw Exception('Failed to send verification email');
    }
  }

  Future<void> updatePassword(String currentPassword, String newPassword) async {
    try {
      final hashedCurrentPassword = await _encryptionUtil.hashPassword(currentPassword);
      final hashedNewPassword = await _encryptionUtil.hashPassword(newPassword);
      
      await _apiService.post('/auth/update-password', {
        'currentPassword': hashedCurrentPassword,
        'newPassword': hashedNewPassword,
      });
    } catch (e) {
      debugPrint('Password update error: $e');
      throw Exception('Failed to update password');
    }
  }

  Future<bool> checkEmailVerification() async {
    try {
      final response = await _apiService.get('/auth/verification-status');
      return response['isVerified'] ?? false;
    } catch (e) {
      debugPrint('Check email verification error: $e');
      throw Exception('Failed to check email verification status');
    }
  }

  Future<void> refreshToken() async {
    try {
      final response = await _apiService.post('/auth/refresh-token', {});
      if (response['token'] != null) {
        await _storageService.saveToken(response['token']);
      }
    } catch (e) {
      debugPrint('Token refresh error: $e');
      throw Exception('Failed to refresh token');
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      final token = await _storageService.getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> sendPasswordResetCode(String email) async {
    try {
      await _apiService.post('/auth/send-reset-code', {
        'email': email,
      });
    } catch (e) {
      debugPrint('Send reset code error: $e');
      throw Exception('Failed to send reset code');
    }
  }

  Future<void> verifyResetCode(String email, String code) async {
    try {
      await _apiService.post('/auth/verify-reset-code', {
        'email': email,
        'code': code,
      });
    } catch (e) {
      debugPrint('Verify reset code error: $e');
      throw Exception('Failed to verify reset code');
    }
  }

  Future<void> completePasswordReset(
    String email,
    String code,
    String newPassword,
  ) async {
    try {
      final hashedPassword = await _encryptionUtil.hashPassword(newPassword);
      
      await _apiService.post('/auth/complete-reset', {
        'email': email,
        'code': code,
        'newPassword': hashedPassword,
      });
    } catch (e) {
      debugPrint('Complete password reset error: $e');
      throw Exception('Failed to complete password reset');
    }
  }
}