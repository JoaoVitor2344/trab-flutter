import 'package:flutter/material.dart';
import 'user.dart';
import 'user_list.dart';
import 'user_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  final List<User> users = UserRepository()
      .getUsers(); // Obtenha a lista de usuários do UserRepository

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserList(userRepository: userRepository, users: users),
    );
  }
}
