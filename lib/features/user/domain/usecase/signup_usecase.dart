import 'package:ecommerce_app/features/user/data/models/user.dart';
import 'package:ecommerce_app/features/user/domain/repository/user_repository.dart';

class SignUpUseCase {
  final UserRepository userRepo;
  SignUpUseCase(this.userRepo);

  Future<User> call(User user) async {
    return await userRepo.signUp(user);
  }
}