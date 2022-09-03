import 'package:flutter/material.dart';

import 'repeat_listile.dart';
import 'yellow_divider.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
  }) : super(key: key);

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
              subTitle: 'test@gmail.com',
              icon: Icons.email,
              press: () {},
            ),
            YellowDivider(),
            RepeatListile(
                title: 'Phone',
                subTitle: '123456789',
                icon: Icons.phone_android,
                press: () {}),
            YellowDivider(),
            RepeatListile(
                title: 'Address',
                subTitle: 'Viet Nam',
                icon: Icons.location_on,
                press: () {}),
            YellowDivider(),
          ],
        ),
      ),
    );
  }
}
