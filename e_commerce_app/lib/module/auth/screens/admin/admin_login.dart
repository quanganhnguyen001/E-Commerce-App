import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widget/message_handler.dart';
import 'package:e_commerce_app/common/widget/yellow_button.dart';
import 'package:e_commerce_app/module/auth/widget/forgot_password.dart';
import 'package:e_commerce_app/repository/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../widget/auth_button.dart';
import '../../widget/auth_header.dart';
import '../../widget/have_account.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  CollectionReference admin = FirebaseFirestore.instance.collection('admin');

  bool isVisible = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late String email;
  late String password;
  bool _isLoading = false;
  bool _isVerified = false;
  late String _uid;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .whenComplete(() async {
      print(googleUser);
      print(googleUser!.id);
      _uid = FirebaseAuth.instance.currentUser!.uid;
      await admin.doc(_uid).set({
        'adminname': googleUser.displayName,
        'email': googleUser.email,
        'adminimage': googleUser.photoUrl,
        'phone': '',
        'aid': _uid,
        'coverimage': '',
      }).then(
          (value) => Navigator.pushReplacementNamed(context, '/admin_screens'));
    });
  }

  void _logIn() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        await AuthRepo.signInEmailPassword(email, password);
        await AuthRepo.reloadUserData();
        if (await AuthRepo.checkEmailVerified()) {
          _formKey.currentState!.reset();

          Navigator.pushReplacementNamed(context, '/admin_screens');
        } else {
          MessageHandler.showSnackBar(
              _scaffoldKey, 'Pls check your gmail inbox and login again');
          setState(() {
            _isLoading = false;
            _isVerified = true;
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        MessageHandler.showSnackBar(_scaffoldKey, e.message.toString());
        // if (e.code == 'user-not-found') {
        //   setState(() {
        //     _isLoading = false;
        //   });
        //   MessageHandler.showSnackBar(
        //       _scaffoldKey, 'No user found for that email.');
        // } else if (e.code == 'wrong-password') {
        //   setState(() {
        //     _isLoading = false;
        //   });
        //   MessageHandler.showSnackBar(
        //       _scaffoldKey, 'Wrong password provided for that user.');
        // }
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      MessageHandler.showSnackBar(_scaffoldKey, 'Pls fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthHeader(
                        title: 'Login',
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          // controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Pls enter your email';
                            } else if (value.isValidEmail() == false) {
                              return 'Invalid email';
                            } else if (value.isValidEmail() == true) {
                              return null;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormDecoration.copyWith(
                              labelText: 'Email Address',
                              hintText: 'Enter your email'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          onChanged: (value) {
                            password = value;
                          },
                          // controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 8) {
                              return 'Pls enter valid password';
                            }
                            return null;
                          },
                          obscureText: isVisible,
                          decoration: textFormDecoration.copyWith(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                color: Colors.purple,
                              ),
                              labelText: 'Password',
                              hintText: 'Enter your Password'),
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPassword()));
                              },
                              child: Text(
                                'Forget Password ?',
                                style: TextStyle(
                                    fontSize: 18, fontStyle: FontStyle.italic),
                              )),
                          _isVerified == true
                              ? TextButton(
                                  onPressed: () async {
                                    try {
                                      await FirebaseAuth.instance.currentUser!
                                          .sendEmailVerification();
                                    } catch (e) {
                                      print(e);
                                    }
                                    Future.delayed(Duration(seconds: 3))
                                        .whenComplete(() {
                                      setState(() {
                                        _isVerified = false;
                                      });
                                    });
                                  },
                                  child: Text(
                                    'Resend Email Verified',
                                    style: TextStyle(color: Colors.red),
                                  ))
                              : Container(),
                        ],
                      ),
                      HaveAccount(
                        haveAccount: 'Don\'t have an account ?',
                        actionLabel: 'Sign Up',
                        press: () {
                          Navigator.pushReplacementNamed(
                              context, '/admin_signup');
                        },
                      ),
                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.purple,
                            ))
                          : AuthButton(
                              label: 'Log In',
                              press: () {
                                _logIn();
                              },
                            ),
                      divider(),
                      googleLogInButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            width: 80,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            '  Or  ',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            width: 80,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget googleLogInButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 50, 50, 20),
      child: Material(
        elevation: 3,
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
        child: MaterialButton(
          onPressed: () {
            signInWithGoogle();
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                ),
                Text(
                  'Sign In With Google',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                )
              ]),
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'Username',
  hintText: 'Enter username',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
  ),
);

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^([a-zA-Z0-9]+)([\-\_\.]*)([a-zA-Z0-9]*)([@])([a-zA-Z0-9]{2,})([\.][a-zA-Z]{2,3})$')
        .hasMatch(this);
  }
}
