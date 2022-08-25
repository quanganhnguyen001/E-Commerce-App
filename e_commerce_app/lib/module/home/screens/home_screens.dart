import 'package:e_commerce_app/module/home/widget/tab_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    TabBarView(
      children: [
        Center(
          child: Text('men'),
        ),
        Center(
          child: Text('women'),
        ),
        Center(
          child: Text('shoes'),
        ),
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
    Center(
      child: Text('Category'),
    ),
    Center(
      child: Text('Store'),
    ),
    Center(
      child: Text('Cart'),
    ),
    Center(
      child: Text('Profile'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          bottom: _buildTabbar(),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            height: 40,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade200,
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search'),
            ),
          ),
        ),
        body: _tabs[_selectedIndex],
        bottomNavigationBar: _buildBottomBar(),
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

  BottomNavigationBar _buildBottomBar() {
    return BottomNavigationBar(
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 35,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            size: 35,
          ),
          label: 'Category,',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shop,
            size: 35,
          ),
          label: 'Stores',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
            size: 35,
          ),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 35,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
