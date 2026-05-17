import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
 
 /* Fetch Users */
  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _users = await ApiService.getUsers();
    } catch (e) {
      _errorMessage = "Could not load users";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

/* Add User */
  Future<void> addUser(String newFName, String newLName, String newEmail) async {
    try {
      final int seed = DateTime.now().millisecondsSinceEpoch;
      final String fallbackAvatar = 'https://robohash.org/$seed.png';

      final newUser = await ApiService.createUser(newFName, newLName, newEmail, fallbackAvatar);
      _users.insert(0, newUser);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to add user";
      notifyListeners();
    }
  }

/* Delete User */
  Future<void> removeUser(int id) async {
    try {
      final success = await ApiService.deleteUser(id);
      if (success) {
        _users.removeWhere((u) => u.id == id);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Failed to delete user: $e");
      fetchUsers(); 
    }
  }
  
/* Update User */
  Future<void> updateUserName(int id, String newFirstName, String newLastName, String newEmail) async {
    try {
      final updateUser = await ApiService.patchUser(id, newFirstName, newLastName, newEmail);
      int index = _users.indexWhere((u) => u.id == id);
      if (index != -1) {
        _users[index] = updateUser;
        notifyListeners();
        print("User updated on the Local List: ${updateUser.first_Name}");
      }
  } catch (e) {
    debugPrint("Failed to update user: $e");
    fetchUsers(); 
  }
 }
}