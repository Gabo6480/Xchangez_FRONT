class Usuario {
  int id;
  String nombre;
  String apellido;
  String password;
  String correo;
  String imagenPerfil;
  String imagenPortada;
  double valoracion;
  int cantidadSeguidores;
  int cantidadSeguidos;
  bool esPrivado;
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
      this.cantidadSeguidores = 0,
      this.cantidadSeguidos = 0,
      this.esPrivado = true,
      this.fechaNacimiento});

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      id: json["id"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      password: json["password"],
      correo: json["correo"],
      imagenPerfil: (json["rutaImagenAvatar"] as String).isEmpty
          ? "http://ssl.gstatic.com/accounts/ui/avatar_2x.png"
          : json["rutaImagenAvatar"],
      imagenPortada: (json["rutaImagenPortada"] as String).isEmpty
          ? "https://venngage-wordpress.s3.amazonaws.com/uploads/2018/09/Minimalist-Crumpled-Paper-Simple-Background-Image.jpg"
          : json["rutaImagenPortada"],
      valoracion: json["valoracion"] ?? 0.0,
      cantidadSeguidores: json["cantidadSeguidores"] ?? 0,
      cantidadSeguidos: json["cantidadSeguidos"] ?? 0,
      esPrivado: json["esPrivado"] ?? true,
      fechaNacimiento: DateTime.tryParse(json["fechaNacimiento"]));

  Map<String, dynamic> toJson() => {
        "id": this.id ?? -1,
        "nombre": this.nombre,
        "apellido": this.apellido,
        "password": this.password,
        "correo": this.correo,
        "rutaImagenAvatar": this.imagenPerfil,
        "rutaImagenPortada": this.imagenPortada,
        "valoracion": this.valoracion,
        "cantidadSeguidores": this.cantidadSeguidores,
        "cantidadSeguidos": this.cantidadSeguidos,
        "esPrivado": this.esPrivado,
        "fechaNacimiento": this.fechaNacimiento.toIso8601String()
      };
}
