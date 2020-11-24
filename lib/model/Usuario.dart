class Usuario {
  int id;
  String nombre;
  String apellido;
  String password;
  String correo;
  String imagenPerfil;
  String imagenPortada;
  double valoracion;
  DateTime fechaNacimiento;

  Usuario(
      {this.id = -1,
      this.nombre = "",
      this.apellido = "",
      this.password = "",
      this.correo = "",
      this.imagenPerfil = "",
      this.imagenPortada = "",
      this.valoracion = 0.0,
      this.fechaNacimiento});

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      id: json["id"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      password: json["password"],
      correo: json["correo"],
      imagenPerfil: json["rutaImagenAvatar"] ??
          "http://ssl.gstatic.com/accounts/ui/avatar_2x.png",
      imagenPortada: json["rutaImagenPortada"] ??
          "https://venngage-wordpress.s3.amazonaws.com/uploads/2018/09/Minimalist-Crumpled-Paper-Simple-Background-Image.jpg",
      valoracion: json["valoracion"] ?? 0.0,
      fechaNacimiento: DateTime.tryParse(json["fechaNacimiento"]));

  Map<String, dynamic> toJson() => {
        "id": this.id != null ? this.id : -1,
        "nombre": this.nombre,
        "apellido": this.apellido,
        "password": this.password,
        "correo": this.correo,
        "rutaImagenAvatar": this.imagenPerfil,
        "rutaImagenPortada": this.imagenPortada,
        "valoracion": this.valoracion,
        "fechaNacimiento": this.fechaNacimiento.toIso8601String()
      };
}
