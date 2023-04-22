import 'dart:convert';

class Ingredient {
  String? name;
  int? price;

  Ingredient({required this.name, required this.price});

  // Method to convert Ingredient object to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }

  // Factory method to create an Ingredient object from a Map
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      price: json['price'],
    );
  }

  // Method to convert Ingredient object to a JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  // Factory method to create an Ingredient object from a JSON string
  factory Ingredient.fromJsonString(String jsonString) {
    return Ingredient.fromJson(jsonDecode(jsonString));
  }
}
