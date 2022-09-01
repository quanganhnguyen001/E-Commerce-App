import 'package:flutter/material.dart';

import 'sub_category_product.dart';

class ListCategProduct extends StatelessWidget {
  const ListCategProduct({
    Key? key,
    required this.mainNameProd,
    required this.imageProd,
    required this.subCategName,
    required this.subCategLabel,
  }) : super(key: key);

  final String mainNameProd;
  final String imageProd;
  final String subCategLabel;
  final String subCategName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubCategProduct(
                      title: mainNameProd,
                      labelProduct: subCategName,
                    )));
      },
      child: Column(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image(
              image: AssetImage(imageProd),
            ),
          ),
          Text(
            subCategLabel,
            style: TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
