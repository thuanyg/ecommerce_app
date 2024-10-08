import 'package:ecommerce_app/features/user/data/models/user.dart';

abstract class UserRepository {
  Future<String> login(String username, String password);

  Future<User> signUp(User user);

  Future<User> getUser(String id);

  Future<void> logout();

  Future<User> update(User user);
}
