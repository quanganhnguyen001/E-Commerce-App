import 'dart:math';

import 'package:flutter/material.dart';

import '../../../common/widget/yellow_button.dart';
import 'animated_logo.dart';

class UserContainer extends StatefulWidget {
  const UserContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<UserContainer> createState() => _UserContainerState();
}

class _UserContainerState extends State<UserContainer>
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
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: YellowButton(
                size: widget.size,
                label: 'Login',
                press: () {
                  Navigator.pushReplacementNamed(context, '/customer_screens');
                },
                width: 0.25),
          ),
          YellowButton(
              size: widget.size, label: 'Signup', press: () {}, width: 0.25),
          AnimatedLogo(controller: _controller),
        ],
      ),
    );
  }
}
