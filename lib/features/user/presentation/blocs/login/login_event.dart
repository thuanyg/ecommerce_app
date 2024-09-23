abstract class LoginEvent {}


class PressLogin extends LoginEvent{
  String username, password;
  PressLogin(this.username, this.password);
}
