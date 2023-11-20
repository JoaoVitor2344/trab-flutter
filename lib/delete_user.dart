import 'package:flutter/material.dart';
import 'user.dart';
import 'user_repository.dart';

class DeleteUser extends StatefulWidget {
  final User user;
  final UserRepository userRepository;
  final Function(User)
      onDeleteUser; // Adicione uma função de retorno de chamada

  DeleteUser(
      {required this.user,
      required this.userRepository,
      required this.onDeleteUser});

  @override
  _DeleteUserState createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  void _deleteUser() {
    widget.userRepository.removeUser(widget.user.id);
    widget.onDeleteUser(widget.user); // Chame a função de retorno de chamada
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excluir Usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Tem certeza de que deseja excluir o usuário?'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deleteUser,
              child: Text('Excluir Usuário'),
            ),
          ],
        ),
      ),
    );
  }
}
