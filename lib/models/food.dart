import 'package:NoHunger/models/foodItem.dart';

class Food {
  final String type;
  final List<FoodItem> foodItems;
  String time;
  final bool havePackets;

  Food({this.type, this.foodItems, this.time, this.havePackets});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'foodItems': foodItemsToMap(foodItems),
      'time': time,
      'havePackets': havePackets
    };
  }

  List<Map<String, dynamic>> foodItemsToMap(List<FoodItem> foodItems) {
    List<Map<String, dynamic>> foodItemMapList = [];
    foodItems.forEach((element) {
      foodItemMapList.add(element.toMap());
    });
    return foodItemMapList;
  }
}
