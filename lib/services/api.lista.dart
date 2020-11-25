import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Xchangez/model/Lista.dart';
import 'package:Xchangez/services/api.services.dart';

// esta clase esta destinada para funcionar como apiservices.dart
// pero enfocada al controlador ListaServices de la Web API
class ListaServices {
  static final String _urlCreate = "Lista/Create";
  static final String _urlGetById = "Lista/";
  static final String _urlGetByUserId = "Lista/GetByIdUsuario/";

  // metodo para crear una publicación
  static Future<Lista> create(Lista nodo) async {
    // creamos la url
    String endpointUrl = APIServices.getEndPoint(_urlCreate);
    Map<String, String> headers = await APIServices.getHeaders(true);
    print(jsonEncode(nodo));
    final http.Response response =
        await http.post(endpointUrl, headers: headers, body: jsonEncode(nodo));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Lista.fromJson(json.decode(response.body));
    } else {
      throw response.body;
    }
  }

  // metodo para obtener una lista por su id
  static Future<Lista> get(int id) async {
    // creamos la url
    String endpointUrl = APIServices.getEndPoint(_urlGetById) + id.toString();
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Lista.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }

  // metodo para obtener todas las listas del usuario
  static Future<List<Lista>> getAllByUserId(int id) async {
    // creamos la url
    String endpointUrl =
        APIServices.getEndPoint(_urlGetByUserId) + id.toString();
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Lista> listas = (json.decode(response.body) as List)
          .map((e) => Lista.fromJson(e))
          .toList();

      return listas;
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }
}
