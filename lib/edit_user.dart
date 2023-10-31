import 'package:flutter/material.dart';
import 'user.dart';

class EditUser extends StatefulWidget {
  final User user;

  EditUser({required this.user});

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _editUser(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _editUser(BuildContext context) {
    String name = _nameController.text;
    String email = _emailController.text;

    if (name.isNotEmpty && email.isNotEmpty) {
      User updatedUser = User(id: widget.user.id, name: name, email: email);
      Navigator.pop(context, updatedUser);
    }
  }
}
