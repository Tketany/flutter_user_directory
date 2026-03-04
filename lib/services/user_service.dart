import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'package:flutter/foundation.dart';

class UserService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> fetchUsers() async {
    final uri = Uri.parse('$_baseUrl/users');

    debugPrint('GET: $uri');

    final response = await http.get(
      uri,
      headers: const {
        'Accept': 'application/json',
        'User-Agent': 'flutter-user-directory',
      },
    );

    debugPrint('STATUS: ${response.statusCode}');
    debugPrint('HEADERS: ${response.headers}');
    debugPrint(
      'BODY (first 200): ${response.body.length > 200 ? response.body.substring(0, 200) : response.body}',
    );

    if (response.statusCode != 200) {
      throw HttpException('Failed to load users (code: ${response.statusCode})');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      throw const FormatException('Unexpected response format');
    }

    return decoded
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}