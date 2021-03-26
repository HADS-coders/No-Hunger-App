import 'package:NoHunger/constants.dart';
import 'package:NoHunger/widgets/customButton.dart';
import 'package:NoHunger/widgets/donateDialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:NoHunger/screens/becomeVolunteer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Want to Feed a Hungry?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Text('choose one',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12)),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customCircularButton(
                  context: context,
                  title: 'Donate',
                  subTitle: 'Donate/Buy food for needy',
                  img: 'assets/images/donate-food.png',
                  onTap: () => donateDialog(context),
                ),
                customCircularButton(
                    context: context,
                    title: 'Become Volunteer',
                    subTitle: 'Distribute food to the needy',
                    img: 'assets/images/become-volunteer.png',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BecomeVolunteer()));
                    }),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                width: double.infinity,
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: pColor)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Approximately,',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "200 NGO's are connected",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '15000 people were fed',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '300 volunteers distribute food daily',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Visit our website for more info'),
                IconButton(
                  onPressed: () async {
                    //open website in browser
                    var pref = await SharedPreferences.getInstance();
                    await pref.setBool('visited', false);
                  },
                  icon: Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
