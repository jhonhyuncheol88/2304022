class Ingredient {
  String name;
  double? price;
  double? weight;
  double? inputWeight;
  double? gramPrice;
  double? inputPrice;

  Ingredient({
    required this.name,
    required this.price,
    required this.weight,
    required this.inputWeight,
    required this.gramPrice,
    required this.inputPrice,
  });

  // Convert Ingredient object to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'weight': weight,
      'inputWeight': inputWeight,
      'gramPrice': gramPrice,
      'inputPrice': inputPrice,
    };
  }

  // Create Ingredient object from a Map
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      price: json['price'],
      weight: json['weight'],
      inputWeight: json['inputWeight'],
      gramPrice: json['gramPrice'],
      inputPrice: json['inputPrice'],
    );
  }
}
