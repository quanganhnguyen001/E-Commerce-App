import 'package:e_commerce_app/module/auth/screens/admin/admin_login.dart';
import 'package:e_commerce_app/module/auth/screens/admin/admin_signup.dart';
import 'package:e_commerce_app/module/auth/screens/customers/customer_login.dart';
import 'package:e_commerce_app/module/auth/screens/customers/customer_signup.dart';
import 'package:e_commerce_app/module/home/widget/admin_home.dart';
import 'package:e_commerce_app/module/home/widget/customer_home.dart';
import 'package:e_commerce_app/module/welcome/screens/welcome_screens.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/wish_list_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'module/home/screens/home_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Cart()),
    ChangeNotifierProvider(create: (_) => Wish()),
  ], child: const MyApp()));
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
      initialRoute: '/welcome_screens',
      routes: {
        '/welcome_screens': (context) => WelcomeScreens(),
        '/customer_screens': (context) => CustomerHomeScreen(),
        '/admin_screens': (context) => AdminHome(),
        '/customer_signup': (context) => CustomerSignup(),
        '/customer_login': (context) => CustomerLogin(),
        '/admin_login': (context) => AdminLogin(),
        '/admin_signup': (context) => AdminSignup(),
      },
    );
  }
}
