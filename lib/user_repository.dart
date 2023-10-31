import 'user.dart';

class UserRepository {
  List<User> users = [
    User(id: '1', name: 'João', email: 'joao@email.com'),
    User(id: '2', name: 'Maria', email: 'maria@email.com'),
  ];

  List<User> getUsers() {
    return users;
  }

  void createUser(User user) {
    users.add(user);
  }

  void updateUser(User updatedUser) {
    int index = users.indexWhere((element) => element.id == updatedUser.id);
    if (index != -1) {
      users[index] = updatedUser;
    }
  }

  void deleteUser(User user) {
    users.remove(user);
  }
}
