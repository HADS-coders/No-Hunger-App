import 'dart:io';
import 'package:NoHunger/models/donation.dart';
import 'package:NoHunger/models/volunteer.dart';
import 'package:NoHunger/widgets/donateDialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodRequests extends StatefulWidget {
  @override
  _FoodRequestsState createState() => _FoodRequestsState();
}

class _FoodRequestsState extends State<FoodRequests> {
  Volunteer? vol = Volunteer();
  List<Map<String, dynamic>> drawerItems = [
    {'name': 'Donate', 'routeName': null},
    {'name': 'Profile', 'routeName': 'volunteerProfile'},
    {'name': 'Requests History', 'routeName': 'requestsHistory'},
  ];
  List<Donation>? donations = [];

  Future<Volunteer> getVol() async {
    Volunteer _vol = await Volunteer().getVol();
    return _vol;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Requests'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, 'volunteerProfile',
                    arguments: {'data': vol});
              })
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView.builder(
            itemCount: drawerItems.length,
            itemBuilder: (context, index) => ListTile(
                title: Text(drawerItems[index]['name']),
                onTap: () {
                  if (drawerItems[index]['routeName'] != null) {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                        context, drawerItems[index]['routeName'],
                        arguments: {'data': vol});
                  } else {
                    Navigator.pop(context);
                    donateDialog(context);
                  }
                }),
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getVol(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              vol = snapshot.data! as Volunteer?;
              return FutureBuilder(
                  future: getDonationRequests(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      donations = snapshot.data as List<Donation>?;
                      if (donations!.isEmpty)
                        return Center(
                          child: Text('No Food Requests'),
                        );
                      else
                        return RefreshIndicator(
                          onRefresh: _refresh,
                          child: ListView.builder(
                              itemCount: donations!.length,
                              itemBuilder: (context, index) => ListTile(
                                    title: Text(donations![index].name!),
                                    subtitle:
                                        Text(donations![index].food!.type!),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    onTap: () async {
                                      var result = await Navigator.pushNamed(
                                          context, 'detailedFoodRequest',
                                          arguments: {
                                            'data': donations![index],
                                            'vol_id': vol!.id
                                          }) as List?;
                                      if (result != null) {
                                        print('donation completed');
                                        setState(() {
                                          donations!.removeAt(index);
                                        });
                                        Fluttertoast.showToast(
                                            msg: "Food Request Completed!");
                                      }
                                    },
                                  )),
                        );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    return getDonationRequests().then((value) {
      setState(() {
        donations = value;
      });
    });
  }

  Future<List<Donation>?> getDonationRequests() async {
    final Map<String, dynamic> param = {
      'vol_id': vol!.id.toString(),
    };
    final url = Uri.https('pure-mountain-72218.herokuapp.com',
        'api/getDonationRequests.php', param);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(url, headers: headers);
    Map<String, dynamic> responsebody = json.decode(response.body);
    List<dynamic> dataList = responsebody['data'];
    donations = [];
    Donation donation = Donation();
    for (Map<String, dynamic> data in dataList) {
      var donationMap = data['donation'];
      donationMap.putIfAbsent('food', () => data['food']);
      Map foodMap = donationMap['food'];
      foodMap.putIfAbsent('foodItems', () => data['foodItems']);
      donation = Donation.fromMap(donationMap);
      donations!.add(donation);
    }
    return donations;
  }
}
