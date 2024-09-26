import 'package:ecommerce_app/features/user/data/models/user.dart';

abstract class PersonalState {}

class PersonalInitial extends PersonalState {}
class PersonalLoading extends PersonalState {}
class PersonalError extends PersonalState {
  String message;
  PersonalError(this.message);
}
class PersonalLoaded extends PersonalState {
  User user;
  PersonalLoaded(this.user);
}
