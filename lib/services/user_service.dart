import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> fetchUsers() async {
    final uri = Uri.parse('$_baseUrl/users');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load users (code: ${response.statusCode})');
    }

    final decoded = jsonDecode(response.body);

    if (decoded is! List) {
      throw Exception('Unexpected response format');
    }

    return decoded
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}