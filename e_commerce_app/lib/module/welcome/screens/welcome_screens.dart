import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce_app/common/widget/yellow_button.dart';
import 'package:e_commerce_app/module/welcome/widget/user_container.dart';
import 'package:flutter/material.dart';

import '../widget/admin_container.dart';
import '../widget/social_bar.dart';
import '../widget/social_login.dart';

const textColors = [
  Colors.yellowAccent,
  Colors.red,
  Colors.blueAccent,
  Colors.green,
  Colors.purple,
  Colors.teal
];

const textStyle =
    TextStyle(fontFamily: 'Acme', fontWeight: FontWeight.bold, fontSize: 45);

class WelcomeScreens extends StatefulWidget {
  const WelcomeScreens({Key? key}) : super(key: key);

  @override
  State<WelcomeScreens> createState() => _WelcomeScreensState();
}

class _WelcomeScreensState extends State<WelcomeScreens> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(), // not depend on child
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/inapp/bgimage.jpg'),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedTextKit(
                isRepeatingAnimation: true,
                repeatForever: true,
                animatedTexts: [
                  ColorizeAnimatedText('Welcome',
                      textStyle: textStyle, colors: textColors),
                  ColorizeAnimatedText('QA Store',
                      textStyle: textStyle, colors: textColors),
                ],
              ),
              SizedBox(
                height: 120,
                width: 200,
                child: Image(
                  image: AssetImage('assets/images/inapp/logo.jpg'),
                ),
              ),
              SizedBox(
                height: 80,
                child: DefaultTextStyle(
                  style: textStyle,
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      RotateAnimatedText('SHOPPING'),
                      RotateAnimatedText('NOW'),
                      RotateAnimatedText('EVERBODY'),
                    ],
                  ),
                ),
              ),
              // Text(
              //   'QA Store',
              //   style: TextStyle(color: Colors.white, fontSize: 30),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            'Admin Only',
                            style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AdminContainer(size: size),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UserContainer(size: size),
                ],
              ),
              SocialBar(),
            ],
          ),
        ),
      ),
    );
  }
}
