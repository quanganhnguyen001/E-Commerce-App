import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'social_login.dart';

class SocialBar extends StatefulWidget {
  const SocialBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SocialBar> createState() => _SocialBarState();
}

class _SocialBarState extends State<SocialBar> {
  bool isLoading = false;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  late String _uid;
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
            isLoading
                ? CircularProgressIndicator()
                : SocialLogin(
                    label: 'Guest',
                    press: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await FirebaseAuth.instance
                          .signInAnonymously()
                          .whenComplete(() async {
                        _uid = FirebaseAuth.instance.currentUser!.uid;
                        await customers.doc(_uid).set({
                          'name': '',
                          'email': '',
                          'profileImage': '',
                          'phone': '',
                          'address': '',
                          'cid': _uid,
                        });
                      });

                      Navigator.pushReplacementNamed(
                          context, '/customer_screens');
                    },
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
