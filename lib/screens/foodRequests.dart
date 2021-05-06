import 'package:NoHunger/models/volunteer.dart';
import 'package:NoHunger/widgets/donateDialog.dart';
import 'package:flutter/material.dart';

class FoodRequests extends StatefulWidget {
  @override
  _FoodRequestsState createState() => _FoodRequestsState();
}

class _FoodRequestsState extends State<FoodRequests> {
  Volunteer vol = Volunteer();
  List<Map<String, dynamic>> drawerItems = [
    {'name': 'Donate', 'routeName': null},
    {'name': 'Profile', 'routeName': 'volunteerProfile'},
  ];

  @override
  void initState() {
    super.initState();
    getVolFromDb();
  }

  void getVolFromDb() async {
    var _vol = await vol.getVol();
    if (_vol != null) {
      setState(() {
        vol = _vol;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context = context;
    Map arg = ModalRoute.of(context).settings.arguments as Map;
    if (arg != null) vol = arg['data'];
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
                  if (drawerItems[index]['routeName'] != null)
                    Navigator.pushNamed(
                        context, drawerItems[index]['routeName'],
                        arguments: {'data': vol});
                  else {
                    Navigator.pop(context);
                    donateDialog(context);
                  }
                }),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                  title: Text(vol.name),
                  subtitle: Text(
                    vol.email,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
