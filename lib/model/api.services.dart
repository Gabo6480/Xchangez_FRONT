// import para consultar a la api
import 'dart:convert';

import 'package:Xchangez/model/UserInfo.dart';
import 'package:Xchangez/model/UserToken.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static String url_host = "https://localhost:44386/api/";
  static String url_login = "Auth/Login";

  static String getEndPoint(String url) {
    return "${url_host}${url}";
  }

  static Future<UserToken> login(UserInfo usuario) async {
    final http.Response response = await http.post(getEndPoint(url_login),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(usuario));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserToken.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  // static Future<http.Response> login(UserInfo nodo) async {
  //   return await http.post(
  //     getEndPoint(url_login),
  //     headers:  <String, String> {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(nodo)
  //   );
  // }
}
