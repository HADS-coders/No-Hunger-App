import 'dart:convert';
import 'dart:io';
import 'package:NoHunger/models/donation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class DetailedFoodRequest extends StatefulWidget {
  @override
  _DetailedFoodRequestState createState() => _DetailedFoodRequestState();
}

class _DetailedFoodRequestState extends State<DetailedFoodRequest> {
  Donation? donation;
  int? volId;
  @override
  Widget build(BuildContext context) {
    Map arg = ModalRoute.of(context)!.settings.arguments as Map;
    donation = arg['data'];
    volId = arg['vol_id'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Request Details'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                enabled: false,
                decoration: InputDecoration(labelText: 'Name'),
                initialValue: donation!.name,
              ),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(labelText: 'Food Type'),
                initialValue: donation!.food!.type,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: donation!.food!.foodItems!.length,
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Food Name'),
                      initialValue: donation!.food!.foodItems![index].name,
                    ),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Food amount'),
                      initialValue:
                          donation!.food!.foodItems![index].amount.toString(),
                    ),
                  ],
                ),
              ),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(labelText: 'Have packets'),
                initialValue: donation!.food!.havePackets == 1 ? 'Yes' : 'No',
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
              ),
              Spacer(),
              Container(
                  margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (donation!.isAccepted == 0) {
                        //update to accepted in db
                        final url = Uri.https(
                            'pure-mountain-72218.herokuapp.com',
                            'api/updateDonationRequest.php');
                        final headers = {
                          HttpHeaders.contentTypeHeader: 'application/json'
                        };
                        final body = jsonEncode({
                          "donation_id": donation!.id.toString(),
                          "vol_id": volId!.toString()
                        });
                        final response =
                            await http.put(url, headers: headers, body: body);
                        var responsebody = json.decode(response.body);
                        if (responsebody['message'] == 'success') {
                          Fluttertoast.showToast(
                              msg: "Donation Request Accepted!");
                          setState(() {
                            donation!.isAccepted = 1;
                          });
                        }
                      } else {
                        //move donation to completed donation in db
                        final url = Uri.https(
                            'pure-mountain-72218.herokuapp.com',
                            'api/completeDonationRequest.php');
                        final headers = {
                          HttpHeaders.contentTypeHeader: 'application/json'
                        };
                        final body = jsonEncode(
                            {"donation_id": donation!.id.toString()});
                        final response = await http.delete(url,
                            headers: headers, body: body);
                        var responsebody = json.decode(response.body);
                        if (responsebody['message'] == 'success') {
                          Navigator.pop(context, [true]);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Network error,try again later!");
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                        donation!.isAccepted == 0 ? 'Accept' : 'Completed'),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  launchMap() async {
    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=${donation!.latitude},${donation!.longitude}";

    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      throw 'Could not launch $encodedURl';
    }
  }

  launchDialer() async {
    final url = 'tel:${donation!.number}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  sendMail() async {
    final uri =
        'mailto:${donation!.email}?subject=Food Donation Request Accepted&body=';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
