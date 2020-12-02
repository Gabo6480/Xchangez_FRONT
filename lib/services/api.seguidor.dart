import 'package:Xchangez/model/Seguidor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Xchangez/services/api.services.dart';

class SeguidorServices {
  static final String _urlCreate = "Seguidor/Create";
  static final String _urlDelete = "Seguidor/";
  static final String _urlHasFollowed = "Seguidor/EstaSiguiendoloByIdUsuario";
  static final String _urlGetFollowersFromUser =
      "Seguidor/SeguidoresByIdUsuario";
  static final String _urlGetFollowedByUser =
      "Seguidor/SeguimientosByIdUsuario";

  static Future<bool> create(int id) async {
    String endpointUrl =
        APIServices.getEndPoint(_urlCreate, {"id": id.toString()});
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.post(endpointUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw response.body;
    }
  }

  static Future<bool> delete(int id) async {
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

  static Future<List<Seguidor>> getAllFollowersFromUserId(int id) async {
    String endpointUrl = APIServices.getEndPoint(
        _urlGetFollowersFromUser, {"id": id.toString()});
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return (json.decode(response.body) as List)
          .map((e) => Seguidor.fromJson(e))
          .toList();
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }

  static Future<List<Seguidor>> getAllFollowingByUserId(int id) async {
    String endpointUrl =
        APIServices.getEndPoint(_urlGetFollowedByUser, {"id": id.toString()});
    Map<String, String> headers = await APIServices.getHeaders(true);
    final http.Response response =
        await http.get(endpointUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return (json.decode(response.body) as List)
          .map((e) => Seguidor.fromJson(e))
          .toList();
    } else if (response.statusCode == 401) {
      throw Exception("");
    } else {
      throw response.body;
    }
  }

  static Future<bool> hasAlreadyFollowed(int id) async {
    String endpointUrl =
        APIServices.getEndPoint(_urlHasFollowed, {"id": id.toString()});
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
