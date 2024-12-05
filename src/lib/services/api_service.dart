import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../utils/constants.dart';
import '../services/storage_service.dart';

class ApiService {
  final StorageService _storageService;
  final String _baseUrl;

  ApiService({
    required StorageService storageService,
    String? baseUrl,
  })  : _storageService = storageService,
        _baseUrl = baseUrl ?? AppConstants.apiBaseUrl;

  Future<dynamic> get(String endpoint) async {
    try {
      final token = await _storageService.getToken();
      final response = await HttpClient()
          .getUrl(Uri.parse('$_baseUrl$endpoint'))
          .then((request) {
        request.headers.set('Authorization', 'Bearer $token');
        request.headers.set('Content-Type', 'application/json');
        return request.close();
      });

      return _handleResponse(response);
    } catch (e) {
      debugPrint('GET request error: $e');
      throw _handleError(e);
    }
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final token = await _storageService.getToken();
      final response = await HttpClient()
          .postUrl(Uri.parse('$_baseUrl$endpoint'))
          .then((request) {
        request.headers.set('Authorization', 'Bearer $token');
        request.headers.set('Content-Type', 'application/json');
        request.write(jsonEncode(data));
        return request.close();
      });

      return _handleResponse(response);
    } catch (e) {
      debugPrint('POST request error: $e');
      throw _handleError(e);
    }
  }

  Future<dynamic> put(String endpoint, dynamic data) async {
    try {
      final token = await _storageService.getToken();
      final response = await HttpClient()
          .putUrl(Uri.parse('$_baseUrl$endpoint'))
          .then((request) {
        request.headers.set('Authorization', 'Bearer $token');
        request.headers.set('Content-Type', 'application/json');
        request.write(jsonEncode(data));
        return request.close();
      });

      return _handleResponse(response);
    } catch (e) {
      debugPrint('PUT request error: $e');
      throw _handleError(e);
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      final token = await _storageService.getToken();
      final response = await HttpClient()
          .deleteUrl(Uri.parse('$_baseUrl$endpoint'))
          .then((request) {
        request.headers.set('Authorization', 'Bearer $token');
        request.headers.set('Content-Type', 'application/json');
        return request.close();
      });

      return _handleResponse(response);
    } catch (e) {
      debugPrint('DELETE request error: $e');
      throw _handleError(e);
    }
  }

  Future<dynamic> _handleResponse(HttpClientResponse response) async {
    final contents = StringBuffer();
    await for (var data in response.transform(utf8.decoder)) {
      contents.write(data);
    }

    final responseData = contents.toString().isNotEmpty 
        ? jsonDecode(contents.toString()) 
        : null;

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseData;
      case 400:
        throw Exception('Bad request: ${responseData?['message']}');
      case 401:
        throw Exception('Unauthorized: ${responseData?['message']}');
      case 403:
        throw Exception('Forbidden: ${responseData?['message']}');
      case 404:
        throw Exception('Not found: ${responseData?['message']}');
      case 500:
        throw Exception('Server error: ${responseData?['message']}');
      default:
        throw Exception('Unknown error: ${response.statusCode}');
    }
  }

  Exception _handleError(dynamic error) {
    if (error is SocketException) {
      return Exception('Network error: Please check your internet connection');
    }
    if (error is FormatException) {
      return Exception('Data format error: Invalid response format');
    }
    if (error is Exception) {
      return error;
    }
    return Exception('Unknown error occurred');
  }

  Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void setAuthToken(String token) {
    _storageService.saveToken(token);
  }

  Future<void> clearAuthToken() async {
    await _storageService.clearToken();
  }
}