import 'dart:convert';

enum Estado { indefinido, nuevo, usado }

class Publicacion {
  int id;
  int idUsuario;
  String thumbnail;
  String titulo;
  String descripcion;
  Map<String, dynamic> caracteristicas;
  bool esBorrador;
  double precio;
  Estado estado;
  bool esTrueque;
  DateTime fechaAlta;
  DateTime fechaModificacion;

  Publicacion(
      {this.id = 0,
      this.idUsuario = 0,
      this.thumbnail =
          "https://static.addtoany.com/images/dracaena-cinnabari.jpg",
      this.titulo = "",
      caracteristicas,
      this.descripcion = "",
      this.esBorrador = true,
      this.precio = 0,
      this.estado = Estado.indefinido,
      this.esTrueque = true,
      this.fechaAlta,
      this.fechaModificacion}) {
    this.caracteristicas = caracteristicas ?? {};
    this.fechaAlta = this.fechaAlta ?? DateTime.now();
    this.fechaModificacion = this.fechaModificacion ?? DateTime.now();
  }

  factory Publicacion.fromJson(Map<String, dynamic> j) => Publicacion(
      id: j["id"],
      idUsuario: j["idUsuario"],
      thumbnail: j["thumbnail"] ??
          "https://static.addtoany.com/images/dracaena-cinnabari.jpg",
      titulo: j["titulo"],
      descripcion: j["descripcion"],
      caracteristicas: json.decode(j["caracteristicas"]),
      esBorrador: j["esBorrador"],
      precio: j["precio"],
      estado: Estado.values[j["estado"]],
      esTrueque: j["esTrueque"],
      fechaAlta: DateTime.tryParse(j["fechaAlta"]),
      fechaModificacion: DateTime.tryParse(j["fechaModificacion"]));

  Map<String, dynamic> toJson() => {
        "id": this.id ?? 0,
        "idUsuario": this.idUsuario ?? 0,
        "thumbnail": this.thumbnail ?? "",
        "titulo": this.titulo ?? "",
        "descripcion": this.descripcion ?? "",
        "caracteristicas": json.encode(this.caracteristicas) ?? "{}",
        "esBorrador": this.esBorrador ?? false,
        "precio": this.precio ?? 0,
        "estado": (this.estado ?? Estado.indefinido).index,
        "esTrueque": this.esTrueque ?? false,
        "fechaAlta": this.fechaAlta != null
            ? this.fechaAlta.toIso8601String()
            : DateTime.now().toIso8601String(),
        "fechaModificacion": this.fechaModificacion != null
            ? this.fechaModificacion.toIso8601String()
            : DateTime.now().toIso8601String()
      };
}
