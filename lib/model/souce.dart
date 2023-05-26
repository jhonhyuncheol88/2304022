import 'package:flutter_application_7/model/ingredient.dart';

class Souce {
  String? souceName;
  double? totalPrice;
  List<Ingredient> souceingredients = [];

  Souce({
    this.souceName,
    this.totalPrice,
  });

  // JSON 함수로 짜줘 라고 명령해야 함 
  Map<String, dynamic> toJson() => {
        'souceName': souceName,
        'totalPrice': totalPrice,
      };

  factory Souce.fromJson(Map<String, dynamic> json) {
    return Souce(
      souceName: json['souceName'],
      totalPrice: json['totalPrice'],
    );
  }
}
