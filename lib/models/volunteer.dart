import 'dart:convert';
import 'package:NoHunger/services/db.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';

class Volunteer {
  final String table = 'vol';
  String name;
  int number;
  String email;
  String password;
  String gender;
  double latitude;
  double longitude;
  int range;

  Volunteer(
      {this.name,
      this.number,
      this.email,
      this.gender,
      this.latitude,
      this.longitude,
      this.range});

  Map<String, dynamic> toMap() => {
        'name': name,
        'number': number,
        'email': email,
        'gender': gender,
        'latitude': latitude,
        'longitude': longitude,
        'range': range
      };

  Volunteer fromMap(Map data) {
    return Volunteer(
        name: data['name'],
        number: int.parse(data['number'].toString()),
        email: data['email'],
        gender: data['gender'],
        latitude: double.parse(data['latitude'].toString()),
        longitude: double.parse(data['longitude'].toString()),
        range: int.parse(data['range'].toString() ?? '0'));
  }

  Future<void> insertVol(Volunteer vol) async {
    final Database db = await Db.getDatabase();

    await db.insert('vol', vol.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Volunteer> getVol() async {
    final Database db = await Db.getDatabase();
    var result = await db.query(table); //same as select * from table
    if (result != null) {
      print('Vol from db: $result');
      var vol = Volunteer().fromMap(result[0]);
      return vol;
    } else
      return null;
  }

  static Future<dynamic> login(String email, String password) async {
    var body = jsonEncode({'email': email, 'password': password});

    var response = await http.post(
        Uri.https('pure-mountain-72218.herokuapp.com', 'api/login.php'),
        headers: {'Content-Type': 'application/json'},
        body: body);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      bool success = responseJson['message'] == 'Login Success';
      var data = responseJson['data'] ??
          {
            'name': 'Daniyal Dolare',
            'number': 7894561230,
            'email': 'daniyal.dolare@gmail.com',
            'gender': 'Male',
            'range': 2
          };
      if (success) {
        print('login succcess');
        print('vol data from response: $data');
        var pref = await SharedPreferences.getInstance();
        pref.setBool('loggedIn', true);
        if (data != null) {
          Volunteer vol = Volunteer().fromMap(data);
          vol.insertVol(vol);
          return {'success': success, 'data': vol};
        }
      }
    }
    return {'success': false};
  }

  static void logout() async {
    final Database db = await Db.getDatabase();
    await db.delete('vol');

    var pref = await SharedPreferences.getInstance();
    pref.setBool('loggedIn', false);
  }
}
