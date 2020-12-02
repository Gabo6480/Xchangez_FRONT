import 'package:Xchangez/model/Valoracion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Xchangez/services/api.services.dart';

class ValoracionServices {
  static final String _urlCreate = "Valoracion/Create";
  static final String _urlGetAllForUser =
      "Valoracion/GetValoracionesByIdUsuarioValorado/";
  static final String _urlHasScored = "Valoracion/YaFueValorado/";

  // metodo para crear un comentario
  static Future<Valoracion> create(Valoracion nodo) async {
    // creamos la url
    String endpointUrl = APIServices.getEndPoint(
        _urlCreate, {"idUsuario": nodo.idUsuarioValorado.toString()});
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.post(endpointUrl, headers: headers, body: jsonEncode(nodo));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Valoracion.fromJson(json.decode(response.body));
    } else {
      throw response.body;
    }
  }

  // metodo para obtener todas las listas del usuario
  static Future<List<Valoracion>> getAllForUserId(int id) async {
    // creamos la url
    String endpointUrl =
        APIServices.getEndPoint(_urlGetAllForUser) + id.toString();
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return (json.decode(response.body) as List)
          .map((e) => Valoracion.fromJson(e))
          .toList();
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }

  static Future<bool> hasAlreadyScored(int id) async {
    String endpointUrl = APIServices.getEndPoint(_urlHasScored) + id.toString();
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return response.body == "true";
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }
}
