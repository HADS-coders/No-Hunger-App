import 'package:NoHunger/constants.dart';
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
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Spacer(
                flex: 1,
              ),
              Image.asset('assets/images/logo01.png'),
              Spacer(
                flex: 7,
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: screenWidth(context) / 2),
                duration: Duration(seconds: 2),
                builder: (context, value, child) => Column(
                  children: [
                    Container(
                      width: screenWidth(context) / 2,
                      height: 10.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey),
                      child: Stack(
                        children: [
                          Container(
                            width: value,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Removing Hunger ${(value * 100 / (screenWidth(context) / 2)).toInt()} %')
                  ],
                ),
                onEnd: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              _visited ? HomeScreen() : OnBoarding()));
                },
              ),
              Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
