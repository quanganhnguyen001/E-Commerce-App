import 'package:flutter/material.dart';

class SubCategProduct extends StatelessWidget {
  const SubCategProduct(
      {Key? key, required this.title, required this.labelProduct})
      : super(key: key);

  final String title;
  final String labelProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Text(labelProduct),
      ),
    );
  }
}
