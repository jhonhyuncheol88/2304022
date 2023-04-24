import 'package:flutter/material.dart';
import 'package:flutter_application_7/model/model.dart';

import 'package:get/get.dart';
import 'controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Get X 뿌시기'),
          centerTitle: true,
        ),
        body: Obx(
          () => ListView.builder(
              itemCount: Get.find<IngredientController>().ingredients.length,
              itemBuilder: (context, index) {
                var ingredient =
                    Get.find<IngredientController>().ingredients[index];
                return ListTile(
                  onLongPress: () {
                    Get.defaultDialog(
                      title: '경고!!!',
                      middleText: '진짜!!!?지울거임?',
                      textConfirm: '어 진짜 지울겨',
                      textCancel: '아니 안지울겨',
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        Get.find<IngredientController>()
                            .ingredients
                            .removeAt(index);
                        Get.back();
                      },
                      onCancel: () {
                        Get.back();
                      },
                    );
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.dialog(AlertDialog(
                            title: Text('재료입력'),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextField(
                                    controller: Get.find<TextFieldController>()
                                        .ingredientName,
                                    decoration:
                                        InputDecoration(hintText: '재료이름'),
                                  ),
                                  TextField(
                                    controller: Get.find<TextFieldController>()
                                        .ingredientPrice,
                                    decoration:
                                        InputDecoration(hintText: '재료가격'),
                                    keyboardType: TextInputType.number,
                                  ),
                                ]),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  //대체 getx는 뭔가.. 왜 setState를 써야 하는건가 ㅠㅠ
                                  setState(() {});
                                  ingredient.name =
                                      Get.find<TextFieldController>()
                                          .ingredientName!
                                          .text;

                                  Get.find<IngredientController>().box.write(
                                      'ingredients',
                                      Get.find<IngredientController>()
                                          .ingredients
                                          .toJson());

                                  Get.back();
                                  Get.find<TextFieldController>()
                                      .ingredientName!
                                      .clear();
                                  Get.find<TextFieldController>()
                                      .ingredientPrice!
                                      .clear();
                                },
                                child: Text('저장'),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    Get.find<TextFieldController>()
                                        .ingredientName!
                                        .clear();
                                    Get.find<TextFieldController>()
                                        .ingredientPrice!
                                        .clear();
                                  },
                                  child: Text('취소')),
                            ],
                          ));
                        },
                        child: Text(ingredient.name!),
                      ),
                      Text('3g/원'),
                      Text('텍스트 필드 자리'),
                      Text('투입된 가격 자리'),
                    ],
                  ),
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.find<IngredientController>()
                .ingredients
                .add(Ingredient(name: '재료명', price: 0));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
