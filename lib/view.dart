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
  //Form 위젯 글로벌키
  final _formkey = GlobalKey<FormState>();
  //text 변수 안에 ingredient.name을 넣는 함수 필요한 이유는  textformfield : 초기값을 설정하기 위해
  void ingredientOnChange(String val, Ingredient ingredient) {
    ingredient.name = val;
    //이름의 값이 비어있지 않으면 val값 비어있으면 null값 ! 이렇게 null값을 관리 하는 듯
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: _formkey,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextFormField(
                                      autovalidateMode: AutovalidateMode.always,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return '재료이름을 입력하세요';
                                        }
                                        return null;
                                      },
                                      maxLength: 5,
                                      initialValue: ingredient.name == '재료명'
                                          ? null
                                          : ingredient.name,
                                      onChanged: (val) {
                                        ingredientOnChange(val, ingredient);
                                      },
                                      onSaved: (val) {
                                        ingredient.name = val!;
                                      },
                                      decoration:
                                          InputDecoration(labelText: '재료이름'),
                                    ),
                                    TextFormField(
                                      autovalidateMode: AutovalidateMode.always,
                                      validator: (val) {
                                        if (val == null || val.length < 4) {
                                          return '재료가격을 입력하세요';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        priceOnChange(val, ingredient);
                                      },
                                      initialValue: ingredient.price.toString(),
                                      onSaved: (val) {
                                        ingredient.price = double.parse(val!);
                                      },
                                      decoration:
                                          InputDecoration(labelText: '재료가격'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextFormField(
                                      autovalidateMode: AutovalidateMode.always,
                                      validator: (val) {
                                        if (val == null || val.length < 4) {
                                          return '재료중량을 입력하세요';
                                        }

                                        return null;
                                      },
                                      initialValue:
                                          ingredient.weight.toString(),
                                      onChanged: (val) {
                                        weightOnChange(val, ingredient);
                                      },
                                      onSaved: (val) {
                                        ingredient.weight = double.parse(val!);
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
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    _formkey.currentState!.save();
                                  }

//                                해당 텍스트필드의 값이 null이면 해당 값을 지정해서 저장하게 하는 함수
                                  if (ingredient.name == null &&
                                      ingredient.price == null &&
                                      ingredient.price == null) {
                                    ingredient.name = '재료명';
                                    ingredient.price = 0;
                                    ingredient.weight = 0;
                                  }

                                  Get.find<IngredientController>().box.write(
                                      'ingredient',
                                      Get.find<IngredientController>()
                                          .ingredients
                                          .toJson());
                                  setState(() {});

                                  //gramprice 계산하는 함수

                                  //오류의 원인 : 컴퓨터는 0 나누기 0을 할 수 없다. 그래서 생기는 오류!!!!
                                  if (ingredient.price != 0 &&
                                      ingredient.weight != 0) {
                                    ingredient.gramPrice = (ingredient.price! /
                                            ingredient.weight!)
                                        .roundToDouble(); //나눈값을 반올림해서 정수값으로 표현하는 함수
                                  }

                                  Get.back();
                                },
                                child: Text('저장'),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('취소')),
                            ],
                          ));
                        },
                        child: Text(ingredient.name!),
                      ),
                      Text('${ingredient.gramPrice} g/원'),
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
