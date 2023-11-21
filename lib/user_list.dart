import 'package:flutter/material.dart';
import 'user.dart';
import 'user_repository.dart';
import 'edit_user.dart';
import 'delete_user.dart';
import 'create_user.dart'; // Import the user creation screen if it hasn't been created yet.

// ignore: must_be_immutable
class UserList extends StatefulWidget {
  final UserRepository userRepository;
  List<User> users;

  UserList({
    required this.userRepository,
    required this.users,
  });

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
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
                  onPressed: () async {
                    final updatedUser = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUser(user: user),
                      ),
                    );

                    if (updatedUser != null) {
                      setState(() {
                        final index = widget.users
                            .indexWhere((u) => u.id == updatedUser.id);
                        if (index != -1) {
                          widget.users[index] = updatedUser;
                        }
                      });
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    final deletedUser = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeleteUser(
                          user: user,
                          userRepository: widget.userRepository,
                          onDeleteUser: (removedUser) {
                            setState(() {
                              widget.users
                                  .removeWhere((u) => u.id == removedUser.id);
                            });
                          },
                        ),
                      ),
                    );

                    if (deletedUser != null) {
                      // Handle the deleted user if necessary.
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the user creation screen when the "Create" button is pressed.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateUser(
                userRepository: widget.userRepository,
              ),
            ),
          ).then((createdUser) {
            if (createdUser != null) {
              setState(() {
                widget.users.add(createdUser); // Add the new user to the list
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
