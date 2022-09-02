import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    required this.size,
    required this.nameButton,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  final Size size;
  final Color color;
  final String nameButton;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
        onPressed: () {},
        child: SizedBox(
          height: 40,
          width: size.width * 0.2,
          child: Center(
            child: Text(
              nameButton,
              style: TextStyle(color: textColor, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
