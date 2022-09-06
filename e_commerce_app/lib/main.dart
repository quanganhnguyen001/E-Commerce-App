import 'package:e_commerce_app/module/auth/screens/customer_signup.dart';
import 'package:e_commerce_app/module/home/widget/admin_home.dart';
import 'package:e_commerce_app/module/home/widget/customer_home.dart';
import 'package:e_commerce_app/module/welcome/screens/welcome_screens.dart';
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
      // home: const WelcomeScreens(),
      initialRoute: '/welcome_screens',
      routes: {
        '/welcome_screens': (context) => WelcomeScreens(),
        '/customer_screens': (context) => CustomerHomeScreen(),
        '/admin_screens': (context) => AdminHome(),
        '/customer_signup': (context) => CustomerSignup(),
      },
    );
  }
}
