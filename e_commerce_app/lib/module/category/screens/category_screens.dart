import 'package:flutter/material.dart';

import 'package:e_commerce_app/model/category_list.dart';

import '../../../common/widget/search_bar.dart';

class CategoryScreens extends StatefulWidget {
  const CategoryScreens({Key? key}) : super(key: key);

  @override
  State<CategoryScreens> createState() => _CategoryScreensState();
}

List<ItemData> items = [
  ItemData(title: 'men'),
  ItemData(title: 'women'),
  ItemData(title: 'shoes'),
  ItemData(title: 'bags'),
  ItemData(title: 'electronics'),
  ItemData(title: 'accessories'),
  ItemData(title: 'home & garden'),
  ItemData(title: 'kids'),
  ItemData(title: 'beauty'),
];

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
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                for (var element in items) {
                  element.isSelected = false;
                }
                setState(() {
                  items[index].isSelected = true;
                });
              },
              child: Container(
                color: items[index].isSelected
                    ? Colors.white
                    : Colors.grey.shade300,
                height: 100,
                child: Center(
                  child: Text(items[index].title),
                ),
              ),
            );
          }),
    );
  }
}

class ItemData {
  String title;
  bool isSelected;
  ItemData({
    required this.title,
    this.isSelected = false,
  });
}
