class Comentario {
  int id;
  int idComentarioPadre;
  int idPublicacion;
  int idUsuario;
  String nombreCompleto;
  String rutaImagenAvatar;
  String contenido;
  DateTime fechaAlta;

  List<Comentario> comentarios;

  Comentario(
      {this.id = 0,
      this.idComentarioPadre = 0,
      this.idPublicacion = 0,
      this.idUsuario = 0,
      this.nombreCompleto = "",
      this.rutaImagenAvatar = "",
      this.contenido = "",
      this.fechaAlta,
      this.comentarios});

  factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
      id: json["id"],
      idComentarioPadre: json["idComentarioPadre"],
      idPublicacion: json["idPublicacion"],
      idUsuario: json["idUsuario"],
      contenido: json["contenido"],
      nombreCompleto: json["nombreCompleto"],
      rutaImagenAvatar: json["rutaImagenAvatar"],
      fechaAlta: DateTime.tryParse(json["fechaAlta"]),
      comentarios: json["comentarios"] != null
          ? (json["comentarios"] as List)
              .map((e) => Comentario.fromJson(e))
              .toList()
          : []);

  Map<String, dynamic> toJson() => {
        "id": this.id ?? 0,
        "idComentarioPadre": this.idComentarioPadre ?? 0,
        "idPublicacion": this.idPublicacion ?? 0,
        "idUsuario": this.idUsuario ?? 0,
        "contenido": this.contenido ?? "",
        "rutaImagenAvatar": this.rutaImagenAvatar ?? "",
        "nombreCompleto": this.nombreCompleto ?? "",
        "fechaAlta": this.fechaAlta != null
            ? this.fechaAlta.toIso8601String()
            : DateTime.now().toIso8601String(),
        "comentarios": this.comentarios ?? []
      };
}
