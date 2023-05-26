import 'package:flutter_application_7/controllers/ingredient_controller.dart';
import 'package:flutter_application_7/controllers/souce_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SouceController());
    Get.put(IngredientController());
  }
}
