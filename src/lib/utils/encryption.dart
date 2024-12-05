import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class EncryptionUtil {
  static const _saltLength = 16;
  static const _ivLength = 16;
  static const _keyLength = 32;
  static const _iterations = 1000;

  Future<String> hashPassword(String password) async {
    final salt = _generateRandomBytes(_saltLength);
    final hash = await _pbkdf2(
      password: password,
      salt: salt,
      iterations: _iterations,
      keyLength: _keyLength,
    );
    
    final combined = Uint8List(_saltLength + _keyLength);
    combined.setAll(0, salt);
    combined.setAll(_saltLength, hash);
    
    return base64.encode(combined);
  }

  Future<bool> verifyPassword(String password, String hashedPassword) async {
    try {
      final decoded = base64.decode(hashedPassword);
      final salt = decoded.sublist(0, _saltLength);
      final hash = decoded.sublist(_saltLength);
      
      final checkHash = await _pbkdf2(
        password: password,
        salt: salt,
        iterations: _iterations,
        keyLength: _keyLength,
      );
      
      return _compareBytes(hash, checkHash);
    } catch (e) {
      return false;
    }
  }

  Future<String> encrypt(String data) async {
    final key = _generateRandomBytes(_keyLength);
    final iv = _generateRandomBytes(_ivLength);
    
    // Implementation of encryption algorithm
    final encrypted = _encryptData(data, key, iv);
    
    final combined = Uint8List(_keyLength + _ivLength + encrypted.length);
    combined.setAll(0, key);
    combined.setAll(_keyLength, iv);
    combined.setAll(_keyLength + _ivLength, encrypted);
    
    return base64.encode(combined);
  }

  Future<String> decrypt(String encryptedData) async {
    try {
      final decoded = base64.decode(encryptedData);
      final key = decoded.sublist(0, _keyLength);
      final iv = decoded.sublist(_keyLength, _keyLength + _ivLength);
      final data = decoded.sublist(_keyLength + _ivLength);
      
      // Implementation of decryption algorithm
      return _decryptData(data, key, iv);
    } catch (e) {
      throw Exception('Decryption failed');
    }
  }

  Uint8List _generateRandomBytes(int length) {
    final random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(length, (i) => random.nextInt(256))
    );
  }

  Future<Uint8List> _pbkdf2({
    required String password,
    required Uint8List salt,
    required int iterations,
    required int keyLength,
  }) async {
    final bytes = utf8.encode(password);
    final hmac = Hmac(sha256, bytes);
    
    // PBKDF2 implementation
    final key = List<int>.filled(keyLength, 0);
    var offset = 0;
    var block = 1;
    
    while (offset < keyLength) {
      final current = List<int>.from(salt);
      current.addAll(_intToBytes(block));
      
      var last = hmac.convert(current).bytes;
      var result = List<int>.from(last);
      
      for (var i = 1; i < iterations; i++) {
        last = hmac.convert(last).bytes;
        for (var j = 0; j < result.length; j++) {
          result[j] ^= last[j];
        }
      }
      
      key.setRange(
        offset,
        min(offset + result.length, keyLength),
        result,
      );
      offset += result.length;
      block++;
    }
    
    return Uint8List.fromList(key);
  }

  Uint8List _intToBytes(int value) {
    final bytes = Uint8List(4);
    bytes[0] = (value >> 24) & 0xFF;
    bytes[1] = (value >> 16) & 0xFF;
    bytes[2] = (value >> 8) & 0xFF;
    bytes[3] = value & 0xFF;
    return bytes;
  }

  bool _compareBytes(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  Uint8List _encryptData(String data, List<int> key, List<int> iv) {
    // Implement actual encryption algorithm here
    // This is a placeholder implementation
    final bytes = utf8.encode(data);
    final encrypted = List<int>.from(bytes);
    for (var i = 0; i < encrypted.length; i++) {
      encrypted[i] ^= key[i % key.length];
    }
    return Uint8List.fromList(encrypted);
  }

  String _decryptData(List<int> data, List<int> key, List<int> iv) {
    // Implement actual decryption algorithm here
    // This is a placeholder implementation
    final decrypted = List<int>.from(data);
    for (var i = 0; i < decrypted.length; i++) {
      decrypted[i] ^= key[i % key.length];
    }
    return utf8.decode(decrypted);
  }

  String generateSecureToken() {
    final random = Random.secure();
    final values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  String hashString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}