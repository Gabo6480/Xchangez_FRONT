class UserToken {
  String token;
  String expiration;

  UserToken({this.token, this.expiration});

  factory UserToken.fromJson(Map<String, dynamic> json) {
    return UserToken(token: json["token"], expiration: json["expiration"]);
  }
}
