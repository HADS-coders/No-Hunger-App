class FoodItem {
  final String? name;
  final int? amount;

  FoodItem({this.name, this.amount});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
    };
  }

  static List<Map<String, dynamic>> foodItemsToMap(List<FoodItem> foodItems) {
    List<Map<String, dynamic>> foodItemMapList = [];
    foodItems.forEach((element) {
      foodItemMapList.add(element.toMap());
    });
    return foodItemMapList;
  }

  static FoodItem fromMap(Map map) {
    return FoodItem(
      name: map['name'],
      amount: int.parse(map['amount'].toString()),
    );
  }

  static List<FoodItem> foodItemsFromList(List items) {
    List<FoodItem> foodItems = [];
    for (var item in items) {
      foodItems.add(fromMap(item));
    }
    return foodItems;
  }
}
