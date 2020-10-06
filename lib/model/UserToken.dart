class UserToken {
  String Token;
  String Expiration;

  UserToken({this.Token, this.Expiration});

  factory UserToken.fromJson(Map<String, dynamic> json) {
    return UserToken(Token: json["token"], Expiration: json["expiration"]);
  }
}
