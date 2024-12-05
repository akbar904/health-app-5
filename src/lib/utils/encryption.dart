import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:crypto/crypto.dart';

class EncryptionService {
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static String encryptData(String data, String key) {
    try {
      final keyBytes = utf8.encode(key);
      final dataBytes = utf8.encode(data);
      final hmac = Hmac(sha256, keyBytes);
      final digest = hmac.convert(dataBytes);
      return base64Encode(digest.bytes);
    } catch (e) {
      debugPrint('Encryption error: $e');
      throw Exception('Failed to encrypt data');
    }
  }

  static bool verifyPassword(String password, String hashedPassword) {
    final computedHash = hashPassword(password);
    return computedHash == hashedPassword;
  }

  static Uint8List generateSecureKey() {
    final random = List<int>.generate(32, (i) => DateTime.now().microsecondsSinceEpoch % 256);
    return Uint8List.fromList(random);
  }

  static String encryptSensitiveData(String data) {
    final key = generateSecureKey();
    final encrypted = encryptData(data, base64Encode(key));
    return encrypted;
  }
}