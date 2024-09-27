class UserLogin {
  String email;
  String password;

  UserLogin({required this.email, required this.password});

  Map<String, String> toJson(){
    return <String, String>{
      "email": email,
      "password": password
    };
  }
}
