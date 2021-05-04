import 'package:NoHunger/models/volunteer.dart';
import 'package:flutter/material.dart';

class FoodRequests extends StatefulWidget {
  @override
  _FoodRequestsState createState() => _FoodRequestsState();
}

class _FoodRequestsState extends State<FoodRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Requests'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Volunteer.logout();
                Navigator.pushReplacementNamed(context, 'home');
              })
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(),
        ),
      ),
    );
  }
}
