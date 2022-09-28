import 'package:e_commerce_app/module/details/screens/product_detail_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductModel extends StatelessWidget {
  const ProductModel({
    Key? key,
    required this.products,
  }) : super(key: key);
  final dynamic products;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreens(
                      prodList: products,
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
                  child: Image(image: NetworkImage(products['prodimages'][0])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      products['prodname'],
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
                          products['price'].toStringAsFixed(2) + (' \$'),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        products['sid'] ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                ))
                            : IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.red,
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
