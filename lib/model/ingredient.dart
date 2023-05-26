class Ingredient {
  String? name;
  double? price;
  double? weight;
  double? inputWeight;
  double? gramPrice;
  double? inputPrice;
  double totalinputPrice;
  double totalgramPrice;
  double totalinputWeight;

  Ingredient(
      {required this.name,
      required this.price,
      required this.weight,
      required this.inputWeight,
      required this.gramPrice,
      required this.inputPrice,
      required this.totalinputWeight,
      required this.totalgramPrice,
      required this.totalinputPrice});

  // Convert Ingredient object to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'weight': weight,
      'inputWeight': inputWeight,
      'gramPrice': gramPrice,
      'inputPrice': inputPrice,
      'totalinputWeight': totalinputWeight,
      'totalgramPrice': totalgramPrice,
      'totalinputPrice': totalinputPrice
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
        totalgramPrice: json['totalgramPrice'],
        totalinputWeight: json['totalinputWeight'],
        totalinputPrice: json['totalinputPrice']);
  }
}
