import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class User {
  String id;
  String name;
  String email;

  User({required this.id, required this.name, required this.email});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> users = [
    User(id: '1', name: 'João', email: 'joao@email.com'),
    User(id: '2', name: 'Maria', email: 'maria@email.com'),
  ];

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
            onTap: () {
              _navigateToUserDetails(context, users[index]);
            },
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

  // Métodos para navegação

  // Navega para os detalhes do usuário
  void _navigateToUserDetails(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetails(user: user),
      ),
    );
  }

  // Navega para a página de edição do usuário
  void _navigateToEditUser(BuildContext context, User user) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditUser(user: user)),
    );

    if (result != null && result is User) {
      setState(() {
        int index = users.indexWhere((element) => element.id == result.id);
        if (index != -1) {
          users[index] = result;
        }
      });
    }
  }

  // Mostra um diálogo para confirmar a exclusão do usuário
  void _confirmDeleteUser(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Tem certeza de que deseja excluir este usuário?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _deleteUser(context, user);
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  // Deleta o usuário
  void _deleteUser(BuildContext context, User user) {
    setState(() {
      users.remove(user);
      Navigator.of(context).pop(); // Fecha o diálogo
    });
  }

  // Navega para a página de criação de um novo usuário
  void _navigateToCreateUser(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateUser()),
    );

    if (result != null && result is User) {
      setState(() {
        users.add(result);
      });
    }
  }
}

class UserDetails extends StatelessWidget {
  final User user;

  UserDetails({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('ID: ${user.id}'),
            Text('Nome: ${user.name}'),
            Text('Email: ${user.email}'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _navigateToEditUser(context, user);
                  },
                  child: Text('Editar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _confirmDeleteUser(context, user);
                  },
                  child: Text('Excluir'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Navega para a página de edição do usuário
  void _navigateToEditUser(BuildContext context, User user) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditUser(user: user)),
    );

    if (result != null && result is User) {
      // Lidar com a atualização se necessário
      // Para este exemplo, não é necessário, pois os detalhes são estáticos
    }
  }

  // Mostra um diálogo para confirmar a exclusão do usuário
  void _confirmDeleteUser(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Tem certeza de que deseja excluir este usuário?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _deleteUser(context, user);
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  // Deleta o usuário
  void _deleteUser(BuildContext context, User user) {
    // Para este exemplo, isso apenas fecha a rota atual
    Navigator.of(context).pop();
    // Você deve implementar sua lógica real de exclusão aqui
    // Exemplo: Modificar a lista 'users' e atualizar a interface usando setState
  }
}

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

  // Edita as informações do usuário
  void _editUser(BuildContext context) {
    String name = _nameController.text;
    String email = _emailController.text;

    if (name.isNotEmpty && email.isNotEmpty) {
      User updatedUser = User(id: widget.user.id, name: name, email: email);
      Navigator.pop(context, updatedUser);
    }
  }
}

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

  // Cria um novo usuário
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
