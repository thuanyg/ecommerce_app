import 'package:ecommerce_app/features/user/data/models/user.dart';

abstract class SignupEvent {}

class PressSignUp extends SignupEvent {
  User user;

  PressSignUp(this.user);
}
