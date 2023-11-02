import 'user.dart';

class UserRepository {
  int _nextUserId = 1;
  final List<User> _users = [];

  int getNextUserId() {
    // Verifica o ID do último usuário adicionado e atribui o próximo ID sequencial
    if (_users.isNotEmpty) {
      final lastUser = _users.last;
      final lastUserId = int.tryParse(lastUser.id);
      if (lastUserId != null) {
        _nextUserId = lastUserId + 1;
      }
    }
    return _nextUserId;
  }

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
    user.id = getNextUserId().toString();
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
  }
}
