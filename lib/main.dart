import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_goals/tasks/view/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO',
      theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'Neo'),
      home: HomePage(),
    );
  }
}
