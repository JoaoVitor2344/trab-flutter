import 'user.dart';

class UserRepository {
  final List<User> _users = [];

  UserRepository() {
    // Adicione alguns usuários iniciais
    _users.add(User(
        id: '1',
        name: 'Alice',
        email: 'alice@example.com',
        password: 'password1'));
    _users.add(User(
        id: '2', name: 'Bob', email: 'bob@example.com', password: 'password2'));
    _users.add(User(
        id: '3',
        name: 'Charlie',
        email: 'charlie@example.com',
        password: 'password3'));
  }

  List<User> getUsers() {
    return _users;
  }

  void addUser(User user) {
    _users.add(user);
  }

  void removeUser(String id) {
    _users.removeWhere((user) => user.id == id);
  }

  void updateUser(User updatedUser) {
    bool userFound = false; // Inicialize a flag como false

    for (var user in _users) {
      if (user.id == updatedUser.id) {
        // Atualize os campos do usuário existente com os novos valores
        user.name = updatedUser.name;
        user.email = updatedUser.email;
        user.password = updatedUser.password;
        userFound = true; // Defina a flag como true
        break;
      }
    }

    if (!userFound) {
      print("Usuário não encontrado para atualização");
      // Você pode optar por lidar com isso de outras maneiras, como registrar um erro ou enviar uma notificação
    }
  }
}
