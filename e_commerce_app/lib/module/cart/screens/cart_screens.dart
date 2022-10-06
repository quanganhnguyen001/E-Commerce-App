import 'package:e_commerce_app/common/widget/alert_dialog.dart';
import 'package:e_commerce_app/common/widget/appbar_back_button.dart';
import 'package:e_commerce_app/module/home/screens/home_screens.dart';
import 'package:e_commerce_app/module/home/widget/customer_home.dart';
import 'package:e_commerce_app/module/order/screens/order_screens.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../common/widget/yellow_button.dart';
import '../widget/cart_item.dart';
import '../widget/empty_cart.dart';

class CartScreens extends StatefulWidget {
  const CartScreens({Key? key, this.back}) : super(key: key);

  final Widget? back;

  @override
  State<CartScreens> createState() => _CartScreensState();
}

class _CartScreensState extends State<CartScreens> {
  @override
  Widget build(BuildContext context) {
    double total = context.watch<Cart>().totalPrice;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        leading: widget.back,
        actions: [
          context.watch<Cart>().getItems.isEmpty
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    MyAlertDialog.showDialog(
                        context: context,
                        title: 'Clear Cart',
                        content: 'Are you sure to clear cart ?',
                        pressNo: () {
                          Navigator.pop(context);
                        },
                        pressYes: () {
                          context.read<Cart>().clearCart();
                          Navigator.pop(context);
                        });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                ),
        ],
      ),
      body: context.watch<Cart>().getItems.isNotEmpty
          ? CartItem()
          : EmptyCart(size: size),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Total: \$ ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  total.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            Container(
              height: 35,
              width: size.width * 0.45,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(25),
              ),
              child: MaterialButton(
                onPressed: total == 0.0
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderScreens()));
                      },
                child: Text('CHECK OUT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
