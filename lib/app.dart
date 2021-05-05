import 'package:NoHunger/constants.dart';
import 'package:NoHunger/screens/addDonationAmount.dart';
import 'package:NoHunger/screens/addFoodDetails.dart';
import 'package:NoHunger/screens/addLocationDetail.dart';
import 'package:NoHunger/screens/becomeVolunteer.dart';
import 'package:NoHunger/screens/confirmDonation.dart';
import 'package:NoHunger/screens/foodDonationCompleted.dart';
import 'package:NoHunger/screens/foodRequests.dart';
import 'package:NoHunger/screens/homescreen.dart';
import 'package:NoHunger/screens/loginscreen.dart';
import 'package:NoHunger/screens/moneyDonationCompleted.dart';
import 'package:NoHunger/screens/onboarding.dart';
import 'package:NoHunger/screens/splash.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'No Hunger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white))),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black))),
        primaryColor: pColor,
        primarySwatch: pSwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        'onBoarding': (context) => OnBoarding(),
        'home': (context) => HomeScreen(),
        'login': (context) => LoginScreen(),
        'donateMoney': (context) => AddDonationAmount(),
        'confirmDonation': (context) => ConfirmDonation(),
        'moneyDonationCompleted': (context) => MoneyDonationCompleted(),
        'donateFood': (context) => AddFoodDetails(),
        'addLocation': (context) => AddLocationDetail(),
        'foodDonationCompleted': (context) => FoodDonationCompleted(),
        'becomeVolunteer': (context) => BecomeVolunteer(),
        'foodRequests': (context) => FoodRequests(),
      },
      home: SplashScreen(),
    );
  }
}
