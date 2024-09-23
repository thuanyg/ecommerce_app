import 'package:ecommerce_app/features/user/data/datasource/user_datasource_impl.dart';
import 'package:ecommerce_app/features/user/data/models/user.dart';
import 'package:ecommerce_app/features/user/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasourceImpl userDatasourceImpl;

  UserRepositoryImpl(this.userDatasourceImpl);

  @override
  Future<String> login(String username, String password) async {
    return await userDatasourceImpl.login(username, password);
  }

  @override
  Future<User> signUp(User user) async {
    return await userDatasourceImpl.signUp(user);
  }
}
