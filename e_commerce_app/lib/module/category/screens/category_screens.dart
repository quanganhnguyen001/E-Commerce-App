import 'package:e_commerce_app/model/category_list.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/search_bar.dart';

class CategoryScreens extends StatefulWidget {
  const CategoryScreens({Key? key}) : super(key: key);

  @override
  State<CategoryScreens> createState() => _CategoryScreensState();
}

class _CategoryScreensState extends State<CategoryScreens> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: SearchBar(),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: _sizeNavigator(size),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: _cateView(size),
          ),
        ],
      ),
    );
  }

  Container _cateView(Size size) {
    return Container(
      height: size.height * 0.8,
      width: size.width * 0.8,
      color: Colors.white,
    );
  }

  Container _sizeNavigator(Size size) {
    return Container(
      height: size.height * 0.8,
      width: size.width * 0.2,
      color: Colors.grey.shade400,
      child: ListView.builder(
          itemCount: maincateg.length,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              child: Center(
                child: Text(maincateg[index]),
              ),
            );
          }),
    );
  }
}
