import 'package:flutter/material.dart';
import 'user.dart';
import 'edit_user.dart';

class UserList extends StatefulWidget {
  List<User> users;

  UserList({required this.users});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  void _updateUser(User updatedUser) {
    setState(() {
      // Encontre e substitua o usuário antigo pelo usuário atualizado
      final index =
          widget.users.indexWhere((user) => user.id == updatedUser.id);
      if (index != -1) {
        widget.users[index] = updatedUser;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
      ),
      body: ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          final user = widget.users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUser(user: user),
                      ),
                    ).then((updatedUser) {
                      if (updatedUser != null) {
                        _updateUser(updatedUser);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Implemente a lógica de exclusão aqui
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
