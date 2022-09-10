import 'dart:math';

import 'package:e_commerce_app/module/home/widget/admin_home.dart';
import 'package:e_commerce_app/module/welcome/widget/animated_logo.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/yellow_button.dart';

class AdminContainer extends StatefulWidget {
  const AdminContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<AdminContainer> createState() => _AdminContainerState();
}

class _AdminContainerState extends State<AdminContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _controller.repeat();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: widget.size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedLogo(controller: _controller),
          YellowButton(
              size: widget.size,
              label: 'Login',
              press: () {
                Navigator.pushReplacementNamed(context, '/admin_login');
              },
              width: 0.25),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: YellowButton(
                size: widget.size,
                label: 'Signup',
                press: () {
                  Navigator.pushReplacementNamed(context, '/admin_signup');
                },
                width: 0.25),
          ),
        ],
      ),
    );
  }
}
