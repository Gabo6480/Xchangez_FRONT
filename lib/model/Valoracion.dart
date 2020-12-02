class Valoracion {
  int id;
  int idUsuario;
  int idUsuarioValorado;
  String nombreCompleto;
  String rutaImagenAvatar;
  int cantidad;
  String comentario;
  DateTime fechaAlta;

  Valoracion(
      {this.id = 0,
      this.idUsuario = 0,
      this.idUsuarioValorado = 0,
      this.nombreCompleto = "",
      this.rutaImagenAvatar = "",
      this.cantidad = 0,
      this.comentario = "",
      this.fechaAlta});

  factory Valoracion.fromJson(Map<String, dynamic> json) => Valoracion(
        id: json["id"],
        idUsuario: json["idUsuario"],
        idUsuarioValorado: json["idUsuarioValorado"],
        nombreCompleto: json["nombreCompleto"],
        rutaImagenAvatar: (json["rutaImagenAvatar"] as String).isEmpty
            ? "http://ssl.gstatic.com/accounts/ui/avatar_2x.png"
            : json["rutaImagenAvatar"],
        cantidad: json["cantidad"],
        comentario: json["comentario"],
        fechaAlta: DateTime.tryParse(json["fechaAlta"]),
      );

  Map<String, dynamic> toJson() => {
        "id": this.id ?? 0,
        "idUsuario": this.idUsuario ?? 0,
        "idUsuarioValorado": this.idUsuarioValorado ?? 0,
        "rutaImagenAvatar": this.rutaImagenAvatar ?? "",
        "nombreCompleto": this.nombreCompleto ?? "",
        "cantidad": this.cantidad ?? 0,
        "comentario": this.comentario ?? "",
        "fechaAlta": this.fechaAlta != null
            ? this.fechaAlta.toIso8601String()
            : DateTime.now().toIso8601String()
      };
}
