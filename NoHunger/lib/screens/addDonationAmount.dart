import 'package:NoHunger/constants.dart';
import 'package:NoHunger/screens/confirmDonation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDonationAmount extends StatefulWidget {
  @override
  _AddDonationAmountState createState() => _AddDonationAmountState();
}

class _AddDonationAmountState extends State<AddDonationAmount> {
  double min = 100.0, max = 10000.0;
  int incr = 100, factor = 3;
  double _value, _prevValue, amount;
  double width, height;
  bool isPressed;
  List<Widget> stackElements = [];
  var _formKey = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController();
  var elements = {
    1: {'posi': 3, 'name': 'watermelon', 'top': 0.38, 'left': 0.26},
    2: {'posi': 4, 'name': 'apple', 'top': 0.34, 'left': 0.42},
    3: {'posi': 5, 'name': 'orange', 'top': 0.35, 'left': 0.17},
    4: {'posi': 3, 'name': 'orange', 'top': 0.34, 'left': 0.24},
    5: {'posi': 7, 'name': 'orange', 'top': 0.35, 'left': 0.27},
    6: {'posi': 7, 'name': 'apple', 'top': 0.33, 'left': 0.18},
    7: {'posi': 6, 'name': 'flour', 'top': 0.29, 'left': 0.09},
    8: {'posi': 9, 'name': 'mango', 'top': 0.34, 'left': 0.38},
    9: {'posi': 6, 'name': 'corn', 'top': 0.28, 'left': 0.195},
    10: {'posi': 7, 'name': 'brinjal', 'top': 0.29, 'left': 0.28},
    11: {'posi': 10, 'name': 'banana', 'top': 0.31, 'left': 0.31},
    12: {'posi': 11, 'name': 'green apple', 'top': 0.32, 'left': 0.47},
    13: {'posi': 5, 'name': 'watermelon', 'top': 0.26, 'left': 0.33},
    14: {'posi': 11, 'name': 'sauce', 'top': 0.26, 'left': 0.5},
    15: {'posi': 12, 'name': 'carrot', 'top': 0.28, 'left': 0.58},
    16: {'posi': 7, 'name': 'bread', 'top': 0.26, 'left': 0.42}
  };
  int eleLength = 16, stackLength = 20;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      width = screenWidth(context) -
          (MediaQuery.of(context).padding.left +
              MediaQuery.of(context).padding.right);

      height = screenHeight(context) -
          (MediaQuery.of(context).padding.top +
              MediaQuery.of(context).padding.bottom);
      _buildBox();
    });
    this._value = _prevValue = amount = min;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(CupertinoIcons.minus),
                          onPressed: () {
                            if (_value > min) {
                              setState(() {
                                _value -= incr;
                                amount = _value;
                                updateAmount();

                                var n = _value ~/ (incr * factor);
                                if (n <= eleLength &&
                                    stackElements.length <= stackLength) {
                                  for (var i = stackElements.length - 4;
                                      i > n;
                                      i--) {
                                    stackElements.removeAt(elements[i]['posi']);
                                  }
                                }
                                _prevValue = _value;
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
                                _value = (value ~/ incr) * incr.toDouble();
                                amount = _value;
                                updateAmount();
                                var n = _value ~/ (incr * factor);
                                if (_value > _prevValue) {
                                  if (n <= eleLength &&
                                      stackElements.length <= stackLength) {
                                    for (var i = stackElements.length - 3;
                                        i <= n;
                                        i++) {
                                      _addElement(elements[i]);
                                    }
                                  } else if (stackElements.length <
                                          stackLength &&
                                      n > eleLength) {
                                    for (var i = stackElements.length - 3;
                                        i <= eleLength;
                                        i++) {
                                      _addElement(elements[i]);
                                    }
                                  }
                                } else {
                                  if (n <= eleLength &&
                                      stackElements.length <= stackLength) {
                                    for (var i = stackElements.length - 4;
                                        i > n;
                                        i--) {
                                      stackElements
                                          .removeAt(elements[i]['posi']);
                                    }
                                  }
                                }
                                _prevValue = _value;
                              });
                            },
                            min: min,
                            max: max,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            if (_value < max) {
                              setState(() {
                                _value += incr;
                                amount = _value;
                                updateAmount();
                                var n = _value ~/ (incr * factor);
                                if (n <= eleLength &&
                                    stackElements.length <= stackLength) {
                                  for (var i = stackElements.length - 3;
                                      i <= n;
                                      i++) {
                                    _addElement(elements[i]);
                                  }
                                }
                                _prevValue = _value;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          width: 10,
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
                          "Give ${amount ~/ incr} " +
                              (_value <= 100 ? "meal" : "meals"),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ConfirmDonation(amount)));
                        },
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

  void _addElement(element) {
    stackElements.insert(
      element['posi'],
      Positioned(
        top: height * element['top'],
        left: width * element['left'],
        child: Image.asset(
          'assets/images/${element['name']}.png',
          width: width * 0.4,
          height: width * 0.4,
        ),
      ),
    );
  }

  void amountDialog() async {
    await showDialog(
        context: context,
        builder: (context) => Dialog(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  'Enter your custom amount',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Our minimum donation amount is Rs $min.'),
                SizedBox(
                  height: 10,
                ),
                Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _amountController,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Amount cannot be empty";
                        else if (double.parse(value) < min)
                          return "Amount cannot be less than $min";
                        else
                          return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Your amount',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.pop(context);

                        setState(() {
                          _value =
                              (double.parse(_amountController.text) ~/ incr) *
                                  incr.toDouble();
                          amount = _value;
                          if (amount > max) {
                            _value = max;
                          }
                          updateAmount();
                          var n = _value ~/ (incr * factor);
                          if (_value > _prevValue) {
                            if (n <= eleLength &&
                                stackElements.length <= stackLength) {
                              for (var i = stackElements.length - 3;
                                  i <= n;
                                  i++) {
                                _addElement(elements[i]);
                              }
                            } else if (stackElements.length < stackLength &&
                                n > eleLength) {
                              for (var i = stackElements.length - 3;
                                  i <= eleLength;
                                  i++) {
                                _addElement(elements[i]);
                              }
                            }
                          } else {
                            if (n <= eleLength &&
                                stackElements.length <= stackLength) {
                              for (var i = stackElements.length - 4;
                                  i > n;
                                  i--) {
                                stackElements.removeAt(elements[i]['posi']);
                              }
                            }
                          }
                          _prevValue = _value;
                        });
                      }
                    },
                    child: Text('Confirm'),
                  ),
                ),
              ]),
            )));
  }

  Widget _buildAmountText() => Positioned(
        top: height * 0.1,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              "Rs $amount",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _amountController.text = _value.toString();
                  amountDialog();
                })
          ],
        ),
      );

  void updateAmount() {
    stackElements[0] = _buildAmountText();
  }

  void _buildBox() {
    stackElements.add(_buildAmountText());
    stackElements.add(
      Positioned(
        top: height * 0.2,
        width: width,
        height: width,
        child: Image.asset('assets/images/box back.png'),
      ),
    );
    stackElements.add(
      Positioned(
          top: height * 0.35,
          left: width * 0.35,
          child: Image.asset(
            'assets/images/watermelon.png',
            width: width * 0.4,
            height: width * 0.4,
          )),
    );
    stackElements.add(
      Positioned(
        top: height * 0.2 + 2,
        width: width,
        height: width,
        child: Image.asset('assets/images/box front.png'),
      ),
    );
    setState(() {});
  }
}
