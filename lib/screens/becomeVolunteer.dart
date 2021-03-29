import 'package:NoHunger/screens/loginscreen.dart';
import 'package:flutter/material.dart';

class BecomeVolunteer extends StatefulWidget {
  @override
  _BecomeVolunteerState createState() => _BecomeVolunteerState();
}

class _BecomeVolunteerState extends State<BecomeVolunteer> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    fName.dispose();
    lName.dispose();
    number.dispose();
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Enter your details'),
        elevation: 1,
        actions: [
          TextButton(
            child: Text('Login'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      controller: fName,
                      validator: (value) {
                        if (value.isEmpty)
                          return "First Name cannot be empty";
                        else
                          return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: 'First Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    TextFormField(
                      controller: lName,
                      validator: (value) {
                        if (value.isEmpty)
                          return "Last Name cannot be empty";
                        else
                          return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: 'Last Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    TextFormField(
                      controller: number,
                      validator: (value) {
                        if (value.isEmpty)
                          return "Mobile Number cannot be empty";
                        else
                          return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Mobile Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value.isEmpty)
                          return "Email cannot be empty";
                        else if (!value.contains('@') && !value.contains('.')) {
                          return 'Email is not valid';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                print('validated');
                                _submittedDialog(email.text.toString());
                              }
                            },
                            child: Text('Submit'))),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  _submittedDialog(String email) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "A mail has been successfully delivered to $email. Please follow all the steps in email to volunteer with us.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            ));
  }
}
