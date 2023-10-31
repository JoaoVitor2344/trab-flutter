class User {
  String id;
  String name;
  String email;
  String password; // Adicione um campo de senha

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password});
}
