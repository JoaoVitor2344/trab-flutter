class User {
  String id;
  String name;
  String email;
  String password;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory User.fromString(String str) {
    final List<String> fields = str.split(',');
    return User(
      id: fields[0],
      name: fields[1],
      email: fields[2],
      password: fields[3],
    );
  }

  @override
  String toString() {
    return 'id: $id, name: $name, email: $email, password: $password';
  }
}
