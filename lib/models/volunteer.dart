import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Volunteer {
  final String table = 'vol';
  int? id;
  String? name;
  int? number;
  String? email;
  String? password;
  String? gender;
  double? latitude;
  double? longitude;
  int? range;

  Volunteer(
      {this.id,
      this.name,
      this.number,
      this.email,
      this.gender,
      this.latitude,
      this.longitude,
      this.range});

  Map<String, dynamic> toMap() => {
        'vol_id': id,
        'name': name,
        'number': number,
        'email': email,
        'gender': gender,
        'latitude': latitude,
        'longitude': longitude,
        'rangeKm': range,
      };

  Volunteer fromMap(Map data) {
    return Volunteer(
        id: int.parse(data['vol_id'].toString()),
        name: data['name'],
        number: int.parse(data['number'].toString()),
        email: data['email'],
        gender: data['gender'],
        latitude: double.parse(data['latitude'].toString()),
        longitude: double.parse(data['longitude'].toString()),
        range: int.parse(data['rangeKm'].toString()));
  }

  // Future<void> insertVol(Volunteer vol) async {
  //   final Database? db = await Db.getDatabase();

  //   await db!.insert('vol', vol.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  Future<Volunteer> getVol() async {
    var pref = await SharedPreferences.getInstance();
    int? volId = pref.getInt('vol_id');
    final Map<String, dynamic> param = {
      'vol_id': volId.toString(),
    };
    final url = Uri.https(
        'pure-mountain-72218.herokuapp.com', 'api/getVolunteer.php', param);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(url, headers: headers);
    Map<String, dynamic> responsebody = json.decode(response.body);
    Volunteer vol = Volunteer().fromMap(responsebody['data']);
    return vol;
  }

  // Future<Volunteer> getVolFromDb() async {
  //   final Database? db = await Db.getDatabase();
  //   List? result = await db!.query(table); //same as select * from table
  //   print('Vol from db: $result');

  //   Volunteer vol = Volunteer().fromMap(result[0]!);
  //   return vol;
  // }

  static Future<dynamic> login(String email, String password) async {
    var body = jsonEncode({'email': email, 'password': password});

    var response = await http.post(
        Uri.https('pure-mountain-72218.herokuapp.com', 'api/login.php'),
        headers: {'Content-Type': 'application/json'},
        body: body);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      bool success = responseJson['message'] == 'Login Success';
      var data = responseJson['data'];
      if (success) {
        print('login succcess');
        print('vol data from response: $data');
        var pref = await SharedPreferences.getInstance();
        await pref.setBool('loggedIn', true);
        await pref.setBool(
            'visited', true); //set onboarding screen to visited on login
        if (data != null) {
          Volunteer vol = Volunteer().fromMap(data);
          await pref.setInt('vol_id', vol.id!);
          // vol.insertVol(vol); //insert into database
          return {'success': success};
        }
      }
    }
    return {'success': false};
  }

  static void logout() async {
    // final Database? db = await Db.getDatabase();
    // await db!.delete('vol');

    var pref = await SharedPreferences.getInstance();
    pref.setBool('loggedIn', false);
    pref.remove('vol_id');
  }
}
