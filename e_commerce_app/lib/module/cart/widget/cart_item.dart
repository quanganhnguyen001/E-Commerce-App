import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';
import '../../../providers/wish_provider.dart';
import 'package:collection/collection.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      '\$' + (product.price.toStringAsFixed(2)),
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
                                                  onPressed: () {
                                                    showCupertinoModalPopup<
                                                        void>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          CupertinoActionSheet(
                                                        title: const Text(
                                                            'RemoveItem'),
                                                        message: const Text(
                                                            'Are you sure to remove this Item'),
                                                        actions: <
                                                            CupertinoActionSheetAction>[
                                                          CupertinoActionSheetAction(
                                                              onPressed:
                                                                  () async {
                                                                context.read<Wish>().getWishItems.firstWhereOrNull((element) =>
                                                                            element.documentId ==
                                                                            product
                                                                                .documentId) !=
                                                                        null
                                                                    ? context
                                                                        .read<
                                                                            Cart>()
                                                                        .removeItem(
                                                                            product)
                                                                    : await context.read<Wish>().addWishItems(
                                                                        product
                                                                            .name,
                                                                        product
                                                                            .price,
                                                                        1,
                                                                        product
                                                                            .quantityprod,
                                                                        product
                                                                            .imagesUrl,
                                                                        product
                                                                            .documentId,
                                                                        product
                                                                            .suppId);
                                                                context
                                                                    .read<
                                                                        Cart>()
                                                                    .removeItem(
                                                                        product);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'Move to WishList')),
                                                          CupertinoActionSheetAction(
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        Cart>()
                                                                    .removeItem(
                                                                        product);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'Delete Item')),
                                                        ],
                                                        cancelButton:
                                                            TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
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
                                              onPressed: product.quantitycart ==
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
                                        borderRadius: BorderRadius.circular(15),
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
    );
  }
}
