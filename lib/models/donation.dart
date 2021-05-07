import 'package:NoHunger/models/food.dart';

class Donation {
  final String name;
  final int number;
  final String email;
  final double latitude;
  final double longitude;
  final Food food;
  final DateTime time;
  String address;
  String city;
  int pincode;

  Donation(
      {this.name,
      this.number,
      this.email,
      this.latitude,
      this.longitude,
      this.food,
      this.time,
      this.address,
      this.city,
      this.pincode});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'food': food.toMap(),
      'time': time.toString()
    };
  }
}