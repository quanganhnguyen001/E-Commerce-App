import 'package:flutter/material.dart';

import '../widget/profile_button.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            expandedHeight: 140,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return FlexibleSpaceBar(
                title: AnimatedOpacity(
                  opacity: constraints.biggest.height <= 120 ? 1 : 0,
                  duration: Duration(milliseconds: 200),
                  child: Text(
                    'Account',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                background: Container(
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
                      ),
                      ProfileButton(
                        size: size,
                        nameButton: 'Orders',
                        color: Colors.yellow,
                        textColor: Colors.black,
                      ),
                      ProfileButton(
                        size: size,
                        nameButton: 'WishList',
                        color: Colors.black54,
                        textColor: Colors.yellow,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
