import 'package:flutter/material.dart';

class LoginStatus extends StatelessWidget {
  final String message;
  LoginStatus(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(this.message),
      ),
    );
  }
}
