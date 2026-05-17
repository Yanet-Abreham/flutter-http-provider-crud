import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com/users';


  /* Get All Users */
  static Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl?limit=10'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['users'];
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Server Error: ${response.statusCode}');
    }
  }

  /* Create User */
  static Future<User> createUser(String newFName, String newLName, String newEmail, String avatarUrl) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': newFName,
        'lastName': newLName,
        'email': newEmail,
        'image': avatarUrl,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return User.fromJson(jsonData);
    } else {
      throw Exception('Failed to create user');
    }
  }

  /* Delete User */

  static Future<bool> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    return response.statusCode == 200;
  }

 /* Patch User */
  static Future<User> patchUser(int id, String newFirstName, String newLastName, String newEmail) async {
    final response = await http.patch(
    Uri.parse('$baseUrl/$id'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'firstName': newFirstName,
      'lastName': newLastName,
      'email': newEmail,
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    return User.fromJson(jsonData);
  } else {
    throw Exception('Failed to update user');
  }
 }
}