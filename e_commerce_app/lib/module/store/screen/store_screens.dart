import 'package:flutter/material.dart';

class StoreScreens extends StatelessWidget {
  const StoreScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Stores',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
    );
  }
}
