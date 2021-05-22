import 'package:NoHunger/models/volunteer.dart';
import 'package:flutter/material.dart';

class VolunteerProfile extends StatefulWidget {
  @override
  _VolunteerProfileState createState() => _VolunteerProfileState();
}

class _VolunteerProfileState extends State<VolunteerProfile> {
  Volunteer? vol;
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as Map?;
    if (arg != null) vol = arg['data'];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Volunteer.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'home', (route) => false);
                },
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
