import 'package:e_commerce_app/module/category/widget/men_category.dart';
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
  final PageController _pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    for (var element in items) {
      element.isSelected = false;
    }
    setState(() {
      items[0].isSelected = true;
    });
    super.initState();
  }

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
            child: _sideNavigator(size),
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
      child: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          for (var element in items) {
            element.isSelected = false;
          }
          setState(() {
            items[value].isSelected = true;
          });
        },
        scrollDirection: Axis.vertical,
        children: [
          MenCategory(),
          Center(
            child: Text('women category'),
          ),
          Center(
            child: Text('shoes category'),
          ),
          Center(
            child: Text('bags category'),
          ),
          Center(
            child: Text('electronics category'),
          ),
          Center(
            child: Text('accessories category'),
          ),
          Center(
            child: Text('home and garden category'),
          ),
          Center(
            child: Text('kids category'),
          ),
          Center(
            child: Text('beauty category'),
          ),
        ],
      ),
    );
  }

  Container _sideNavigator(Size size) {
    return Container(
      height: size.height * 0.8,
      width: size.width * 0.2,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceInOut);
                // for (var element in items) {
                //   element.isSelected = false;
                // }
                // setState(() {
                //   items[index].isSelected = true;
                // });
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
