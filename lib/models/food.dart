import 'package:NoHunger/models/foodItem.dart';

class Food {
  final String? type;
  final List<FoodItem>? foodItems;
  String? time;
  final int? havePackets;

  Food({this.type, this.foodItems, this.time, this.havePackets});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'foodItems': FoodItem.foodItemsToMap(foodItems!),
      'time': time,
      'havePackets': havePackets
    };
  }

  static Food fromMap(Map map) {
    return Food(
        type: map['type'],
        foodItems: FoodItem.foodItemsFromList(map['foodItems']),
        time: map['time'],
        havePackets: int.parse(map['havePackets'].toString()));
  }
}
