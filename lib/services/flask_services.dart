import 'package:http/http.dart' as http;
// import 'dart:async';
import 'dart:convert';
// import 'dart:io';

String url = "http://127.0.0.1:5000/";

class FlaskServices {
  Future getData() async {
    var newUrl = Uri.parse("${url}getdata");
    Map data = {'apikey': '12345678901234567890'};
    var body = json.encode(data);

    var response = await http.post(newUrl,
        headers: {"Content-Type": "application/json"}, body: body);
    return jsonDecode(response.body);
  }
}
