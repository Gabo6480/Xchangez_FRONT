class Comentario {
  int id;
  int idComentarioPadre;
  int idPublicacion;
  int idUsuario;
  String contenido;
  DateTime fechaAlta;

  Comentario(
      {this.id,
      this.idComentarioPadre,
      this.idPublicacion,
      this.idUsuario,
      this.contenido,
      this.fechaAlta});

  factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
      id: json["id"],
      idComentarioPadre: json["idComentarioPadre"],
      idPublicacion: json["idPublicacion"],
      idUsuario: json["idUsuario"],
      contenido: json["contenido"],
      fechaAlta: json["fechaAlta"]);

  Map<String, dynamic> toJson() => {
        "id": this.id != null ? this.id : 0,
        "idComentarioPadre": this.idComentarioPadre != null ? this.idComentarioPadre : 0,
        "idPublicacion": this.idPublicacion != null ? this.idPublicacion : 0,
        "idUsuario": this.idUsuario != null ? this.idUsuario : 0,
        "contenido": this.contenido != null ? this.contenido : "",
        "fechaAlta": this.fechaAlta != null ? this.fechaAlta.toIso8601String() : DateTime.now().toIso8601String()
      };
}
