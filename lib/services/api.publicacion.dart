import 'package:Xchangez/model/ArchivoPublicacion.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Xchangez/model/Publicacion.dart';
import 'package:Xchangez/services/api.services.dart';

// esta clase esta destinada para funcionar como apiservices.dart
// pero enfocada al controlador PublicacionController de la Web API
class PublicacionServices {
  static final String _urlCreate = "Publicacion/Create";
  static final String _urlAddVisit = "Publicacion/AgregarUnaVisita";
  static final String _urlAddFile = "Publicacion/AddFile";
  static final String _urlGetById = "Publicacion/";
  static final String _urlDeleteById = "Publicacion/";
  static final String _urlUpdateById = "Publicacion";
  static final String _urlGetFilesByPostId = "Publicacion/GetFiles/";
  static final String _urldeleteFileById = "Publicacion/DeleteFile/";
  static final String _urldeleteAllFilesFromPost =
      "Publicacion/DeleteMultimediasByIdPublicacion/";
  static final String _urlGetAllFromUser =
      "Publicacion/PublicacionesByIdUsuario/";
  static final String _urlGet = "Publicacion/Publicaciones/";
  static final String _urlGetRelevant = "Publicacion/PublicacionesRelevantes/";
  static final String _urlGetRecent = "Publicacion/PublicacionesRecientes/";

  // metodo para crear una publicación
  static Future<Publicacion> create(Publicacion nodo) async {
    // creamos la url
    String endpointUrl = APIServices.getEndPoint(_urlCreate);
    Map<String, String> headers = await APIServices.getHeaders(true);
    //print(jsonEncode(nodo.toJson()));
    final http.Response response =
        await http.post(endpointUrl, headers: headers, body: jsonEncode(nodo));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Publicacion.fromJson(json.decode(response.body));
    } else {
      throw response.body;
    }
  }

  //metodo para agregar un archivo a la publicación
  static Future<bool> addFile(int idPublicacion, PlatformFile archivo) async {
    String endpointUrl = APIServices.getEndPoint(_urlAddFile);
    Map<String, String> headers = await APIServices.getHeadersMultiPart(true);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(endpointUrl),
    )
      ..headers.addAll(headers)
      ..fields['idPublicacion'] = idPublicacion.toString()
      ..files.add(http.MultipartFile.fromBytes('archivo', archivo.bytes,
          filename: archivo.name));

    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return true;
    } else {
      throw response.body;
    }
  }

  // metodo para eliminar un archivo por su id
  static Future<bool> deleteFileById(int id) async {
    // creamos la url
    String endpointUrl =
        APIServices.getEndPoint(_urldeleteFileById) + id.toString();
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

  static Future<bool> deleteAllFilesFromPost(int id) async {
    // creamos la url
    String endpointUrl =
        APIServices.getEndPoint(_urldeleteAllFilesFromPost) + id.toString();
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

  // metodo para obtener una publicacion por su id
  static Future<Publicacion> getPost(int id) async {
    // creamos la url
    String endpointUrl = APIServices.getEndPoint(_urlGetById) + id.toString();
    Map<String, String> headers = await APIServices.getHeaders(false);
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

  // metodo para eliminar una publicacion por su id
  static Future<bool> deletePost(int id) async {
    // creamos la url
    String endpointUrl =
        APIServices.getEndPoint(_urlDeleteById) + id.toString();
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

  // metodo para eliminar una publicacion por su id
  static Future<bool> updatePost(Publicacion nodo) async {
    // creamos la url
    String endpointUrl =
        APIServices.getEndPoint(_urlUpdateById, {"id": nodo.id.toString()});
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.post(endpointUrl, headers: headers, body: jsonEncode(nodo));
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

  // metodo para eliminar una publicacion por su id
  static Future<bool> addVisita(int id) async {
    // creamos la url
    String endpointUrl =
        APIServices.getEndPoint(_urlAddVisit, {"id": id.toString()});
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.post(endpointUrl, headers: headers);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      print("Visitao");
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }

  // metodo para obtener los archivos de una publicación por su di
  static Future<List<ArchivoPublicacion>> getFilesByPostId(int id) async {
    // creamos la url
    String endpointUrl =
        APIServices.getEndPoint(_urlGetFilesByPostId) + id.toString();
    Map<String, String> headers = await APIServices.getHeaders(false);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return (json.decode(response.body) as List)
          .map((e) => ArchivoPublicacion.fromJson(e))
          .toList();
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }

  // metodo para obtener todas las publicaciones
  static Future<List<Publicacion>> getAllfromUser(int userID) async {
    // creamos la url
    String endpointUrl =
        APIServices.getEndPoint(_urlGetAllFromUser) + userID.toString();
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return (json.decode(response.body) as List)
          .map((e) => Publicacion.fromJson(e))
          .toList();
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }

  // metodo para obtener todas las publicaciones
  static Future<List<Publicacion>> getAll({int quantity = 20}) async {
    // creamos la url
    String endpointUrl = APIServices.getEndPoint(_urlGet) + quantity.toString();
    Map<String, String> headers = await APIServices.getHeaders(false);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return (json.decode(response.body) as List)
          .map((e) => Publicacion.fromJson(e))
          .toList();
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }

  // metodo para obtener todas las publicaciones relevantes
  static Future<List<Publicacion>> getAllRelevant({int quantity = 20}) async {
    // creamos la url
    String endpointUrl =
        APIServices.getEndPoint(_urlGetRelevant) + quantity.toString();
    Map<String, String> headers = await APIServices.getHeaders(false);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return (json.decode(response.body) as List)
          .map((e) => Publicacion.fromJson(e))
          .toList();
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }

  // metodo para obtener todas las publicaciones recent
  static Future<List<Publicacion>> getAllRecent({int quantity = 20}) async {
    // creamos la url
    String endpointUrl =
        APIServices.getEndPoint(_urlGetRecent) + quantity.toString();
    Map<String, String> headers = await APIServices.getHeaders(false);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return (json.decode(response.body) as List)
          .map((e) => Publicacion.fromJson(e))
          .toList();
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }
}
