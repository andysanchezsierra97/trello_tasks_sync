abstract class UserRepository {
  Future<String> register(String username, String password);
  Future<String> login(String username, String password);
  Future<String?> getCurrentUser(String token);
}
