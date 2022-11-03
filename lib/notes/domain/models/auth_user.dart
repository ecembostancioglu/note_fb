class AuthUser{
   String email;
   String password;
   String userName;
   String photoUrl;

  AuthUser({
    required this.email,
    required this.password,
    required this.userName,
    required this.photoUrl});

  AuthUser.fromData(Map<String, dynamic> data)
      : email = data['email'],
        password = data['password'],
        userName = data['userName'],
        photoUrl = data['photoUrl'];


  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'userName': userName,
      'photoUrl': photoUrl,
    };
  }



}