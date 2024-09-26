abstract class LogoutState {}

class LogoutInitial extends LogoutState{}

class LogoutLoading extends LogoutState{}

class LogoutSuccess extends LogoutState{
}

class LoginError extends LogoutState{
  String message;
  LoginError(this.message);
}
