import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widget/message_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  bool isVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late String email;
  late String password;
  bool _isLoading = false;

  void _logIn() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        _formKey.currentState!.reset();

        Navigator.pushReplacementNamed(context, '/admin_screens');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            _isLoading = false;
          });
          MessageHandler.showSnackBar(
              _scaffoldKey, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          setState(() {
            _isLoading = false;
          });
          MessageHandler.showSnackBar(
              _scaffoldKey, 'Wrong password provided for that user.');
        }
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
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forget Password ?',
                            style: TextStyle(
                                fontSize: 18, fontStyle: FontStyle.italic),
                          )),
                      HaveAccount(
                        haveAccount: 'Don\'t have an account ?',
                        actionLabel: 'Sign Up',
                        press: () {
                          Navigator.pushReplacementNamed(
                              context, '/customer_signup');
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
