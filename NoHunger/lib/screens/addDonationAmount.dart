import 'package:NoHunger/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDonationAmount extends StatefulWidget {
  @override
  _AddDonationAmountState createState() => _AddDonationAmountState();
}

class _AddDonationAmountState extends State<AddDonationAmount> {
  double _value = 100.0;
  bool isPressed;
  List<Widget> stackElements = [];
  var photus = {1: '222'};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _buildBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  flex: 7,
                  child: Stack(
                    children: stackElements,
                  )),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Rs $_value"),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          child: Icon(CupertinoIcons.minus),
                          onTap: () {
                            if (_value > 100) {
                              setState(() {
                                _value -= 100;
                              });
                            }
                          },
                        ),
                        Expanded(
                          child: Slider(
                            value: _value,
                            divisions: 100,
                            inactiveColor: Colors.grey,
                            onChanged: (value) {
                              setState(() {
                                _value = (value ~/ 100) * 100.toDouble();
                                if (stackElements.length < 7) {
                                  for (var i = 1; i < _value ~/ 100; i++) {
                                    _addImage(count: i);
                                    print('adding img');
                                  }
                                } // _addElement(count: _value ~/ 100);
                              });
                            },
                            min: 100.0,
                            max: 10000.0,
                          ),
                        ),
                        GestureDetector(
                          child: Icon(Icons.add),
                          onTap: () {
                            if (_value <= 9900) {
                              setState(() {
                                _value += 100;
                                for (var i = 1; i < _value ~/ 100; i++) {
                                  _addImage(count: i);
                                  print('adding img');
                                }
                              });
                            }
                          },
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Text(
                          "Give ${_value ~/ 100} " +
                              (_value <= 100 ? "meal" : "meals"),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _addElement({count, height, width, top, left, img}) {
    stackElements.insert(
      stackElements.length - 2,
      Positioned(
        top: screenHeight(context) * 0.4,
        left: screenWidth(context) * 0.3 + count * 10,
        child: Container(
          width: 50,
          height: 50,
          color: Colors.red,
        ),
      ),
    );
    print(stackElements.length);
  }

  void _addImage({count, height, width, top, left, img}) {
    stackElements.insert(
      stackElements.length - 2,
      Positioned(
          top: screenHeight(context) * 0.4,
          left:
              screenWidth(context) * 0.22 + count * screenWidth(context) * 0.1,
          child: Image.asset(
            'assets/images/img$count.png',
            width: screenWidth(context) * 0.2,
            height: screenWidth(context) * 0.2,
          )),
    );
    print(stackElements.length);
  }

  void _buildBox({count, width, height}) {
    stackElements.add(
      Positioned(
        top: screenHeight(context) * 0.2,
        width: screenWidth(context),
        height: screenWidth(context),
        child: Image.asset('assets/images/box back.png'),
      ),
    );
    stackElements.add(
      Positioned(
          top: screenHeight(context) * 0.3,
          left: screenWidth(context) * 0.50,
          child: Image.asset(
            'assets/images/img3.png',
            width: screenWidth(context) * 0.2,
            height: screenWidth(context) * 0.2,
          )),
    );
    stackElements.add(
      Positioned(
          top: screenHeight(context) * 0.3,
          left: screenWidth(context) * 0.6,
          child: Image.asset(
            'assets/images/img5.png',
            width: screenWidth(context) * 0.2,
            height: screenWidth(context) * 0.2,
          )),
    );
    stackElements.add(
      Positioned(
          top: screenHeight(context) * 0.35,
          left: screenWidth(context) * 0.50,
          child: Image.asset(
            'assets/images/img4.png',
            width: screenWidth(context) * 0.2,
            height: screenWidth(context) * 0.2,
          )),
    );

    stackElements.add(
      Positioned(
        top: screenHeight(context) * 0.2 + 2,
        width: screenWidth(context),
        height: screenWidth(context),
        child: Image.asset('assets/images/box front.png'),
      ),
    );
    print(stackElements.length);
    setState(() {});
  }
}
