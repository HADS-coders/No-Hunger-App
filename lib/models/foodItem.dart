class FoodItem {
  final String name;
  final int amount;

  FoodItem({this.name, this.amount});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
    };
  }
}
