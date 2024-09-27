
import '../models/user.dart';

abstract class UserDatasource {
  Future<String> login(String username, String password);
  Future<User> signUp(User user);
  Future<User> getUser(String id);
  Future<void> logout();
}