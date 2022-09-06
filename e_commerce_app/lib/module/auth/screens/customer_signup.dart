import 'package:flutter/material.dart';

import '../widget/auth_button.dart';
import '../widget/auth_header.dart';
import '../widget/have_account.dart';

class CustomerSignup extends StatefulWidget {
  const CustomerSignup({Key? key}) : super(key: key);

  @override
  State<CustomerSignup> createState() => _CustomerSignupState();
}

class _CustomerSignupState extends State<CustomerSignup> {
  bool isVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  children: [
                    AuthHeader(
                      title: 'Sign Up',
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.purpleAccent,
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.purple,
                                size: 40,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.photo,
                                color: Colors.purple,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pls enter your name';
                          }
                          return null;
                        },
                        decoration: textFormDecoration.copyWith(
                            labelText: 'Username', hintText: 'Enter your name'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pls enter your email';
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pls enter your password';
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
                    HaveAccount(
                      haveAccount: 'Already have an account ?',
                      actionLabel: 'Login',
                      press: () {},
                    ),
                    AuthButton(
                      label: 'Sign Up',
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          print('valid');
                        } else {
                          print('not valid');
                        }
                      },
                    ),
                  ],
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
