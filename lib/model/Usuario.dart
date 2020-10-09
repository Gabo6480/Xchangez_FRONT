class Usuario {
  int id;
  String nombre;
  String apellido;
  String password;
  String correo;
  DateTime fechaNacimiento;

  Usuario(
      {this.id,
      this.nombre,
      this.apellido,
      this.password,
      this.correo,
      this.fechaNacimiento});

  factory Usuario.fromJson(Map<String, dynamic> json) =>
    Usuario(
      id: json["id"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      password: json["password"],
      correo: json["correo"],
      fechaNacimiento: DateTime.tryParse(json["fechaNacimiento"])
    );

  Map<String, dynamic> toJson() =>
    {
      "id": this.id != null ? this.id : 0,
      "nombre": this.nombre,
      "apellido": this.apellido,
      "password": this.password,
      "correo": this.correo,
      "fechaNacimiento": this.fechaNacimiento.toIso8601String()
    };
}
