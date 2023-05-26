import 'package:flutter/material.dart';
import 'package:flutter_application_7/View/addingredient.dart';
import 'package:flutter_application_7/bindings.dart';
import 'package:flutter_application_7/controllers/souce_controller.dart';
import 'package:flutter_application_7/model/souce.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('레시피 입력'),
                bottom: const TabBar(tabs: [
                  Tab(
                    text: '소스',
                  ),
                  Tab(
                    text: '메뉴',
                  ),
                ]),
              ),
              body: TabBarView(children: [
                Scaffold(
                  body: Container(
                    height: 350,
                    child: ListView.builder(
                        itemCount: Get.find<SouceController>().souces.length,
                        itemBuilder: (context, index) {
                          var souce = Get.find<SouceController>().souces[index];
                          return ListTile(
                            onLongPress: () {
                              Get.defaultDialog(
                                title: '알림',
                                middleText: '레시피가 삭제 됩니다',
                                textConfirm: '삭제',
                                textCancel: '취소',
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  Get.find<SouceController>()
                                      .souces
                                      .removeAt(index);

                                  Get.back();
                                },
                                onCancel: () {
                                  Get.back();
                                },
                              );
                            },
                            title: Text(souce.souceName!),
                            subtitle: Text('${souce.totalPrice!}'),
                          );
                        }),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      //소스 추가하는 코드
                      Get.find<SouceController>()
                          .souces
                          .add(Souce(souceName: '재료이름', totalPrice: 0));

                      Get.toNamed("/addingredient");
                    },
                    child: Icon(
                      Icons.add,
                    ),
                    backgroundColor: Colors.red,
                  ),
                ),
                Scaffold(
                  body: Center(child: Text('2')),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.add,
                    ),
                    backgroundColor: Colors.blue,
                  ),
                )
              ]),
            )),
      ),
    );
  }
}

//소스 리스트 추가
