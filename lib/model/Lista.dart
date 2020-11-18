import 'package:Xchangez/model/ObjetoLista.dart';

class Lista {
  int id;
  int idUsuario;
  int nombre;
  bool esPublico;
  List<ObjetoLista> objetos;

  Lista({this.id, this.idUsuario, this.nombre, this.esPublico, this.objetos});

  factory Lista.fromJson(Map<String, dynamic> json) => Lista(
      id: json["id"],
      idUsuario: json["idListidUsuarioaPadre"],
      nombre: json["nombre"],
      esPublico: json["esPublico"],
      objetos: json["objetos"]);

  Map<String, dynamic> toJson() => {
        "id": this.id != null ? this.id : 0,
        "idUsuario": this.idUsuario != null ? this.idUsuario : 0,
        "nombre": this.nombre != null ? this.nombre : "",
        "esPublico": this.esPublico != null ? this.esPublico : false,
        "objetos": this.objetos != null ? this.objetos : ""
      };
}
