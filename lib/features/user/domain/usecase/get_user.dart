import 'package:ecommerce_app/features/user/data/models/user.dart';
import 'package:ecommerce_app/features/user/domain/repository/user_repository.dart';

class GetUserUseCase {
  final UserRepository userRepo;
  GetUserUseCase(this.userRepo);
  Future<User> call(String id) async {
    return userRepo.getUser(id);
  }
}