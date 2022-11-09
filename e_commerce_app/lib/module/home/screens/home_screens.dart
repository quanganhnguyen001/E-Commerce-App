import 'package:e_commerce_app/module/gallery/screens/men_gallery.dart';
import 'package:e_commerce_app/module/gallery/screens/shoes_gallery.dart';
import 'package:e_commerce_app/module/gallery/screens/women_gallery.dart';
import 'package:e_commerce_app/module/home/widget/tab_details.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/search_bar.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100.withOpacity(0.5),
        appBar: AppBar(
          bottom: _buildTabbar(),
          backgroundColor: Colors.white,
          elevation: 0,
          title: SearchBar(),
        ),
        body: TabBarView(
          children: [
            MenGallery(),
            WomenGallery(),
            ShoesGallery(),
            Center(
              child: Text('bags'),
            ),
            Center(
              child: Text('electronics'),
            ),
            Center(
              child: Text('accessories'),
            ),
            Center(
              child: Text('Home & Garden'),
            ),
            Center(
              child: Text('Kids'),
            ),
            Center(
              child: Text('Beauty'),
            ),
          ],
        ),
      ),
    );
  }

  TabBar _buildTabbar() {
    return TabBar(
      isScrollable: true,
      indicatorColor: Colors.red,
      tabs: [
        TabDetails(
          title: 'Men',
        ),
        TabDetails(
          title: 'Women',
        ),
        TabDetails(
          title: 'Shoes',
        ),
        TabDetails(
          title: 'Bags',
        ),
        TabDetails(
          title: 'Electronics',
        ),
        TabDetails(
          title: 'Accessories',
        ),
        TabDetails(
          title: 'Home & Garden',
        ),
        TabDetails(
          title: 'Kids',
        ),
        TabDetails(
          title: 'Beauty',
        ),
      ],
    );
  }
}
