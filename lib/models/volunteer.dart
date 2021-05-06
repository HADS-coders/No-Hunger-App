import 'dart:convert';
import 'package:NoHunger/services/db.dart';
import 'package:geolocator/geolocator.dart';
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
  Position location;
  int range;

  Volunteer(
      {this.name,
      this.number,
      this.email,
      this.gender,
      this.location,
      this.range});

  Map<String, dynamic> toMap() => {
        'name': name,
        'number': number,
        'email': email,
        'gender': gender,
        'location': location,
        'range': range
      };

  Volunteer fromMap(Map data) {
    return Volunteer(
        name: data['name'],
        number: int.parse(data['number'].toString()),
        email: data['email'],
        gender: data['gender'],
        location: data['location'],
        range: int.parse(data['range'].toString() ?? '0'));
  }

  Future<void> insertVol(Volunteer vol) async {
    final Database db = await Db.getDatabase();

    //clear the db before inserting
    // await db.delete(table);

    await db.insert('vol', vol.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.close();
  }

  Future<Volunteer> getVol() async {
    final Database db = await Db.getDatabase();
    var result = await db.query(table); //same as select * from table
    if (result != null) {
      print(result);
      var vol = Volunteer().fromMap(result[0]);
      db.close();
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
