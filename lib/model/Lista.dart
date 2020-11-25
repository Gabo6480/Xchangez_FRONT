import 'package:Xchangez/model/ObjetoLista.dart';

class Lista {
  int id;
  int idUsuario;
  String nombre;
  String descripcion;
  bool esPublico;
  List<ObjetoLista> objetos;

  Lista(
      {this.id,
      this.idUsuario,
      this.nombre,
      this.descripcion,
      this.esPublico,
      this.objetos});

  factory Lista.fromJson(Map<String, dynamic> json) => Lista(
      id: json["id"],
      idUsuario: json["idUsuario"],
      nombre: json["nombre"],
      descripcion: json["descripcion"],
      esPublico: json["esPublico"],
      objetos: (json["objetos"] as List)
          .map((e) => ObjetoLista.fromJson(e))
          .toList());

  Map<String, dynamic> toJson() => {
        "id": this.id ?? 0,
        "idUsuario": this.idUsuario ?? 0,
        "nombre": this.nombre ?? "",
        "descripcion": this.descripcion ?? "",
        "esPublico": this.esPublico ?? false,
        "objetos": this.objetos ?? []
      };
}
