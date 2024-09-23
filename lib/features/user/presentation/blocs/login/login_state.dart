abstract class LoginState {}

class LoginInitial extends LoginState{}

class LoginLoading extends LoginState{}

class LoginSuccess extends LoginState{
  String token;
  LoginSuccess(this.token);
}

class LoginError extends LoginState{
  String message;
  LoginError(this.message);
}
