import 'package:e_commerce_app/module/dashboard/screens/dashboard_screens.dart';
import 'package:flutter/material.dart';

class StaticsModel extends StatelessWidget {
  const StaticsModel({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);
  final String label;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.55,
          child: Center(
            child: Text(
              label.toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        ),
        Container(
          height: 90,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Center(
            child: Text(
              value.toUpperCase(),
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.red),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
        ),
      ],
    );
  }
}
