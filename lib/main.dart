import 'package:flutter/material.dart';
import 'package:flutter_application_7/bindings.dart';
import 'package:flutter_application_7/view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MyBindings(),
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}
