import 'package:e_commerce_app/module/profile/widget/add_address.dart';
import 'package:e_commerce_app/module/profile/widget/address_book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'repeat_listile.dart';
import 'yellow_divider.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
    required this.emailName,
    required this.phone,
    required this.address,
  }) : super(key: key);
  final String emailName;
  final String phone;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            RepeatListile(
              title: 'Email',
              subTitle: emailName,
              icon: Icons.email,
              press: () {},
            ),
            YellowDivider(),
            RepeatListile(
                title: 'Phone',
                subTitle: phone,
                icon: Icons.phone_android,
                press: () {}),
            YellowDivider(),
            RepeatListile(
                title: 'Address',
                subTitle: address,
                icon: Icons.location_on,
                press: FirebaseAuth.instance.currentUser!.isAnonymous
                    ? null
                    : () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => AddressBook()));
                      }),
            YellowDivider(),
          ],
        ),
      ),
    );
  }
}
