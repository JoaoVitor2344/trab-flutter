import 'package:flutter/material.dart';
import 'user.dart';
import 'user_repository.dart';
import 'persistencia.dart';

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
    loadUserData();
  }

  void loadUserData() async {
    // Carregue os dados do usuário usando a classe LocalDate
    final String name = this.widget.user.name;
    final String email = this.widget.user.email;
    final String password = this.widget.user.password;

    setState(() {
      _nameController.text = name;
      _emailController.text = email;
      _passwordController.text = password;
    });
  }

  void _saveChanges() async {
    final String newName = _nameController.text;
    final String newEmail = _emailController.text;
    final String newPassword = _passwordController.text;

    if (newName.isNotEmpty && newEmail.isNotEmpty) {
      final User updatedUser = User(
        id: widget.user.id,
        name: newName,
        email: newEmail,
        password: newPassword,
      );

      // Utilize o UserRepository para atualizar o usuário
      UserRepository().updateUser(updatedUser);

      // Salve os dados atualizados usando a classe LocalDate
      await LocalDate.salvarString(
        updatedUser.name,
        updatedUser.email,
        updatedUser.password,
      );

      // Navegue de volta para a tela anterior
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
              obscureText: true,
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
