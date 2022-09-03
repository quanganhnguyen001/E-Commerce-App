import 'package:e_commerce_app/module/home/widget/admin_home.dart';
import 'package:e_commerce_app/module/home/widget/customer_home.dart';
import 'package:flutter/material.dart';

import 'module/home/screens/home_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AdminHome(),
    );
  }
}
