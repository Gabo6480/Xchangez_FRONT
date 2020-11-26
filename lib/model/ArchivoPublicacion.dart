class ArchivoPublicacion {
  int id;
  int idPublicacion;
  String ruta;
  String nombre;
  String
      ecstension; //está mal escrito porque "extension" es una palabra reservada
  DateTime fechaAlta;

  ArchivoPublicacion(
      {this.id = 0,
      this.idPublicacion = 0,
      this.ruta = "",
      this.nombre = "",
      this.ecstension = "",
      this.fechaAlta});

  factory ArchivoPublicacion.fromJson(Map<String, dynamic> json) =>
      ArchivoPublicacion(
          id: json["id"],
          idPublicacion: json["idPublicacion"],
          ruta: json["ruta"],
          nombre: json["nombre"],
          ecstension: json["extension"],
          fechaAlta: DateTime.tryParse(json["fechaAlta"]));

  Map<String, dynamic> toJson() => {
        "id": this.id ?? 0,
        "idPublicacion": this.idPublicacion ?? 0,
        "ruta": this.ruta ?? "",
        "nombre": this.nombre ?? "",
        "extension": this.ecstension ?? "",
        "fechaAlta": this.fechaAlta != null
            ? this.fechaAlta.toIso8601String()
            : DateTime.now().toIso8601String()
      };
}
