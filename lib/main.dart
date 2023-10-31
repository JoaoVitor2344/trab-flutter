import 'package:flutter/material.dart';
import 'user.dart';
import 'user_list.dart'; // Importe o arquivo que contém a definição da classe UserList

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Suponha que userList seja a lista de usuários que você deseja exibir.
    List<User> userList = [
      User(
          id: '1',
          name: 'Alice',
          email: 'alice@example.com',
          password: 'password1'),
      User(
          id: '2',
          name: 'Bob',
          email: 'bob@example.com',
          password: 'password2'),
      User(
          id: '3',
          name: 'Charlie',
          email: 'charlie@example.com',
          password: 'password3'),
      // Adicione mais usuários conforme necessário
    ];

    return MaterialApp(
      home: UserList(
          users:
              userList), // Defina a tela de listagem de usuários como a tela inicial
    );
  }
}
