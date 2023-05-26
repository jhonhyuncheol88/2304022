import 'package:flutter_application_7/model/ingredient.dart';

import 'package:get/get.dart';

class IngredientController extends GetxController {
  RxList<Ingredient> ingredients = <Ingredient>[].obs;

  double get totalgramPrice {
    double sum = 0.0;
    for (Ingredient ingredient in ingredients) {
      sum += ingredient.gramPrice!;
    }
    return sum;
  }

  double get totalinputWeight {
    double sum = 0.0;
    for (Ingredient ingredient in ingredients) {
      sum += ingredient.inputWeight!;
    }
    return sum;
  }

  double get totalinputPrice {
    double sum = 0.0;
    for (Ingredient ingredient in ingredients) {
      sum += ingredient.inputPrice!;
    }
    return sum;
  }

  set totalinputPrice(double value) {
    totalinputPrice = value;
  }

  set totalinputWeight(double value) {
    totalinputWeight = value;
  }

  set totalgramPrice(double value) {
    totalgramPrice = value;
  }
}
