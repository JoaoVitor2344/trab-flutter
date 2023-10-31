// import 'user.dart';

// class UserRepository {
//   final List<User> _users = [
//     User(id: '1', name: 'João', email: 'joao@email.com', password: 'senha1'),
//     User(id: '2', name: 'Maria', email: 'maria@email.com', password: 'senha2'),
//   ];

//   User authenticate(String email, String password) {
//     final user = _users.firstWhere(
//       (user) => user.email == email && user.password == password,
//     );

//     // ignore: unnecessary_null_comparison
//     if (user != null) {
//       return user;
//     } else {
//       throw Exception(
//           'Usuário não encontrado'); // Lança uma exceção se o usuário não for encontrado
//     }
//   }
// }
