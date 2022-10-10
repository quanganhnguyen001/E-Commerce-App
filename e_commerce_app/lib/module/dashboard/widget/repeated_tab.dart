import 'package:flutter/material.dart';

class RepeatedTab extends StatelessWidget {
  const RepeatedTab({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
