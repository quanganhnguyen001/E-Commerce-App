import 'package:flutter/material.dart';

import '../../../common/widget/appbar_back_button.dart';
import '../../../common/widget/appbar_title.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: AppBarTitle(
          title: 'Orders',
        ),
        leading: AppBarBackButton(),
      ),
    );
  }
}