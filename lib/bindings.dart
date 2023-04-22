import 'package:get/get.dart';
import 'controller.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IngredientController());
    Get.put(TextFieldController());
  }
}
