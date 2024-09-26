abstract class LoginEvent {}

class RemoveLogin extends LoginEvent {}

class PressLogin extends LoginEvent {
  String username, password;

  PressLogin(this.username, this.password);
}
