import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  const YellowButton({
    Key? key,
    required this.size,
    required this.label,
    required this.press,
    required this.width,
  }) : super(key: key);

  final Size size;
  final String label;
  final VoidCallback press;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(25),
      ),
      width: size.width * width,
      child: MaterialButton(
        onPressed: press,
        child: Text(label),
      ),
    );
  }
}
