import 'package:NoHunger/constants.dart';
import 'package:flutter/material.dart';

Widget customCircularButton(
    {BuildContext context,
    String title,
    String subTitle,
    String img,
    void Function() onTap}) {
  return Expanded(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: screenWidth(context) / 6,
            backgroundColor: pColor,
            child: CircleAvatar(
              radius: screenWidth(context) / 6 - 2,
              backgroundColor: Colors.white,
              backgroundImage: Image.asset(img).image,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: FittedBox(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.all(5),
            width: screenWidth(context) / 3,
            child: Text(
              subTitle,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              textAlign: TextAlign.center,
            ))
      ],
    ),
  );
}
