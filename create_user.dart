import 'package:flutter/material.dart';
import 'persistencia.dart';
import 'user.dart';
import 'user_repository.dart';

class CreateUser extends StatefulWidget {
  final UserRepository userRepository;

  CreateUser({required this.userRepository});

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Adicionando um GlobalKey para o formulário
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'O nome é obrigatório.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'O email é obrigatório.';
                  }
                  // Adicione validações adicionais de e-mail aqui, se necessário.
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'A senha é obrigatória.';
                  }
                  // Adicione validações adicionais de senha aqui, se necessário.
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // Valida os campos do formulário
            // Crie um novo usuário com os dados inseridos pelo usuário
            User newUser = User(
              id: '', // Lembre-se de fornecer um ID se necessário
              name: _nameController.text,
              email: _emailController.text,
              password: _passwordController.text,
            );

            // Adicione o novo usuário ao user_repository
            widget.userRepository.addUser(newUser);

            // Salve os dados do novo usuário usando a classe LocalDate
            await LocalDate.salvarString(
              _nameController.text,
              _emailController.text,
              _passwordController.text,
            );

            // Atualize a lista de usuários no SharedPreferences
            List<String> userList =
                await LocalDate.getListString(stringListKey);
            userList.add(newUser.id); // Adicione o ID do novo usuário à lista
            await LocalDate.salvarListaString(userList);

            // Navegue de volta para a tela anterior
            Navigator.pop(context, newUser);
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
