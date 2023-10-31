import 'package:flutter/material.dart';
import 'user.dart';
import 'user_repository.dart';
import 'edit_user.dart';
import 'create_user.dart';
import 'delete_user.dart'; // Importe o arquivo que contém o DeleteUserDialog

class UserList extends StatefulWidget {
  final UserRepository userRepository;

  UserList({required this.userRepository});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    users = widget.userRepository.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name),
            subtitle: Text(users[index].email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _navigateToEditUser(context, users[index]);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _confirmDeleteUser(context, users[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToCreateUser(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToEditUser(BuildContext context, User user) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditUser(user: user)),
    );

    if (result != null && result is User) {
      setState(() {
        widget.userRepository.updateUser(result);
        users = widget.userRepository.getUsers();
      });
    }
  }

  void _confirmDeleteUser(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteUserDialog(
          user: user,
          onDelete: () {
            _deleteUser(user);
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _deleteUser(User user) {
    setState(() {
      widget.userRepository.deleteUser(user);
      users = widget.userRepository.getUsers();
    });
  }

  void _navigateToCreateUser(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateUser()),
    );

    if (result != null && result is User) {
      setState(() {
        widget.userRepository.createUser(result);
        users = widget.userRepository.getUsers();
      });
    }
  }
}
