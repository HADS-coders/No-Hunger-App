import 'package:NoHunger/screens/moneyDonationCompleted.dart';
import 'package:flutter/material.dart';

class ConfirmDonation extends StatefulWidget {
  ConfirmDonation(this.amount);

  final double amount;

  @override
  _ConfirmDonationState createState() => _ConfirmDonationState();
}

class _ConfirmDonationState extends State<ConfirmDonation> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Confirm Donation'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Donation amount:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      widget.amount.toString(),
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
                TextFormField(
                  controller: name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Name cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  controller: number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Mobile Number cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Mobile Nunber',
                  ),
                ),
                TextFormField(
                  controller: email,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Email cannot be empty";
                    } else if (!value.contains('@') && !value.contains('.')) {
                      return 'Email is not valid';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                  ),
                ),
                Spacer(),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MoneyDonationCompleted()));
                        }
                      },
                      child: Text('Confirm')),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
