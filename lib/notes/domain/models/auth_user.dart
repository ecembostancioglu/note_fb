class AuthUser{
  final String email;
  final String userName;
  final String photoUrl;

  AuthUser({
    required this.email,
    required this.userName,
    required this.photoUrl});

  AuthUser.fromData(Map<String, dynamic> data)
      : email = data['email'],
        userName = data['userName'],
        photoUrl = data['photoUrl'];
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userName': userName,
      'photoUrl': photoUrl,
    };
  }



}