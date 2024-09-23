import 'package:ecommerce_app/features/user/domain/repository/user_repository.dart';

class LoginUseCase {
  final UserRepository userRepo;
  LoginUseCase(this.userRepo);

  Future<String> call(String username, String password) async {
    return await userRepo.login(username, password);
  }
}