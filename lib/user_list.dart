import 'package:flutter/material.dart';
import 'user.dart'; // Importe a classe User

class UserList extends StatelessWidget {
  final List<User> users; // Lista de usuários a ser exibida

  UserList({required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Adicione a lógica de edição do usuário aqui
                    // Você pode usar Navigator para navegar para a tela de edição
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Adicione a lógica de exclusão do usuário aqui
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
