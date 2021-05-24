import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:NoHunger/models/volunteer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VolunteerProfile extends StatefulWidget {
  @override
  _VolunteerProfileState createState() => _VolunteerProfileState();
}

class _VolunteerProfileState extends State<VolunteerProfile> {
  Volunteer? vol;
  var _formKey = GlobalKey<FormState>();
  bool _enabled = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController range = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    vol = arg['data'];
    name.text = vol!.name!;
    email.text = vol!.email!;
    number.text = vol!.number!.toString();
    range.text = vol!.range!.toString();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Volunteer Profile'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  enabled: _enabled,
                  controller: name,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "First Name cannot be empty";
                    else
                      return null;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  enabled: _enabled,
                  controller: email,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Email cannot be empty";
                    else
                      return null;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextFormField(
                  enabled: _enabled,
                  controller: number,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Number cannot be empty";
                    else
                      return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Number',
                  ),
                ),
                TextFormField(
                  enabled: _enabled,
                  controller: range,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Range cannot be empty";
                    else
                      return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Range(Km)',
                  ),
                ),
                Spacer(),
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        if (_enabled) {
                          print('enabled=$_enabled');
                          if (_formKey.currentState!.validate()) {
                            print('updating');
                            updateVolunteer();
                            setState(() {
                              _enabled = !_enabled;
                            });
                          }
                        } else {
                          setState(() {
                            _enabled = !_enabled;
                          });
                        }
                      },
                      child: Text(_enabled ? 'Save' : 'Edit')),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        Volunteer.logout();
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'home', (route) => false);
                      },
                      child: Text('Logout')),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateVolunteer() async {
    vol!.name = name.text.toString();
    vol!.email = email.text.toString();
    vol!.number = int.parse(number.text.toString());
    vol!.range = int.parse(range.text.toString());

    final url = Uri.https(
        'pure-mountain-72218.herokuapp.com', 'api/updateVolunteer.php');
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    };
    final body = jsonEncode(vol!.toMap());
    final response = await http.put(url, headers: headers, body: body);
    final responsebody = json.decode(response.body) as Map<String, dynamic>;
    if (responsebody['message'] == 'success') {
      Fluttertoast.showToast(msg: "Details updated successfully");
    } else {
      Fluttertoast.showToast(msg: "Network error,try again later!");
    }
  }
}
