import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  final String url;
  NetworkHelper({this.url});

  Future<dynamic> getData() async {
    Response response = await get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedata = jsonDecode(data);
      return decodedata;
    } else {
      print(response.statusCode);
    }
  }
}
