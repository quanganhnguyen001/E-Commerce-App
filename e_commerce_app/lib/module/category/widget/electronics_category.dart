import 'package:e_commerce_app/model/category_list.dart';
import 'package:flutter/material.dart';

import 'list_categ_product.dart';
import 'slide_bar.dart';
import 'title_category_product.dart';

class ElectronicsCategory extends StatelessWidget {
  const ElectronicsCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: size.height * 0.8,
              width: size.width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleCategProduct(
                    title: 'Electronics',
                  ),
                  SizedBox(
                    height: size.height * 0.68,
                    child: GridView.count(
                      mainAxisSpacing: 70,
                      crossAxisSpacing: 15,
                      crossAxisCount: 3,
                      children: List.generate(
                        electronics.length,
                        (index) => ListCategProduct(
                          subCategName: 'electronics',
                          subCategLabel: electronics[index],
                          imageProd:
                              'assets/images/electronics/electronics$index.jpg',
                          mainNameProd: electronics[index],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SlideBar(
              size: size,
              mainCategName: 'electronics',
            ),
          ),
        ],
      ),
    );
  }
}
