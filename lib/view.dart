import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_7/model/model.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Form 위젯 글로벌키

  final formkey = GlobalKey<FormState>();
  //text 변수 안에 ingredient.name을 넣는 함수 필요한 이유는  textformfield : 초기값을 설정하기 위해
  void ingredientOnChange(String val, Ingredient ingredient) {
    ingredient.name = val;
  }

  //String 값을 int로 변환해주는 함수, 예외처리도 완료

  void priceOnChange(String val, Ingredient ingredient) {
    try {
      double number = double.parse(val);
      ingredient.price = number;
    } catch (e) {
      print("${val}");
    }
  }

  void weightOnChange(String val, Ingredient ingredient) {
    try {
      double number = double.parse(val);
      ingredient.weight = number;
    } catch (e) {
      print("${val}");
    }
  }

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
                //ingredient 변수는 ingredients의 index값
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
                            content: Form(
                              key: formkey,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextFormField(
                                      maxLength: 5,
                                      initialValue: ingredient.name == '재료명'
                                          ? null
                                          : ingredient.name,
                                      onChanged: (val) {
                                        ingredientOnChange(val, ingredient);
                                      },
                                      autovalidateMode: AutovalidateMode.always,
                                      onSaved: (val) {
                                        ingredient.name = val!;
                                      },
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return '재료이름을 입력하세요';
                                        }
                                        return null;
                                      },
                                      decoration:
                                          InputDecoration(labelText: '재료이름'),
                                    ),
                                    TextFormField(
                                      onChanged: (val) {
                                        priceOnChange(val, ingredient);
                                      },
                                      initialValue: ingredient.price.toString(),
                                      autovalidateMode: AutovalidateMode.always,
                                      onSaved: (val) {
                                        ingredient.price = double.parse(val!);
                                      },
                                      validator: (val) {
                                        if (val!.length < 4) {
                                          return '재료가격을 입력하세요';
                                        }
                                        return null;
                                      },
                                      decoration:
                                          InputDecoration(labelText: '재료가격'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextFormField(
                                      initialValue:
                                          ingredient.weight.toString(),
                                      onChanged: (val) {
                                        weightOnChange(val, ingredient);
                                      },
                                      autovalidateMode: AutovalidateMode.always,
                                      onSaved: (val) {
                                        ingredient.weight = double.parse(val!);
                                      },
                                      validator: (val) {
                                        if (val!.length < 4) {
                                          return '재료중량을 입력하세요';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: '재료중량(g)',
                                      ),
                                      keyboardType: TextInputType.number,
                                    )
                                  ]),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  Get.find<IngredientController>().box.write(
                                      'ingredient',
                                      Get.find<IngredientController>()
                                          .ingredients
                                          .toJson());
                                  setState(() {});
                                  if (formkey.currentState!.validate()) {
                                    formkey.currentState!.save();
                                  }

                                  //gramprice 계산하는 함수

                                  ingredient.gramPrice =
                                      (ingredient.price! / ingredient.weight!)
                                          .roundToDouble();

                                  Get.back();
                                },
                                child: Text('저장'),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    // Get.find<TextFieldController>()
                                    //     .ingredientName!
                                    //     .clear();
                                    // Get.find<TextFieldController>()
                                    //     .ingredientPrice!
                                    //     .clear();
                                  },
                                  child: Text('취소')),
                            ],
                          ));
                        },
                        child: Text(ingredient.name!),
                      ),
                      Text('${ingredient.gramPrice} ' + "g/원"),
                      Text('텍스트 필드 자리'),
                      Text('${ingredient.inputPrice}'),
                    ],
                  ),
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.find<IngredientController>().ingredients.add(Ingredient(
                name: '재료명',
                price: 0,
                weight: 0,
                gramPrice: 0,
                inputWeight: 0,
                inputPrice: 0));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
