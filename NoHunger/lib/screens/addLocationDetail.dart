import 'package:NoHunger/screens/foodDonationCompleted.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AddLocationDetail extends StatefulWidget {
  @override
  _AddLocationDetailState createState() => _AddLocationDetailState();
}

class _AddLocationDetailState extends State<AddLocationDetail> {
  var location;
  var _selectedType = 'set';
  var _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Enter your details'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      Position _location = await _determinePosition();
                      print('${_location.latitude}  ${_location.longitude}');
                      setState(() {
                        _selectedType = 'get';
                        location =
                            '${_location.latitude}  ${_location.longitude}';
                      });
                    },
                    child: ListTile(
                      title: Text('Use current location'),
                      trailing: Radio(
                          value: 'get',
                          groupValue: _selectedType,
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value;
                              _determinePosition();
                            });
                          }),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedType = 'set';
                      });
                    },
                    child: ListTile(
                      title: Text('Enter location manually'),
                      trailing: Radio(
                          value: 'set',
                          groupValue: _selectedType,
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value;
                            });
                          }),
                    ),
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
                  if (_selectedType == 'set') ...[
                    TextFormField(
                      controller: address,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Address cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        labelText: 'Street address',
                      ),
                    ),
                    TextFormField(
                      controller: city,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "City cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'City',
                      ),
                    ),
                    TextFormField(
                      controller: pincode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Pin Code cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Pin Code',
                      ),
                    ),
                  ],
                  SizedBox(
                    height: 10,
                  ),
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
                                        FoodDonationComleted()));
                          }
                        },
                        child: Text('Next')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _enableLocation() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Location service is disabled on your device'),
              content: Text(
                  'To enable location service, click on Enable button,Location Setting will open, enable Location there. Then click on Request Permission, and Allow while using this app then click Done'),
              actions: [
                TextButton(
                    onPressed: () async {
                      await Geolocator.openLocationSettings();
                    },
                    child: Text('Enable location')),
                TextButton(
                    onPressed: () async {
                      await Geolocator.requestPermission();
                    },
                    child: Text('Request permission')),
                TextButton(
                    onPressed: () {
                      _determinePosition();
                      Navigator.pop(context);
                    },
                    child: Text('Done'))
              ],
            ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position currentPosition;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      _enableLocation();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    currentPosition = await _getPosition();
    setState(() {
      location = '${currentPosition.latitude}  ${currentPosition.longitude}';
    });
    return currentPosition;
  }

  Future<Position> _getPosition() async {
    Position currentPosition;
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Getting current location'),
              content: Center(
                child: FutureBuilder(
                  future: Geolocator.getCurrentPosition(
                      timeLimit: Duration(seconds: 100)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      currentPosition = snapshot.data;
                      Navigator.pop(context);
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ));
    return currentPosition;
  }
}
