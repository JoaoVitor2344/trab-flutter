import 'package:flutter/material.dart';
import 'user.dart';
import 'user_list.dart';
import 'user_repository.dart';

void main() {
  List<User> users = UserRepository().getUsers();

  runApp(MyApp(users: users));
}

class MyApp extends StatelessWidget {
  final List<User> users; // Altere a declaração para uma lista de usuários

  const MyApp({required this.users});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: UserList(users: users));
  }
}
