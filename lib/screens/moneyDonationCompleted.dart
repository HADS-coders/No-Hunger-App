import 'package:flutter/material.dart';

class MoneyDonationCompleted extends StatelessWidget {
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
                    'Donation Successfull.\n\nEach of your donation means a lot to a needy and we woud hope to see you again.\nReceipt will be mailed to your email soon.',
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
                      Navigator.pop(context); //pop confirmation screen
                      Navigator.pop(context); //pop select amount screen
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
