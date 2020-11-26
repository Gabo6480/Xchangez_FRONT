class Publicacion {
  int id;
  int idUsuario;
  String titulo;
  String descripcion;
  String caracteristicas;
  bool esBorrador;
  double precio;
  int estado;
  bool esTrueque;
  DateTime fechaAlta;
  DateTime fechaModificacion;

  Publicacion(
      {this.id = 0,
      this.idUsuario,
      this.titulo,
      this.descripcion,
      this.caracteristicas,
      this.esBorrador = false,
      this.precio,
      this.estado,
      this.esTrueque = false,
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
      esTrueque: json["esTrueque"],
      fechaAlta: DateTime.tryParse(json["fechaAlta"]),
      fechaModificacion: DateTime.tryParse(json["fechaModificacion"]));

  Map<String, dynamic> toJson() => {
        "id": this.id ?? 0,
        "idUsuario": this.idUsuario ?? 0,
        "titulo": this.titulo ?? "",
        "descripcion": this.descripcion ?? "",
        "caracteristicas": this.caracteristicas ?? "",
        "esBorrador": this.esBorrador ?? false,
        "precio": this.precio ?? 0,
        "estado": this.estado ?? 0,
        "esTrueque": this.esTrueque ?? false,
        "fechaAlta": this.fechaAlta != null
            ? this.fechaAlta.toIso8601String()
            : DateTime.now().toIso8601String(),
        "fechaModificacion": this.fechaModificacion != null
            ? this.fechaAlta.toIso8601String()
            : DateTime.now().toIso8601String()
      };
}
