import 'package:shared_preferences/shared_preferences.dart';
import 'user.dart';
import 'dart:convert';

class UserRepository {
  static const String userKey = 'users';

  int _nextUserId = 1;
  final List<User> _users = [];

  UserRepository() {
    _loadUsersFromSharedPreferences();
  }

  Future<void> _loadUsersFromSharedPreferences() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    List<String> encodedUsers = shared.getStringList(userKey) ?? [];

    for (String encodedUser in encodedUsers) {
      User user = User.fromJson(jsonDecode(encodedUser));
      _users.add(user);
    }
  }

  int getNextUserId() {
    if (_users.isNotEmpty) {
      final lastUser = _users.last;
      final lastUserId = int.tryParse(lastUser.id);
      if (lastUserId != null) {
        _nextUserId = lastUserId + 1;
      }
    }
    return _nextUserId;
  }

  List<User> getUsers() {
    return _users;
  }

  void addUser(User user) {
    user.id = getNextUserId().toString();
    _users.add(user);

    _saveUsersToSharedPreferences();
  }

  void removeUser(String id) {
    _users.removeWhere((user) => user.id == id);

    _saveUsersToSharedPreferences();
  }

  void updateUser(User updatedUser) {
    bool userFound = false;

    for (var user in _users) {
      if (user.id == updatedUser.id) {
        user.name = updatedUser.name;
        user.email = updatedUser.email;
        user.password = updatedUser.password;
        userFound = true;
        break;
      }
    }

    if (userFound) {
      _saveUsersToSharedPreferences();
    }
  }

  Future<void> _saveUsersToSharedPreferences() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    List<String> encodedUsers = [];
    for (User user in _users) {
      encodedUsers.add(jsonEncode(user.toJson()));
    }

    shared.setStringList(userKey, encodedUsers);
  }
}
