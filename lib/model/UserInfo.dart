class UserInfo {
  String Correo;
  String Password;

  UserInfo({this.Correo, this.Password});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(Correo: json["correo"], Password: json["password"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "Correo": this.Correo,
      "Password": this.Password
    };
  }

  // UserInfo.fromObject(dynamic nodo) {
  //   this.Correo = nodo["correo"];
  //   this.Password = nodo["password"];
  // }
}
