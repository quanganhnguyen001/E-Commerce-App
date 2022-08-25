import 'package:flutter/material.dart';

class TabDetails extends StatelessWidget {
  const TabDetails({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
