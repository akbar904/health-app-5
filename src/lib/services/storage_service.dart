import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../utils/encryption.dart';

class StorageService {
  final EncryptionUtil _encryptionUtil;
  final String _tokenKey = 'auth_token';
  final String _userKey = 'current_user';
  final String _settingsKey = 'app_settings';
  final String _cacheKey = 'data_cache';

  StorageService({required EncryptionUtil encryptionUtil})
      : _encryptionUtil = encryptionUtil;

  Future<void> saveToken(String token) async {
    try {
      final encryptedToken = await _encryptionUtil.encrypt(token);
      await _write(_tokenKey, encryptedToken);
    } catch (e) {
      debugPrint('Error saving token: $e');
      throw Exception('Failed to save token');
    }
  }

  Future<String?> getToken() async {
    try {
      final encryptedToken = await _read(_tokenKey);
      if (encryptedToken == null) return null;
      return await _encryptionUtil.decrypt(encryptedToken);
    } catch (e) {
      debugPrint('Error getting token: $e');
      return null;
    }
  }

  Future<void> clearToken() async {
    try {
      await _delete(_tokenKey);
    } catch (e) {
      debugPrint('Error clearing token: $e');
      throw Exception('Failed to clear token');
    }
  }

  Future<void> saveUser(User user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      final encryptedUser = await _encryptionUtil.encrypt(userJson);
      await _write(_userKey, encryptedUser);
    } catch (e) {
      debugPrint('Error saving user: $e');
      throw Exception('Failed to save user');
    }
  }

  Future<User?> getUser() async {
    try {
      final encryptedUser = await _read(_userKey);
      if (encryptedUser == null) return null;
      final userJson = await _encryptionUtil.decrypt(encryptedUser);
      return User.fromJson(jsonDecode(userJson));
    } catch (e) {
      debugPrint('Error getting user: $e');
      return null;
    }
  }

  Future<void> clearUser() async {
    try {
      await _delete(_userKey);
    } catch (e) {
      debugPrint('Error clearing user: $e');
      throw Exception('Failed to clear user');
    }
  }

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    try {
      final settingsJson = jsonEncode(settings);
      final encryptedSettings = await _encryptionUtil.encrypt(settingsJson);
      await _write(_settingsKey, encryptedSettings);
    } catch (e) {
      debugPrint('Error saving settings: $e');
      throw Exception('Failed to save settings');
    }
  }

  Future<Map<String, dynamic>?> getSettings() async {
    try {
      final encryptedSettings = await _read(_settingsKey);
      if (encryptedSettings == null) return null;
      final settingsJson = await _encryptionUtil.decrypt(encryptedSettings);
      return jsonDecode(settingsJson);
    } catch (e) {
      debugPrint('Error getting settings: $e');
      return null;
    }
  }

  Future<void> saveToCache(String key, dynamic data) async {
    try {
      final cache = await _getCache();
      cache[key] = {
        'data': data,
        'timestamp': DateTime.now().toIso8601String(),
      };
      final cacheJson = jsonEncode(cache);
      final encryptedCache = await _encryptionUtil.encrypt(cacheJson);
      await _write(_cacheKey, encryptedCache);
    } catch (e) {
      debugPrint('Error saving to cache: $e');
      throw Exception('Failed to save to cache');
    }
  }

  Future<dynamic> getFromCache(String key, {Duration? maxAge}) async {
    try {
      final cache = await _getCache();
      final cachedData = cache[key];
      if (cachedData == null) return null;

      if (maxAge != null) {
        final timestamp = DateTime.parse(cachedData['timestamp']);
        final age = DateTime.now().difference(timestamp);
        if (age > maxAge) return null;
      }

      return cachedData['data'];
    } catch (e) {
      debugPrint('Error getting from cache: $e');
      return null;
    }
  }

  Future<void> clearCache() async {
    try {
      await _delete(_cacheKey);
    } catch (e) {
      debugPrint('Error clearing cache: $e');
      throw Exception('Failed to clear cache');
    }
  }

  Future<Map<String, dynamic>> _getCache() async {
    try {
      final encryptedCache = await _read(_cacheKey);
      if (encryptedCache == null) return {};
      final cacheJson = await _encryptionUtil.decrypt(encryptedCache);
      return jsonDecode(cacheJson);
    } catch (e) {
      return {};
    }
  }

  Future<void> _write(String key, String value) async {
    final file = await _getFile(key);
    await file.writeAsString(value);
  }

  Future<String?> _read(String key) async {
    try {
      final file = await _getFile(key);
      if (!await file.exists()) return null;
      return await file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future<void> _delete(String key) async {
    final file = await _getFile(key);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<File> _getFile(String key) async {
    final directory = await _getDirectory();
    return File('${directory.path}/$key.dat');
  }

  Future<Directory> _getDirectory() async {
    if (Platform.isAndroid || Platform.isIOS) {
      return Directory.systemTemp;
    } else {
      return Directory.current;
    }
  }
}