// ignore_for_file: unused_import, avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{
  //creating a constructor with parameter for an URL
  NetworkHelper(this.url);
  final String url;
  
  //'getData' function to get the result from the api call using 'get' function
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('Status Code: ${response.statusCode}');
    }
  }
}
