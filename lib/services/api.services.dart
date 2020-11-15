// import para consultar a la api
import 'dart:convert';

import 'package:Xchangez/model/UserInfo.dart';
import 'package:Xchangez/model/UserToken.dart';
import 'package:Xchangez/model/Usuario.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static String _urlHost = "https://localhost:44386/api/";
  static String _urlAuthLogin = "Auth/Login";
  static String _urlAuthCreate = "Auth/Create";

  static String _getEndPoint(String url) => _urlHost + url;

  static Future<UserToken> login(UserInfo usuario) async {
    final http.Response response = await http.post(_getEndPoint(_urlAuthLogin),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(usuario));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserToken.fromJson(json.decode(response.body));
    } else {
      throw response.body;
    }
  }

  static Future<Usuario> register(Usuario usuario) async {
    final http.Response response = await http.post(_getEndPoint(_urlAuthCreate),
      headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(usuario)
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Usuario.fromJson(json.decode(response.body));
    } else {
      throw response.body;
    }
  }
}
