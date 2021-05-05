import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Volunteer {
  String name;
  int number;
  String email;
  String password;
  String gender;
  Position location;
  int range;

  Volunteer();

  static login(String email, String password) async {
    var body = jsonEncode({'email': email, 'password': password});

    var response = await http.post(
        Uri.https('pure-mountain-72218.herokuapp.com', 'api/login.php'),
        headers: {'Content-Type': 'application/json'},
        body: body);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body.toString());
      bool success = responseJson['message'] == 'Login Success';
      if (success) {
        var pref = await SharedPreferences.getInstance();
        pref.setBool('loggedIn', true);
      }
      return success;
    }
    return false;
  }

  static logout() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool('loggedIn', false);
  }
}
