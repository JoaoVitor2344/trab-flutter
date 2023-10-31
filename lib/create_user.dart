import 'package:flutter/material.dart';
import 'user.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _createUser(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _createUser(BuildContext context) {
    String name = _nameController.text;
    String email = _emailController.text;

    if (name.isNotEmpty && email.isNotEmpty) {
      User newUser =
          User(id: DateTime.now().toString(), name: name, email: email);
      Navigator.pop(context, newUser);
    }
  }
}
