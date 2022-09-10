import 'package:e_commerce_app/module/dashboard/widget/balance.dart';
import 'package:e_commerce_app/module/dashboard/widget/edit_profile.dart';
import 'package:e_commerce_app/module/dashboard/widget/manage_product.dart';
import 'package:e_commerce_app/module/dashboard/widget/my_store.dart';
import 'package:e_commerce_app/module/dashboard/widget/orders.dart';
import 'package:e_commerce_app/module/dashboard/widget/statics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/alert_dialog.dart';

List<String> label = [
  'my store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'statics',
];

List<Widget> pages = [
  MyStore(),
  Orders(),
  EditProfile(),
  ManageProducts(),
  Balance(),
  Statics(),
];

List<IconData> icon = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];

class DashBoardScreens extends StatelessWidget {
  const DashBoardScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('DashBoard'),
        actions: [
          IconButton(
              onPressed: () {
                MyAlertDialog.showDialog(
                  context: context,
                  title: 'Log Out',
                  content: 'Are you sure want to log out ?',
                  pressNo: () {
                    Navigator.pop(context);
                  },
                  pressYes: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/welcome_screens');
                  },
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(
            6,
            (index) => InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => pages[index]));
              },
              child: Card(
                elevation: 20,
                shadowColor: Colors.pinkAccent.shade200,
                color: Colors.blueGrey.withOpacity(0.7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      icon[index],
                      color: Colors.yellowAccent,
                      size: 50,
                    ),
                    Text(
                      label[index].toUpperCase(),
                      style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 24,
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Acme'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
