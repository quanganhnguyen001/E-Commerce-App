import 'package:e_commerce_app/common/widget/alert_dialog.dart';
import 'package:e_commerce_app/module/profile/widget/change_password.dart';
import 'package:e_commerce_app/repository/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                }),
            YellowDivider(),
            RepeatListile(
                title: 'Log Out',
                subTitle: '',
                icon: Icons.logout,
                press: () async {
                  MyAlertDialog.showDialog(
                    context: context,
                    title: 'Log Out',
                    content: 'Are you sure want to log out ?',
                    pressNo: () {
                      Navigator.pop(context);
                    },
                    pressYes: () async {
                      await AuthRepo.logOut();
                      await Future.delayed(Duration(microseconds: 100))
                          .whenComplete(() {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            context, '/welcome_screens');
                      });
                    },
                  );
                }),
            YellowDivider(),
          ],
        ),
      ),
    );
  }
}
