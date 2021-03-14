import 'package:NoHunger/screens/addDonationAmount.dart';
import 'package:NoHunger/widgets/customButton.dart';
import 'package:flutter/material.dart';

void donateDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            customCircularButton(
                context: context,
                title: 'Buy Food',
                subTitle: '',
                img: 'assets/images/donate-food.png',
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddDonationAmount()));
                }),
            SizedBox(
              width: 15,
            ),
            customCircularButton(
                context: context,
                title: 'Donate Food',
                subTitle: '',
                img: 'assets/images/donate-food.png',
                onTap: () {})
          ],
        ),
      ),
    ),
  );
}
