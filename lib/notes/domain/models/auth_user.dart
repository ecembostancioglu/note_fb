class AuthUser{
   late String email;
   late String authUserId;
   late String userName;

  AuthUser({
    required this.email,
    required this.authUserId,
    required this.userName});

  AuthUser.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    authUserId = json['authUserId'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['authUserId'] = authUserId;
    data['userName'] = userName;
    return data;
  }



}