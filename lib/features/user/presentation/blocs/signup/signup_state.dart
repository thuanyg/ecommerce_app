import 'package:ecommerce_app/features/user/data/models/user.dart';

abstract class SignupState {}

class SignUpInitial extends SignupState{}

class SignUpLoading extends SignupState{}

class SignUpSuccess extends SignupState{
  User user;
  SignUpSuccess(this.user);
}

class SignUpError extends SignupState{
  String message;
  SignUpError(this.message);
}
