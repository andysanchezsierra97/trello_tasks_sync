class User {
  final String id;
  final String username;
  final String password;
  final String trelloToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  User(
      {required this.id,
      required this.username,
      required this.password,
      required this.trelloToken,
      required this.createdAt,
      required this.updatedAt});
}
