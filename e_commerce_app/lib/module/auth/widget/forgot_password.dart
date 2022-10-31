import 'package:e_commerce_app/common/widget/appbar_back_button.dart';
import 'package:e_commerce_app/common/widget/appbar_title.dart';
import 'package:e_commerce_app/common/widget/yellow_button.dart';
import 'package:e_commerce_app/repository/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          leading: const AppBarBackButton(),
          elevation: 0,
          backgroundColor: Colors.white,
          title: const AppBarTitle(
            title: 'Forgot Password ?',
          )),
      body: SafeArea(
          child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'to reset your password \n\n please Enter your email address \n and click on the button below',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'acme'),
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your email ';
                  } else if (!value.isValidEmailAddress()) {
                    return 'invalid email';
                  } else if (value.isValidEmailAddress()) {
                    return null;
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: emailFormDecoration.copyWith(
                  labelText: 'Email Address',
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(height: 80),
              YellowButton(
                  size: MediaQuery.of(context).size,
                  label: 'Send Reset Password',
                  press: () async {
                    if (formKey.currentState!.validate()) {
                      AuthRepo.sendResetPassword(emailController.text);
                    } else {
                      print('not valid');
                    }
                  },
                  width: 0.7),
            ],
          ),
        ),
      )),
    );
  }
}

var emailFormDecoration = InputDecoration(
  labelText: 'Full Name',
  hintText: 'Enter your full name',
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.purple, width: 1),
      borderRadius: BorderRadius.circular(6)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
      borderRadius: BorderRadius.circular(6)),
);

extension EmailValidator on String {
  bool isValidEmailAddress() {
    return RegExp(
            r'^([a-zA-Z0-9]+)([\-\_\.]*)([a-zA-Z0-9]*)([@])([a-zA-Z0-9]{2,})([\.][a-zA-Z]{2,3})$')
        .hasMatch(this);
  }
}
