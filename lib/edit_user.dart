import 'package:flutter/material.dart';
import 'user.dart';

class EditUser extends StatefulWidget {
  final User user;

  EditUser({required this.user});

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name;
    _emailController.text = widget.user.email;
    _passwordController.text =
        widget.user.password; // Preencha o campo de senha
  }

  void _saveChanges() {
    final String newName = _nameController.text;
    final String newEmail = _emailController.text;
    final String newPassword = _passwordController.text;

    if (newName.isNotEmpty && newEmail.isNotEmpty) {
      final User updatedUser = User(
        id: widget.user.id,
        name: newName,
        email: newEmail,
        password: newPassword, // Atualize a senha no objeto User
      );

      Navigator.pop(context, updatedUser);
    } else {
      // Lide com erros de entrada ou validação, se necessário
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuário'),
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
              onPressed: _saveChanges,
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
