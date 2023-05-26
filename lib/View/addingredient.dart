import 'package:flutter/material.dart';
import 'package:flutter_application_7/model/ingredient.dart';

import 'package:get/get.dart';

import 'package:flutter_application_7/controllers/ingredient_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Form 위젯 글로벌키
  final _formkey = GlobalKey<FormState>();
  Ingredient? ingredient;

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

  void inputweightOnChange(String val, Ingredient ingredient) {
    try {
      double number = double.parse(val);
      ingredient.inputWeight = number;
    } catch (e) {
      print("${val}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('원가 계산기'),
          centerTitle: true,
        ),
        body: Obx(
          () => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 14,
                      child: ListSectionHeader("재료명"),
                    ),
                    Expanded(
                        flex: 14,
                        child: Center(
                          child: ListSectionHeader("g/원"),
                        )),
                    Expanded(
                        flex: 12,
                        child: Center(
                          child: ListSectionHeader("레시피 중량"),
                        )),
                    Expanded(
                        flex: 12,
                        child: Center(
                          child: ListSectionHeader("재료 원가"),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount:
                        Get.find<IngredientController>().ingredients.length,
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
                            Expanded(
                              flex: 14,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.dialog(AlertDialog(
                                    title: Text('재료입력'),
                                    content: SingleChildScrollView(
                                      child: Form(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        key: _formkey,
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode.always,
                                                validator: (val) {
                                                  if (val == null ||
                                                      val.isEmpty) {
                                                    return '';
                                                  }
                                                  return null;
                                                },
                                                maxLength: 5,
                                                initialValue:
                                                    ingredient.name == '재료입력'
                                                        ? null
                                                        : ingredient.name,
                                                onChanged: (val) {
                                                  ingredientOnChange(
                                                      val, ingredient);
                                                },
                                                onSaved: (val) {
                                                  ingredient.name = val!;
                                                },
                                                decoration: InputDecoration(
                                                    labelText: '재료이름'),
                                              ),
                                              TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode.always,
                                                validator: (val) {
                                                  if (val == null ||
                                                      val.length < 4) {
                                                    return '';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (val) {
                                                  priceOnChange(
                                                      val, ingredient);
                                                },
                                                initialValue:
                                                    ingredient.price.toString(),
                                                onSaved: (val) {
                                                  ingredient.price =
                                                      double.parse(val!);
                                                },
                                                decoration: InputDecoration(
                                                    labelText: '재료가격'),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode.always,
                                                validator: (val) {
                                                  if (val == null ||
                                                      val.length < 4) {
                                                    return '';
                                                  }

                                                  return null;
                                                },
                                                initialValue: ingredient.weight
                                                    .toString(),
                                                onChanged: (val) {
                                                  weightOnChange(
                                                      val, ingredient);
                                                },
                                                onSaved: (val) {
                                                  ingredient.weight =
                                                      double.parse(val!);
                                                },
                                                decoration: InputDecoration(
                                                  labelText: '제품중량(g)',
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode.always,
                                                validator: (val) {
                                                  if (val == null ||
                                                      val.length < 4) {
                                                    return '';
                                                  }

                                                  return null;
                                                },
                                                initialValue: ingredient
                                                    .inputWeight
                                                    .toString(),
                                                onChanged: (val) {
                                                  inputweightOnChange(
                                                      val, ingredient);
                                                },
                                                onSaved: (val) {
                                                  ingredient.inputWeight =
                                                      double.parse(val!);
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: '레시피 중량',
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ]),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          //텍스트폼필드에 입력된 값의 유효성을 확인하고 저장하는 코드
                                          if (_formkey.currentState!
                                              .validate()) {
                                            _formkey.currentState!.save();
                                          }

                                          //

                                          setState(() {});

                                          //gramprice 계산하는 함수

                                          //오류의 원인 : 컴퓨터는 0 나누기 0을 할 수 없다. 그래서 생기는 오류!!!!
                                          if (ingredient.price != 0 &&
                                              ingredient.weight != 0) {
                                            ingredient.gramPrice = (ingredient
                                                        .price! /
                                                    ingredient.weight!)
                                                .roundToDouble(); //나눈값을 반올림해서 정수값으로 표현하는 함수

                                            //투입되는 레시피 재료의 원가를 계산하는 함수
                                            ingredient.inputPrice =
                                                (ingredient.gramPrice! *
                                                        ingredient.inputWeight!)
                                                    .roundToDouble();

                                            //토탈 값 구하기
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
                            ),
                            Expanded(
                                flex: 12,
                                child: Text('${ingredient.gramPrice} g/원')),
                            Expanded(
                                flex: 12,
                                child: Text('${ingredient.inputWeight} g')),
                            Expanded(
                                flex: 12,
                                child: Text('${ingredient.inputPrice} 원')),
                          ],
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Obx(() => Text(
                        '${Get.find<IngredientController>().totalgramPrice} 원')),
                    Obx(() => Text(
                        '${Get.find<IngredientController>().totalinputWeight} 원')),
                    Obx(() => Text(
                        '${Get.find<IngredientController>().totalinputPrice} 원')),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.find<IngredientController>().ingredients.add(Ingredient(
                name: '재료입력',
                price: 0,
                weight: 0,
                gramPrice: 0,
                inputWeight: 0,
                inputPrice: 0,
                totalinputPrice: 0,
                totalgramPrice: 0,
                totalinputWeight: 0));
            //재료 입력 알럿창 띄우는 코드 2
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

//재료 입력칸에서 나오는 목차 부분
class ListSectionHeader extends StatelessWidget {
  // header row with single line of text for use has a table section header
  // background color and text color is hardcoded

  // Constructor
  ListSectionHeader(this.text);

  // Properties (must be final here)
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        color: Colors.grey[200],
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(fontSize: 15),
                ))));
  }
}
