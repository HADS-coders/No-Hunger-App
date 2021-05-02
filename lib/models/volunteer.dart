import 'dart:convert';
import 'package:http/http.dart' as http;

class Volunteer {
  String name;
  String username;
  String email;
  int number;
  String password;
  String gender;

  Volunteer();

  static Future<String> login(String email, String password) async {
    var body = jsonEncode({'email': email, 'password': password});

    var response = await http.post(
        Uri.https('pure-mountain-72218.herokuapp.com', 'api/login.php'),
        headers: {'Content-Type': 'application/json'},
        body: body);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body.toString());
      print(responseJson['message']);
      return responseJson['message'];
    }
    return 'Network issue, Login failed';
  }
}
