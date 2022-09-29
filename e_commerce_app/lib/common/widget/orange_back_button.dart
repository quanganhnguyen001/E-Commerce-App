import 'package:flutter/material.dart';

class OrangeBackButton extends StatelessWidget {
  const OrangeBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.orange,
      ),
    );
  }
}
