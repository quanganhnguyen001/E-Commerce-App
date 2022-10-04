import 'package:e_commerce_app/module/details/screens/product_detail_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/wish_provider.dart';
import 'package:collection/collection.dart';

class ProductModel extends StatefulWidget {
  const ProductModel({
    Key? key,
    required this.products,
  }) : super(key: key);
  final dynamic products;

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreens(
                      prodList: widget.products,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Container(
                  constraints: BoxConstraints(maxHeight: 280, minHeight: 100),
                  child: Image(
                      image: NetworkImage(widget.products['prodimages'][0])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      widget.products['prodname'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.products['price'].toStringAsFixed(2) + (' \$'),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        widget.products['sid'] ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                ))
                            : IconButton(
                                onPressed: () {
                                  context
                                              .read<Wish>()
                                              .getWishItems
                                              .firstWhereOrNull((product) =>
                                                  product.documentId ==
                                                  widget.products['proid']) !=
                                          null
                                      ? context
                                          .read<Wish>()
                                          .removeThis(widget.products['proid'])
                                      : context.read<Wish>().addWishItems(
                                          widget.products['prodname'],
                                          widget.products['price'],
                                          1,
                                          widget.products['quantity'],
                                          widget.products['prodimages'],
                                          widget.products['proid'],
                                          widget.products['sid']);
                                },
                                icon: context
                                            .watch<Wish>()
                                            .getWishItems
                                            .firstWhereOrNull((product) =>
                                                product.documentId ==
                                                widget.products['proid']) !=
                                        null
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 30,
                                      )
                                    : Icon(
                                        Icons.favorite_outline,
                                        color: Colors.red,
                                        size: 30,
                                      )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
