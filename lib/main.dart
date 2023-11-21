import 'package:flutter/material.dart';
import 'user.dart';
import 'user_list.dart';
import 'user_repository.dart';
import 'persistencia.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository userRepository = UserRepository();
  List<User> users = [];

  @override
  void initState() {
    super.initState();

    // Salva a lista de usuários no armazenamento local
    LocalDate.salvarListaString(users.map((user) => user.name).toList());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserList(userRepository: userRepository, users: users),
    );
  }
}
