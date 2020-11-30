import 'package:Xchangez/model/Comentario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Xchangez/services/api.services.dart';

class ComentarioServices {
  static final String _urlCreate = "Comentario/Create";
  static final String _urlDelete = "Comentario/";
  static final String _urlGetByPostId =
      "Comentario/GetComentariosByIdPublicacion/";

  // metodo para crear un comentario
  static Future<Comentario> create(Comentario nodo) async {
    // creamos la url
    String endpointUrl = APIServices.getEndPoint(
        _urlCreate, {"idPublicacion": nodo.idPublicacion.toString()});
    Map<String, String> headers = await APIServices.getHeaders(true);
    print(jsonEncode(nodo));
    final http.Response response =
        await http.post(endpointUrl, headers: headers, body: jsonEncode(nodo));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Comentario.fromJson(json.decode(response.body));
    } else {
      throw response.body;
    }
  }

  // metodo para eliminar un comentario por su id
  static Future<bool> delete(int id) async {
    // creamos la url
    String endpointUrl = APIServices.getEndPoint(_urlDelete) + id.toString();
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.delete(endpointUrl, headers: headers);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }

  // metodo para obtener todas las listas del usuario
  static Future<List<Comentario>> getAllByPostId(int id) async {
    // creamos la url
    String endpointUrl =
        APIServices.getEndPoint(_urlGetByPostId) + id.toString();
    Map<String, String> headers = await APIServices.getHeaders(false);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return (json.decode(response.body) as List)
          .map((e) => Comentario.fromJson(e))
          .toList();
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }
}
