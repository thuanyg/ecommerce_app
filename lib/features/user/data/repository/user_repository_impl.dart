import 'package:ecommerce_app/core/utils/jwt.dart';
import 'package:ecommerce_app/core/utils/storage.dart';
import 'package:ecommerce_app/features/user/data/datasource/user_datasource_impl.dart';
import 'package:ecommerce_app/features/user/data/models/user.dart';
import 'package:ecommerce_app/features/user/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasourceImpl userDatasourceImpl;

  UserRepositoryImpl(this.userDatasourceImpl);

  @override
  Future<String> login(String username, String password) async {
    final token = await userDatasourceImpl.login(username, password);
    final payload = JwtUtils.getPayload(token);
    if (token.isNotEmpty) {
      StorageUtils.storeValue(key: "userid", value: payload["sub"].toString());
      StorageUtils.storeValue(
          key: "username", value: payload["user"].toString());
    }
    return token;
  }

  @override
  Future<User> signUp(User user) async {
    return await userDatasourceImpl.signUp(user);
  }

  @override
  Future<User> getUser(String id) async {
    return await userDatasourceImpl.getUser(id);
  }

  @override
  Future<void> logout() async {
    return await userDatasourceImpl.logout();
  }

  @override
  Future<User> update(User user) async {
    return await userDatasourceImpl.update(user);
  }
}
