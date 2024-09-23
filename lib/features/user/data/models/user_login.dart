class UserLogin {
  String username;
  String password;

  UserLogin({required this.username, required this.password});

  Map<String, String> toJson(){
    return <String, String>{
      "username": username,
      "password": password
    };
  }
}
