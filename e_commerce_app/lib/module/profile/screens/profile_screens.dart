import 'package:e_commerce_app/common/widget/appbar_back_button.dart';
import 'package:e_commerce_app/module/cart/screens/cart_screens.dart';
import 'package:e_commerce_app/module/profile/widget/customer_orders.dart';
import 'package:e_commerce_app/module/profile/widget/customer_wishlist.dart';
import 'package:e_commerce_app/module/profile/widget/profile_headers.dart';
import 'package:flutter/material.dart';

import '../widget/profile_button.dart';
import '../widget/profile_info.dart';
import '../widget/profile_settings.dart';
import '../widget/repeat_listile.dart';

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({Key? key}) : super(key: key);

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Container(
            height: 230,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.yellow,
                  Colors.brown,
                ],
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.white,
                expandedHeight: 140,
                flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: AnimatedOpacity(
                      opacity: constraints.biggest.height <= 120 ? 1 : 0,
                      duration: Duration(milliseconds: 200),
                      child: Text(
                        'Account',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    background: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, left: 30),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage('assets/images/inapp/guest.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                'guest'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.yellow,
                            Colors.brown,
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfileButton(
                            size: size,
                            nameButton: 'Cart',
                            color: Colors.black54,
                            textColor: Colors.yellow,
                            press: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartScreens(
                                            back: AppBarBackButton(),
                                          )));
                            },
                          ),
                          ProfileButton(
                            size: size,
                            nameButton: 'Orders',
                            color: Colors.yellow,
                            textColor: Colors.black,
                            press: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CustomerOrders()));
                            },
                          ),
                          ProfileButton(
                            size: size,
                            nameButton: 'WishList',
                            color: Colors.black54,
                            textColor: Colors.yellow,
                            press: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CustomerWishList()));
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade300,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 150,
                            child: Image(
                              image: AssetImage('assets/images/inapp/logo.jpg'),
                            ),
                          ),
                          ProfileHeaders(name: 'Account Info'),
                          ProfileInfo(),
                          ProfileHeaders(name: 'Account Settings'),
                          ProfileSettings(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
