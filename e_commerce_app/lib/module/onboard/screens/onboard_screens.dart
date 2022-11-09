import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/module/category/widget/sub_category_product.dart';
import 'package:e_commerce_app/module/gallery/screens/shoes_gallery.dart';
import 'package:e_commerce_app/module/onboard/widget/hot_deals.dart';
import 'package:flutter/material.dart';

class OnboardScreens extends StatefulWidget {
  const OnboardScreens({Key? key}) : super(key: key);

  @override
  State<OnboardScreens> createState() => _OnboardScreensState();
}

class _OnboardScreensState extends State<OnboardScreens> {
  Timer? countDownTimer;
  int second = 3;
  List<int> discountList = [];
  int? maxDiscount;

  @override
  void initState() {
    startTimer();
    getDiscount();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void startTimer() {
    countDownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        second--;
      });
      if (second < 0) {
        stopTimer();
        Navigator.pushReplacementNamed(context, '/customer_screens');
      }
    });
  }

  void stopTimer() {
    countDownTimer!.cancel();
  }

  void getDiscount() {
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        discountList.add(doc['discount']);
      }
    }).whenComplete(() => setState(() {
              maxDiscount = discountList.reduce(max);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              stopTimer();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HotDealsScreen(
                            fromOnBoarding: true,
                            maxDiscount: maxDiscount.toString(),
                          )),
                  (Route route) => false);
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ShoesGallery(
              //               fromOnboard: true,
              //             )),
              //     (Route route) => false);
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => SubCategProduct(
              //               title: 'smart watch',
              //               labelProduct: 'electronics',
              //               fromOnboard: true,
              //             )),
              //     (Route route) => false);
            },
            child: Image.asset(
              'assets/images/onboard/sale.JPEG',
              width: 600,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 60,
            right: 30,
            child: Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade600.withOpacity(0.5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: MaterialButton(
                onPressed: () {
                  stopTimer();
                  Navigator.pushReplacementNamed(context, '/customer_screens');
                },
                child: second < 1 ? Text('Skip') : Text('Skip | $second'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
