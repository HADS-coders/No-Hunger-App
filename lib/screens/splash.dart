import 'package:NoHunger/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visited;
  bool _loggedIn;
  @override
  void initState() {
    super.initState();
    isVisited();
    isLoggedIn();
  }

  ///Funtion to check if onboarding screen is visited or not using Shared Preferences
  void isVisited() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var visited = _pref.getBool('visited') ?? false;
    _visited = visited;
  }

  ///Funtion to check if user is logged in or not using Shared Preferences
  void isLoggedIn() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _loggedIn = _pref.getBool('visited') ?? false;
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
                  if (_loggedIn) {
                    print('logged in');
                    Navigator.pushReplacementNamed(context, 'foodRequests');
                  } else
                    Navigator.pushReplacementNamed(
                        context, _visited ? 'home' : 'onBoarding');
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
