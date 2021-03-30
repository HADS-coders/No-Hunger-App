import 'package:NoHunger/screens/addDonationAmount.dart';
import 'package:NoHunger/screens/addFoodDetails.dart';
import 'package:NoHunger/widgets/customButton.dart';
import 'package:flutter/material.dart';

void donateDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            customCircularButton(
                context: context,
                title: 'Donate Money',
                subTitle: '',
                img: 'assets/images/donate-money.jpeg',
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddDonationAmount()));
                }),
            customCircularButton(
                context: context,
                title: 'Donate Food',
                subTitle: '',
                img: 'assets/images/donate-food.png',
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddFoodDetails()));
                })
          ],
        ),
      ),
    ),
  );
}
