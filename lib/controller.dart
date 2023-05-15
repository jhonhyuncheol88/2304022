import 'package:flutter/material.dart';
import 'package:flutter_application_7/model/model.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

  var box = GetStorage();

  @override
  void onInit() {
    if (box.read('ingredient') != null) {
      var list = box.read('ingredient');
      for (var item in list) {
        ingredients.add(Ingredient.fromJson(item));
      }
    }
    ever(ingredients, (val) {
      box.write('ingredient', ingredients.toJson());
    });
    super.onInit();
  }
}
