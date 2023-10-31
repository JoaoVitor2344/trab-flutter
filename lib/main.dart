import 'package:flutter/material.dart';
import 'user_list.dart'; // Importe o arquivo que contém o UserList
import 'user_repository.dart'; // Importe o arquivo que contém o UserRepository

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository =
      UserRepository(); // Crie uma instância do UserRepository

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserList(
          userRepository:
              userRepository), // Passe a instância do UserRepository para o UserList
    );
  }
}
