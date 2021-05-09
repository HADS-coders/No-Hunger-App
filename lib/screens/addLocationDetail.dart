import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:NoHunger/models/donation.dart';
import 'package:NoHunger/models/food.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:NoHunger/widgets/getFutureData.dart';

class AddLocationDetail extends StatefulWidget {
  @override
  _AddLocationDetailState createState() => _AddLocationDetailState();
}

class _AddLocationDetailState extends State<AddLocationDetail> {
  Food food;
  Position location;
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
    Map arg = ModalRoute.of(context).settings.arguments as Map;
    if (arg != null) food = arg['data'];
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
                        location = _location;
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
                        labelText: 'Address',
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
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            Donation donation;
                            if (_selectedType == 'set') {
                              List<Location> locations = await GeocodingPlatform
                                  .instance
                                  .locationFromAddress(
                                      '${address.text}, ${city.text}, ${pincode.text.toString()}');
                              Location setLocation = locations[0];
                              donation = Donation(
                                  name: name.text,
                                  number: int.parse(number.text),
                                  email: email.text,
                                  latitude: setLocation.latitude,
                                  longitude: setLocation.longitude,
                                  food: food,
                                  time: DateTime.now());
                            } else {
                              donation = Donation(
                                  name: name.text,
                                  number: int.parse(number.text),
                                  email: email.text,
                                  latitude: location.latitude,
                                  longitude: location.longitude,
                                  food: food,
                                  time: DateTime.now());
                            }
                            // print(donation.toMap());

                            bool donationSuccessful = await getFutureData(
                                context, sendDonationRequest(donation));

                            if (donationSuccessful)
                              Navigator.pushNamed(
                                  context, 'foodDonationCompleted',
                                  arguments: {'data': donation});
                            else
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(
                                            'Food Donation Unsuccessful. Try again later'),
                                      ));
                          }
                        },
                        child: Text('Request Food Donation')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> sendDonationRequest(Donation donation) async {
    var body = jsonEncode(donation.toMap());

    var response = await http.post(
        Uri.https('pure-mountain-72218.herokuapp.com', 'api/addDonation.php'),
        headers: {'Content-Type': 'application/json'},
        body: body);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      return responseBody['message'] == 'Success';
    }
    return false;
  }

  void _enableLocation() {
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

    currentPosition = await getFutureData(context,
        Geolocator.getCurrentPosition(timeLimit: Duration(seconds: 100)));

    setState(() {
      location = currentPosition;
    });
    return currentPosition;
  }
}
