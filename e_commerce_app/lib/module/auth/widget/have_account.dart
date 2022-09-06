import 'package:flutter/material.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({
    Key? key,
    required this.haveAccount,
    required this.actionLabel,
    required this.press,
  }) : super(key: key);

  final String haveAccount;
  final String actionLabel;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          haveAccount,
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        TextButton(
          onPressed: press,
          child: Text(
            actionLabel,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
                fontSize: 20),
          ),
        ),
      ],
    );
  }
}
