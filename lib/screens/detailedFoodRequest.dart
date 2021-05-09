import 'package:NoHunger/models/donation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedFoodRequest extends StatefulWidget {
  @override
  _DetailedFoodRequestState createState() => _DetailedFoodRequestState();
}

class _DetailedFoodRequestState extends State<DetailedFoodRequest> {
  Donation donation;
  @override
  Widget build(BuildContext context) {
    Map arg = ModalRoute.of(context).settings.arguments as Map;
    donation = arg['data'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Request Details'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Name: ${donation.name}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Food Type: ${donation.food.type}'),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: donation.food.foodItems.length,
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Food Name: ${donation.food.foodItems[index].name}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Food amount: ${donation.food.foodItems[index].amount.toString()}'),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.location_on),
                    onPressed: () {
                      launchMap();
                    }),
                IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () {
                      launchDialer();
                    }),
                IconButton(
                    icon: Icon(Icons.mail),
                    onPressed: () {
                      sendMail();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  launchMap() async {
    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=${donation.latitude},${donation.longitude}";

    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      throw 'Could not launch $encodedURl';
    }
  }

  launchDialer() async {
    final url = 'tel:${donation.number}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  sendMail() async {
    // Android and iOS
    final uri =
        'mailto:${donation.email}?subject=Food Donation Request Accepted&body=';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
