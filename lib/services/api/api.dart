import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riafymachinetest/services/api_constants.dart';



// class to handle all api calls
class Api {
  // method to postData
  // [route] - specifies to which endpoint the data should be send.
  // [mBody] - Parameter to pass the data to the server
  // [header] - parameter to pass tokens

  static Future<dynamic> getData(String route, {
    String token,
  }) async {
    var uri = Uri.parse(route);
    Map<String, String> mHeaders = {
      "Content-type": "application/json",
    };
    try {
      print('API -> ${route}');
      http.Response response = await http.get(
        uri,
        headers: mHeaders,
      );
      print('Response-(${response.statusCode})== ${response.body}');
      return jsonDecode(response.body);
    } catch (error, s) {
      print(s);
      return null;
    }
  }

}
