import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Xchangez/model/Publicacion.dart';
import 'package:Xchangez/services/api.services.dart';

// esta clase esta destinada para funcionar como apiservices.dart
// pero enfocada al controlador PublicacionController de la Web API
class PublicacionServices {
  static final String _urlCreate = "Publicacion/Create";
  static final String _urlGetById = "Publicacion/";
  static final String _urlGet = "Publicacion/Publicaciones";

  // metodo para crear una publicación
  static Future<Publicacion> create(Publicacion nodo) async {
    // creamos la url
    String endpointUrl = APIServices.getEndPoint(_urlCreate);
    Map<String, String> headers = await APIServices.getHeaders(true);
    print(jsonEncode(nodo.toJson()));
    final http.Response response =
        await http.post(endpointUrl, headers: headers, body: jsonEncode(nodo.toJson()));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Publicacion.fromJson(json.decode(response.body));
    } else {
      throw response.body;
    }
  }

  // metodo para obtener una publicacion por su id
  static Future<Publicacion> get(int id) async {
    // creamos la url
    String endpointUrl = APIServices.getEndPoint(_urlGetById) + id.toString();
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Publicacion.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }

  // metodo para obtener todas las publicaciones
  static Future<Publicacion> getAll() async {
    // creamos la url
    String endpointUrl = APIServices.getEndPoint(_urlGet);
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Publicacion.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }
}
