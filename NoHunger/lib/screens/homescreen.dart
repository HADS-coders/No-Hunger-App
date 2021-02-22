import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FlatButton(
          onPressed: () async {
            var pref = await SharedPreferences.getInstance();
            await pref.setBool('visited', false);
          },
          child: Text('reset'),
        ),
      ),
    );
  }
}
