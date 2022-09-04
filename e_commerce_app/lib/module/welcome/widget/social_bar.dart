import 'package:flutter/material.dart';

import 'social_login.dart';

class SocialBar extends StatelessWidget {
  const SocialBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white38.withOpacity(0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SocialLogin(
              label: 'Google',
              press: () {},
              child: Image.asset('assets/images/inapp/google.jpg'),
            ),
            SocialLogin(
              label: 'Facebook',
              press: () {},
              child: Image.asset('assets/images/inapp/facebook.jpg'),
            ),
            SocialLogin(
                label: 'Guest',
                press: () {},
                child: Icon(
                  Icons.person,
                  size: 55,
                  color: Colors.blueAccent,
                )),
          ],
        ),
      ),
    );
  }
}
