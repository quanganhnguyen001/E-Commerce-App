import 'dart:async';

import 'package:flutter/material.dart';

class OnboardScreens extends StatefulWidget {
  const OnboardScreens({Key? key}) : super(key: key);

  @override
  State<OnboardScreens> createState() => _OnboardScreensState();
}

class _OnboardScreensState extends State<OnboardScreens> {
  Timer? countDownTimer;
  int second = 3;

  @override
  void initState() {
    startTimer();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/onboard/watches.JPEG',
            width: 600,
            fit: BoxFit.cover,
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
