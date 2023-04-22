import 'package:flutter/material.dart';
import 'package:flutter_application_7/model/model.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class IngredientController extends GetxController {
  RxList<Ingredient> ingredients = <Ingredient>[].obs;

  int index = 0;

  @override
  void onInit() {
    var box = GetStorage();
    if (box.read('ingredients') != null) {
      var list = box.read('ingredients');
      for (var item in list) {
        ingredients.add(Ingredient.fromJson(item));
      }
    }
    ever(ingredients, (val) {
      box.write('ingredients', ingredients.toJson());
    });

    super.onInit();
  }
}

class TextFieldController extends GetxController {
  TextEditingController? ingredientName;
  TextEditingController? ingredientPrice;

  @override
  void onInit() {
    ingredientName = TextEditingController();
    ingredientPrice = TextEditingController();
    // TODO: implement onInit
    super.onInit();
  }
}
