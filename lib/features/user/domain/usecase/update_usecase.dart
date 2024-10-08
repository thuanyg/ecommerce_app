import 'package:ecommerce_app/features/user/data/models/user.dart';
import 'package:ecommerce_app/features/user/domain/repository/user_repository.dart';

class UpdateUsecase {
  final UserRepository userRepo;
  UpdateUsecase(this.userRepo);

  Future<User> call(User user) async {
    return await userRepo.update(user);
  }
}