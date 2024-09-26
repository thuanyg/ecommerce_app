import 'package:ecommerce_app/features/user/data/models/user.dart';
import 'package:ecommerce_app/features/user/domain/repository/user_repository.dart';

class LogOutUseCase {
  final UserRepository userRepo;
  LogOutUseCase(this.userRepo);
  Future<void> call() async {
    return userRepo.logout();
  }
}