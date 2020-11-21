import 'dart:convert';
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
  // es el nombre del key del token que se guarda en el storage
  static final String tokenStorageKeyName = "jwt";

  // url de la api para hacer las consultas
  static final String _urlHost = "https://xchangezapi.azurewebsites.net/api/";

  // url del endpoint de la api para logearse
  static final String _urlAuthLogin = "Auth/Login";

  // url del endpoint de la api para crear un usuario
  static final String _urlAuthCreate = "Auth/Create";

  // url del endpoint de la api para obtener un usuario por Id
  static final String _urlAuthGetUsuario = "Auth/";

  // metodo que concatena la url de la api mas un endpoint
  static String getEndPoint(String url) => _urlHost + url;

  // metodo para logearse, regresa un UserToken
  static Future<UserToken> login(UserInfo usuario) async {
    // creamos la url
    String endpointUrl = getEndPoint(_urlAuthLogin);
    Map<String, String> headers = await getHeaders(false);
    final http.Response response = await http.post(endpointUrl,
        headers: headers, body: jsonEncode(usuario));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserToken.fromJson(json.decode(response.body));
    } else {
      throw response.body;
    }
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
    Map<String, String> headers = await getHeaders(true);
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

  // metodo para obtener al usuario logeado
  static Future<Usuario> getAuthUser() async {
    int idUsuario = await _getIdUserFromToken();
    if (idUsuario == -1) return null;
    return await getUser(idUsuario);
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
