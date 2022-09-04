import 'package:flutter/material.dart';

import 'repeat_listile.dart';
import 'yellow_divider.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({
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
                title: 'Edit Profile',
                subTitle: '',
                icon: Icons.edit,
                press: () {}),
            YellowDivider(),
            RepeatListile(
                title: 'Change Password',
                subTitle: '',
                icon: Icons.lock,
                press: () {}),
            YellowDivider(),
            RepeatListile(
                title: 'Log Out',
                subTitle: '',
                icon: Icons.logout,
                press: () {
                  Navigator.pushReplacementNamed(context, '/welcome_screens');
                }),
            YellowDivider(),
          ],
        ),
      ),
    );
  }
}
