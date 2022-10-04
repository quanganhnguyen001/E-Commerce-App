import 'package:e_commerce_app/common/widget/alert_dialog.dart';
import 'package:e_commerce_app/common/widget/appbar_back_button.dart';
import 'package:e_commerce_app/module/home/screens/home_screens.dart';
import 'package:e_commerce_app/module/home/widget/customer_home.dart';

import 'package:e_commerce_app/module/profile/widget/wish_items.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../common/widget/yellow_button.dart';
import '../../cart/widget/cart_item.dart';
import '../../cart/widget/empty_cart.dart';
import 'empty_wishlist.dart';

class CustomerWishList extends StatefulWidget {
  const CustomerWishList({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerWishList> createState() => _CustomerWishListState();
}

class _CustomerWishListState extends State<CustomerWishList> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'CustomerWishList',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        leading: AppBarBackButton(),
      ),
      body: context.watch<Wish>().getWishItems.isNotEmpty
          ? WishItems()
          : EmptyWishList(size: size),
    );
  }
}
