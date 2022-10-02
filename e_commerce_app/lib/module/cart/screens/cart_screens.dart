import 'package:e_commerce_app/common/widget/appbar_back_button.dart';
import 'package:e_commerce_app/module/home/screens/home_screens.dart';
import 'package:e_commerce_app/module/home/widget/customer_home.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../common/widget/yellow_button.dart';

class CartScreens extends StatefulWidget {
  const CartScreens({Key? key, this.back}) : super(key: key);

  final Widget? back;

  @override
  State<CartScreens> createState() => _CartScreensState();
}

class _CartScreensState extends State<CartScreens> {
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
          'Cart',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        leading: widget.back,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return ListView.builder(
              itemCount: cart.count,
              itemBuilder: (context, index) {
                final product = cart.getItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 120,
                            child: Image.network(product.imagesUrl.first),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade700),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        product.price.toStringAsFixed(2),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        height: 35,
                                        child: Row(
                                          children: [
                                            product.quantitycart == 1
                                                ? IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.delete,
                                                      size: 18,
                                                    ))
                                                : IconButton(
                                                    onPressed: () {
                                                      cart.reduce(product);
                                                    },
                                                    icon: Icon(
                                                      FontAwesomeIcons.minus,
                                                      size: 18,
                                                    )),
                                            Text(
                                              product.quantitycart.toString(),
                                              style: product.quantitycart ==
                                                      product.quantityprod
                                                  ? TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.red)
                                                  : TextStyle(
                                                      fontSize: 20,
                                                    ),
                                            ),
                                            IconButton(
                                                onPressed: product
                                                            .quantitycart ==
                                                        product.quantityprod
                                                    ? null
                                                    : () {
                                                        cart.increment(product);
                                                      },
                                                icon: Icon(
                                                  FontAwesomeIcons.plus,
                                                  size: 18,
                                                )),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         'Your Cart is empty',
      //         style: TextStyle(fontSize: 30),
      //       ),
      //       SizedBox(
      //         height: 50,
      //       ),
      //       Material(
      //         color: Colors.lightBlueAccent,
      //         borderRadius: BorderRadius.circular(25),
      //         child: MaterialButton(
      //           minWidth: size.width * 0.6,
      //           onPressed: () {
      //             Navigator.canPop(context)
      //                 ? Navigator.pop(context)
      //                 : Navigator.pushReplacementNamed(
      //                     context, '/customer_screens');
      //           },
      //           child: Text(
      //             'Continue shopping',
      //             style: TextStyle(fontSize: 18, color: Colors.white),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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
                  '0.00',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            YellowButton(
              size: size,
              label: 'CHECK OUT',
              width: 0.45,
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
