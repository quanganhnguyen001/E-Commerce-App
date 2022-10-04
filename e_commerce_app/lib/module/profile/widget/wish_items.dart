import 'package:e_commerce_app/providers/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';
import 'package:collection/collection.dart';

class WishItems extends StatelessWidget {
  const WishItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(
      builder: (context, wish, child) {
        return ListView.builder(
            itemCount: wish.count,
            itemBuilder: (context, index) {
              final product = wish.getWishItems[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: SizedBox(
                    height: 110,
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
                                      product.price.toStringAsFixed(2),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              context
                                                  .read<Wish>()
                                                  .removeItem(product);
                                            },
                                            icon: Icon(Icons.delete)),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        context
                                                    .watch<Cart>()
                                                    .getItems
                                                    .firstWhereOrNull(
                                                        (element) =>
                                                            element
                                                                .documentId ==
                                                            product
                                                                .documentId) !=
                                                null
                                            ? SizedBox()
                                            : IconButton(
                                                onPressed: () {
                                                  context.read<Cart>().addItems(
                                                      product.name,
                                                      product.price,
                                                      1,
                                                      product.quantityprod,
                                                      product.imagesUrl,
                                                      product.documentId,
                                                      product.suppId);
                                                },
                                                icon: Icon(
                                                    Icons.add_shopping_cart)),
                                      ],
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
