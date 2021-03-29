import 'package:flutter/material.dart';

class FoodDonationComleted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Food donation request successful.\nYou will receive a call from one of our volunteer regarding further process under 15 minutes.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); //pop current screen
                      Navigator.pop(context); //pop location screen
                      Navigator.pop(context); //pop food detail screen
                    },
                    child: Text('Done'),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
