import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _passwword = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    'Welcome,',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        controller: _email,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email cannot be empty";
                          } else if (!value.contains('@') &&
                              !value.contains('.')) {
                            return 'Email is not valid';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email Address',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                      TextFormField(
                        controller: _passwword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscureText,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                            suffixIcon: TextButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
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
                              print('${_email.text} and ${_passwword.text}');
                            }
                          },
                          child: Text('Login'),
                        ),
                      ),
                      TextButton(
                        onPressed: null,
                        child: Text('Forgot password?'),
                      ),
                      // Text('OR'),
                    ],
                  ),
                ),
              ),
              Expanded(flex: 2, child: Container()),
              // Expanded(
              //   flex: 2,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Container(
              //         width: double.infinity,
              //         child: OutlinedButton(
              //           style: OutlinedButton.styleFrom(
              //               shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(30))),
              //           onPressed: () {},
              //           child: Text('Login with Google'),
              //         ),
              //       ),
              //       Container(
              //         width: double.infinity,
              //         child: OutlinedButton(
              //           style: OutlinedButton.styleFrom(
              //               shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(30))),
              //           onPressed: () {},
              //           child: Text('Login with Apple ID'),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
