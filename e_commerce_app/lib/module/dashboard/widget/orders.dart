import 'package:e_commerce_app/module/dashboard/widget/delivered_order.dart';
import 'package:e_commerce_app/module/dashboard/widget/preparing_order.dart';
import 'package:e_commerce_app/module/dashboard/widget/shipping_order.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/appbar_back_button.dart';
import '../../../common/widget/appbar_title.dart';
import 'repeated_tab.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: AppBarTitle(
            title: 'Orders',
          ),
          leading: AppBarBackButton(),
          bottom: TabBar(
            indicatorColor: Colors.red,
            indicatorWeight: 6,
            tabs: [
              RepeatedTab(
                label: 'Preparing',
              ),
              RepeatedTab(
                label: 'Shipping',
              ),
              RepeatedTab(
                label: 'Delivered',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PreparingOrder(),
            ShippingOrder(),
            DeliveredOrder(),
          ],
        ),
      ),
    );
  }
}
