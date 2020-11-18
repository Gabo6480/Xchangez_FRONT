class Publicacion {
  int id;
  int idUsuario;
  String titulo;
  String descripcion;
  String caracteristicas;
  bool esBorrador;
  double precio;
  int estado;
  DateTime fechaAlta;
  DateTime fechaModificacion;

  Publicacion(
      {this.id = 0,
      this.idUsuario,
      this.titulo,
      this.descripcion,
      this.caracteristicas,
      this.esBorrador,
      this.precio,
      this.estado,
      this.fechaAlta,
      this.fechaModificacion});

  factory Publicacion.fromJson(Map<String, dynamic> json) => Publicacion(
      id: json["id"],
      idUsuario: json["idUsuario"],
      titulo: json["titulo"],
      descripcion: json["descripcion"],
      caracteristicas: json["caracteristicas"],
      esBorrador: json["esBorrador"],
      precio: json["precio"],
      estado: json["estado"],
      fechaAlta: DateTime.tryParse(json["fechaAlta"]),
      fechaModificacion: DateTime.tryParse(json["fechaModificacion"]));

  Map<String, dynamic> toJson() => {
        "id": this.id != null ? this.id : 0,
        "idUsuario": this.idUsuario != null ? this.idUsuario : 0,
        "titulo": this.titulo != null ? this.titulo : "",
        "descripcion": this.descripcion != null ? this.descripcion : "",
        "caracteristicas": this.caracteristicas != null ? this.caracteristicas : "",
        "esBorrador": this.esBorrador != null ? this.esBorrador : false,
        "precio": this.precio != null ? this.precio : 0,
        "estado": this.estado != null ? this.estado : 0,
        "fechaAlta": this.fechaAlta != null ? this.fechaAlta.toIso8601String() : DateTime.now().toIso8601String(),
        "fechaModificacion": this.fechaModificacion != null ? this.fechaAlta.toIso8601String() : DateTime.now().toIso8601String()
      };
}
