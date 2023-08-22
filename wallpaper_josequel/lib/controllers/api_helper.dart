import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiHelper {
  final String DOMAIN = "api.pexels.com";

  Future<String> getToken() async {
    var storage = const FlutterSecureStorage();
    bool check = await storage.containsKey(key: "token");
    if (check) {
      String result = await storage.read(key: "token") as String;
      return result;
    }
    return "";
  }

  Future<dynamic> getRequest(
      {required String path, Map<String, String>? queryParameters}) async {
    try {
      var headers = {
        'Authorization': 'iDQlOQE0FQzfChLM2bQ4w1PZQgI9GCHMouFRIJuh2lYzhDS5es5bmNNe',
      };
      http.Response response = await http.get( Uri.parse('https://api.pexels.com/$path?per_page=${queryParameters!['per_page']}&page=${queryParameters['page']}&query=${queryParameters["query"]}'), headers: headers,);
      return responseFunction(response);
    } catch (ex) {
      return ex;
    }
  }

  dynamic responseFunction(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic jsonObject = jsonDecode(response.body);
        return jsonObject;
      case 400:
        throw "Bad Request";
      case 401:
        throw "Unauthrizied";
      case 402:
        throw "Payment Required";
      case 403:
        throw "Forbidden";
      case 404:
        throw "Not Found";
      case 500:
        throw "Server Error :(";
      default:
        throw "Server Error :(";
    }
  }
}
//iDQlOQE0FQzfChLM2bQ4w1PZQgI9GCHMouFRIJuh2lYzhDS5es5bmNNe
