import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../utils/offline_storage.dart';

class ApiService {
  final String baseUrl;
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  ApiService({required this.baseUrl});

  void setAuthToken(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _makeRequest('GET', endpoint);
      return _handleResponse(response);
    } catch (e) {
      await _handleError(e);
    }
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final response = await _makeRequest('POST', endpoint, data: data);
      return _handleResponse(response);
    } catch (e) {
      await _handleError(e);
    }
  }

  Future<dynamic> put(String endpoint, dynamic data) async {
    try {
      final response = await _makeRequest('PUT', endpoint, data: data);
      return _handleResponse(response);
    } catch (e) {
      await _handleError(e);
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await _makeRequest('DELETE', endpoint);
      return _handleResponse(response);
    } catch (e) {
      await _handleError(e);
    }
  }

  Future<HttpClientResponse> _makeRequest(String method, String endpoint,
      {dynamic data}) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final httpClient = HttpClient()
      ..badCertificateCallback = (cert, host, port) => true;

    try {
      final request = await _createRequest(httpClient, method, uri);
      _headers.forEach((key, value) {
        request.headers.set(key, value);
      });

      if (data != null) {
        final jsonData = jsonEncode(data);
        request.write(jsonData);
      }

      final response = await request.close();
      return response;
    } catch (e) {
      if (e is SocketException) {
        // Handle offline scenario
        return await OfflineStorage.handleOfflineRequest(
          method,
          endpoint,
          data,
        );
      }
      rethrow;
    }
  }

  Future<HttpClientRequest> _createRequest(
      HttpClient client, String method, Uri uri) async {
    switch (method) {
      case 'GET':
        return await client.getUrl(uri);
      case 'POST':
        return await client.postUrl(uri);
      case 'PUT':
        return await client.putUrl(uri);
      case 'DELETE':
        return await client.deleteUrl(uri);
      default:
        throw Exception('Unsupported HTTP method');
    }
  }

  Future<dynamic> _handleResponse(HttpClientResponse response) async {
    final contents = await response.transform(utf8.decoder).join();
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      if (contents.isEmpty) return null;
      return jsonDecode(contents);
    } else {
      throw ApiException(
        statusCode: statusCode,
        message: _getErrorMessage(contents, statusCode),
      );
    }
  }

  String _getErrorMessage(String contents, int statusCode) {
    try {
      final Map<String, dynamic> body = jsonDecode(contents);
      return body['message'] ?? body['error'] ?? 'Unknown error occurred';
    } catch (e) {
      return 'Error $statusCode: Unknown error occurred';
    }
  }

  Future<void> _handleError(dynamic error) async {
    if (error is ApiException) {
      debugPrint('API Error: ${error.message}');
      rethrow;
    } else {
      debugPrint('Unexpected Error: $error');
      throw ApiException(
        statusCode: 500,
        message: 'An unexpected error occurred',
      );
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException: $message (Status Code: $statusCode)';
}