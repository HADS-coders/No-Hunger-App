import 'dart:io';
import 'package:NoHunger/models/donation.dart';
import 'package:NoHunger/models/food.dart';
import 'package:NoHunger/models/foodItem.dart';
import 'package:NoHunger/models/volunteer.dart';
import 'package:NoHunger/widgets/donateDialog.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodRequests extends StatefulWidget {
  @override
  _FoodRequestsState createState() => _FoodRequestsState();
}

class _FoodRequestsState extends State<FoodRequests> {
  Volunteer vol = Volunteer();
  List<Map<String, dynamic>> drawerItems = [
    {'name': 'Donate', 'routeName': null},
    {'name': 'Profile', 'routeName': 'volunteerProfile'},
    {'name': 'Requests History', 'routeName': 'requestsHistory'},
  ];
  List<Donation> donations = [];

  Future<Volunteer> getVolFromDb() async {
    var _vol = await vol.getVol();
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
                Navigator.pushNamed(context, 'volunteerProfile');
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
          future: getVolFromDb(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              vol = snapshot.data;

              return FutureBuilder(
                  future: getDonationRequests(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      donations = snapshot.data;
                      if (donations.isEmpty)
                        return Center(
                          child: Text('No Food Requests'),
                        );
                      else
                        return ListView.builder(
                            itemCount: donations.length,
                            itemBuilder: (context, index) => ListTile(
                                  title: Text(donations[index].name),
                                  subtitle: Text(donations[index].food.type),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'detailedFoodRequest',
                                        arguments: {'data': donations[index]});
                                  },
                                ));
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

  Future<List<Donation>> getDonationRequests() async {
    final Map<String, dynamic> param = {
      'longitude': vol.longitude.toString(),
      'latitude': vol.latitude.toString(),
      'range': 5.toString()
    };
    final url = Uri.https('pure-mountain-72218.herokuapp.com',
        'api/getDonationRequests.php', param);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(url, headers: headers);
    var responsebody = json.decode(response.body);
    var dataList = responsebody['data'] as List;
    donations = [];
    Donation donation = Donation();
    Food food = Food();
    for (var data in dataList) {
      List<FoodItem> foodItems = [];
      List foodItemsData = data['foodItems'];
      for (var item in foodItemsData) {
        FoodItem foodItem =
            FoodItem(name: item['name'], amount: int.parse(item['amount']));
        foodItems.add(foodItem);
      }

      var foodData = data['food'];
      food = Food(
          type: foodData['type'],
          foodItems: foodItems,
          time: foodData['time'],
          havePackets: int.parse(foodData['havePackets']));

      donation = Donation(
          name: data['donation']['name'],
          number: int.parse(data['donation']['number']),
          email: data['donation']['email'],
          latitude: double.parse(data['donation']['latitude']),
          longitude: double.parse(data['donation']['longitude']),
          time: DateTime.parse(data['donation']['time']),
          food: food);
      donations.add(donation);
    }
    return donations;
  }
}
