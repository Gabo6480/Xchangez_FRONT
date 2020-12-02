class Seguidor {
  int id;
  int idUsuarioSeguidor;
  int idUsuarioSeguido;
  String nombreCompletoSeguidor;
  String rutaAvatarSeguidor;
  String nombreCompletoSeguido;
  String rutaAvatarSeguido;

  Seguidor(
      {this.id = 0,
      this.idUsuarioSeguidor = 0,
      this.idUsuarioSeguido = 0,
      this.nombreCompletoSeguidor = "",
      this.rutaAvatarSeguidor = "",
      this.nombreCompletoSeguido = "",
      this.rutaAvatarSeguido = ""});

  factory Seguidor.fromJson(Map<String, dynamic> json) => Seguidor(
      id: json["id"],
      idUsuarioSeguidor: json["idUsuarioSeguidor"],
      idUsuarioSeguido: json["idUsuarioSeguido"],
      nombreCompletoSeguidor: json["nombreCompletoSeguidor"],
      rutaAvatarSeguidor: (json["rutaAvatarSeguidor"] as String).isEmpty
          ? "http://ssl.gstatic.com/accounts/ui/avatar_2x.png"
          : json["rutaAvatarSeguidor"],
      nombreCompletoSeguido: json["nombreCompletoSeguido"],
      rutaAvatarSeguido: (json["rutaAvatarSeguido"] as String).isEmpty
          ? "http://ssl.gstatic.com/accounts/ui/avatar_2x.png"
          : json["rutaAvatarSeguido"]);

  Map<String, dynamic> toJson() => {
        "id": this.id ?? 0,
        "idUsuarioSeguidor": this.idUsuarioSeguidor ?? 0,
        "idUsuarioSeguido": this.idUsuarioSeguido ?? 0,
        "nombreCompletoSeguidor": this.nombreCompletoSeguidor ?? "",
        "rutaAvatarSeguidor": this.rutaAvatarSeguidor ?? "",
        "nombreCompletoSeguido": this.nombreCompletoSeguido ?? "",
        "rutaAvatarSeguido": this.rutaAvatarSeguido ?? ""
      };
}
