class UserInfo {
  String correo;
  String password;

  UserInfo({this.correo, this.password});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
    UserInfo(correo: json["correo"], password: json["password"]);

  Map<String, dynamic> toJson() {
    return {
      "correo": this.correo,
      "password": this.password
    };
  }

  // UserInfo.fromObject(dynamic nodo) {
  //   this.Correo = nodo["correo"];
  //   this.Password = nodo["password"];
  // }
}
