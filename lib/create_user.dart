import 'package:flutter/material.dart';
import 'user.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _createUser() {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text; // Obtém a senha

    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      User newUser = User(
        id: DateTime.now().toString(),
        name: name,
        email: email,
        password: password, // Define a senha no objeto User
      );
      Navigator.pop(context, newUser);
    } else {
      // Lide com erros de entrada ou validação, se necessário
    }
  }

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
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createUser,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
