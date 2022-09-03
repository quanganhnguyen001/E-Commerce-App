import 'package:e_commerce_app/module/cart/screens/cart_screens.dart';
import 'package:e_commerce_app/module/category/screens/category_screens.dart';
import 'package:e_commerce_app/module/dashboard/screens/dashboard_screens.dart';
import 'package:e_commerce_app/module/home/screens/home_screens.dart';
import 'package:e_commerce_app/module/profile/screens/profile_screens.dart';
import 'package:e_commerce_app/module/store/screen/store_screens.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => AdminHomeState();
}

class AdminHomeState extends State<AdminHome> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    HomeScreens(),
    CategoryScreens(),
    StoreScreens(),
    DashBoardScreens(),
    Center(
      child: Text('Up'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: _buildBottomBar(),
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
            Icons.category_outlined,
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
            Icons.dashboard,
            size: 35,
          ),
          label: 'DashBoart',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.upload,
            size: 35,
          ),
          label: 'Upload',
        ),
      ],
    );
  }
}
