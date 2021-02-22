import 'package:NoHunger/screens/homescreen.dart';
import 'package:NoHunger/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _visited;
  @override
  void initState() {
    super.initState();
    isVisited();
  }

  ///Funtion to check if onboarding screen is visited or not using Shared Preferences
  void isVisited() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var visited = _pref.getBool('visited') ?? false;
    _visited = visited;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/logo01.png'),
            Container(
              width: (MediaQuery.of(context).size.width) / 2,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  TweenAnimationBuilder(
                    onEnd: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  _visited ? HomeScreen() : OnBoarding()));
                    },
                    duration: Duration(seconds: 2),
                    tween: Tween<double>(
                        begin: 0, end: (MediaQuery.of(context).size.width) / 2),
                    builder: (context, value, child) => Container(
                      width: value,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
