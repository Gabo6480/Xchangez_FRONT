import 'dart:convert';
import 'package:file_picker/src/platform_file.dart';
import 'package:Xchangez/model/UserInfo.dart';
import 'package:Xchangez/model/UserToken.dart';
import 'package:Xchangez/model/Usuario.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// en esta clase estoy poniendo todo lo que podría ser glboal en la aplicación
// (login, registro, consulta de usuario autenticado)
// habrá otras clases para hacer consultar a otras tablas de la bd
class APIServices {
  static Usuario loggedInUser;

  // es el nombre del key del token que se guarda en el storage
  static final String tokenStorageKeyName = "jwt";

  // url de la api para hacer las consultas
  static final String _urlHost = "xchangezapi.azurewebsites.net";

  // url del endpoint de la api para logearse
  static final String _urlAuthLogin = "Auth/Login";

  // url del endpoint de la api para crear un usuario
  static final String _urlAuthCreate = "Auth/Create";

  // url del endpoint de la api para subir las imagenes de los perfiles
  static final String _urlAuthUpdateAvatarImage = "Auth/UpdateAvatarImage";

  // url del endpoint de la api para obtener un usuario por Id
  static final String _urlAuthGetUsuario = "Auth/";

  // metodo que concatena la url de la api mas un endpoint
  static String getEndPoint(String url,
          [Map<String, String> queryParameters]) =>
      Uri.https(_urlHost, "/api/" + url, queryParameters).toString();

  // metodo para logearse, regresa un UserToken
  static Future<UserToken> login(UserInfo usuario) async {
    // creamos la url
    String endpointUrl = getEndPoint(_urlAuthLogin);
    Map<String, String> headers = await getHeaders(false);
    final http.Response response = await http.post(endpointUrl,
        headers: headers, body: jsonEncode(usuario));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var token = UserToken.fromJson(json.decode(response.body));
      // guardamos el token en el storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(tokenStorageKeyName, token.token);

      await getAuthUser();

      return token;
    } else {
      throw response.body;
    }
  }

  static Future<bool> disposeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    return true;
  }

  // metodo para registrar un usuario
  static Future<Usuario> register(Usuario usuario) async {
    // creamos la url (https://localhost:44386/api/Auth/Create)
    String endpointUrl = getEndPoint(_urlAuthCreate);
    Map<String, String> headers = await getHeaders(false);
    final http.Response response = await http.post(endpointUrl,
        headers: headers, body: jsonEncode(usuario));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Usuario.fromJson(json.decode(response.body));
    } else {
      throw response.body;
    }
  }

  // metodo para obtener un usuario por su id
  static Future<Usuario> getUser(int id) async {
    // creamos la url (ejemplo: https://localhost:44386/api/Auth/1)
    String endpointUrl = getEndPoint(_urlAuthGetUsuario) + id.toString();
    Map<String, String> headers = await getHeaders(false);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Usuario.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }

  // metodo para actualizar una imagen del perfil
  static Future<bool> updateAvatar(PlatformFile imagen, int tipoImagen) async {
    // creamos la url (https://localhost:44386/api/Auth/UpdateAvatarImage)
    String endpointUrl = getEndPoint(_urlAuthUpdateAvatarImage);
    Map<String, String> headers = await getHeadersMultiPart(true);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(endpointUrl),
    )
      ..headers.addAll(headers)
      ..fields['tipoImagen'] = tipoImagen.toString()
      ..files.add(http.MultipartFile.fromBytes('imagen', imagen.bytes,
          filename: imagen.name));

    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return true;
    } else {
      throw response.body;
    }
  }

  static Future<Map<String, String>> getHeaders(bool withAuthorization) async {
    if (withAuthorization) {
      // construimos el token con la palabra bearer
      String bearerToken = "Bearer " + await _getTokenFromStorage();
      return {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": bearerToken,
      };
    } else {
      return {'Content-Type': 'application/json; charset=UTF-8'};
    }
  }

  static Future<Map<String, String>> getHeadersMultiPart(
      bool withAuthorization) async {
    if (withAuthorization) {
      // construimos el token con la palabra bearer
      String bearerToken = "Bearer " + await _getTokenFromStorage();
      return {
        'Content-Type': 'multipart/form-data',
        "Authorization": bearerToken,
      };
    } else {
      return {'Content-Type': 'multipart/form-data'};
    }
  }

  // metodo para obtener al usuario logeado
  static Future<Usuario> getAuthUser() async {
    int idUsuario = await _getIdUserFromToken();
    if (idUsuario == -1) return null;
    loggedInUser = await getUser(idUsuario);
    return loggedInUser;
  }

  static Usuario getLoggedUser() {
    return loggedInUser;
  }

  static bool isLoggedUserId(int id) {
    if (loggedInUser != null) return loggedInUser.id == id;

    return false;
  }

  // metodo para obtener el id del usuario logeado
  static Future<int> _getIdUserFromToken() async {
    Map<String, dynamic> decodedMapToken = await _getDecodedToken();
    if (decodedMapToken == null) return -1;
    // en la key 'unique_name' se encuentra el id del usuario
    return int.parse(decodedMapToken["unique_name"].toString());
  }

  // metodo para decodificar el token del usuario logeado
  static Future<Map<String, dynamic>> _getDecodedToken() async {
    String token = await _getTokenFromStorage();
    if (token == "") return null;
    return JwtDecoder.decode(token);
  }

  // metodo para obtener el token del usuario logeado
  static Future<String> _getTokenFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenStorageKeyName) ?? "";
  }
}
