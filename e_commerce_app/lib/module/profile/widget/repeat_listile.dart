import 'package:flutter/material.dart';

class RepeatListile extends StatelessWidget {
  const RepeatListile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}
