import 'package:flutter/material.dart';

///Function to get data from a future and display a dialog with circlular progress indicator while data is fetched.
Future<dynamic> getFutureData(BuildContext context, var future) async {
  var data;
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            data = snapshot.data;
            Navigator.pop(context);
          }
          return CircularProgressIndicator();
        },
      ),
    ),
  );
  return data;
}
