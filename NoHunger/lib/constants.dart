import 'package:flutter/material.dart';

///Return the width of the screen
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

const pColor = const Color(0xFFFFB13D);
const boldStyle = TextStyle(fontWeight: FontWeight.bold);

const color = const {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

const pSwatch = const MaterialColor(0xFFFFB13D, color);

var elevatedBtnStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white, //For text,icon and splash color
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
);
