// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../../../common/widget/appbar_back_button.dart';
import '../../../common/widget/appbar_title.dart';
import '../../../common/widget/message_handler.dart';
import '../../../common/widget/yellow_button.dart';
import '../../../repository/auth_repo.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  bool checkOldPasswordValidation = true;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const AppBarTitle(title: 'Change Password'),
            leading: const AppBarBackButton()),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 30),
              child: Form(
                key: formKey,
                child: Container(
                  height: 600,
                  child: Column(children: [
                    const Text(
                      'to Change your password  please fill in the form below  and click Save Changes',
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.1,
                          color: Colors.blueGrey,
                          fontFamily: 'Acme',
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your password';
                          }
                          return null;
                        },
                        controller: oldPasswordController,
                        decoration: passwordFormDecoration.copyWith(
                          labelText: 'Old Password',
                          hintText: 'Enter your Current Password',
                          errorText: checkOldPasswordValidation != true
                              ? 'not valid password'
                              : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter new password';
                          }
                          return null;
                        },
                        controller: newPasswordController,
                        decoration: passwordFormDecoration.copyWith(
                          labelText: 'New Password',
                          hintText: 'Enter your New Password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value != newPasswordController.text) {
                            return 'Password Not Maching';
                          } else if (value!.isEmpty) {
                            return 'Re-Enter New password';
                          }
                          return null;
                        },
                        decoration: passwordFormDecoration.copyWith(
                          labelText: 'Repeat Password',
                          hintText: 'Re-Enter your New Password',
                        ),
                      ),
                    ),
                    FlutterPwValidator(
                      controller: newPasswordController,
                      minLength: 8,
                      uppercaseCharCount: 1,
                      numericCharCount: 2,
                      specialCharCount: 1,
                      width: 400,
                      height: 150,
                      onSuccess: () {},
                      onFail: () {},
                    ),
                    Spacer(),
                    YellowButton(
                        size: MediaQuery.of(context).size,
                        label: 'Save Changes',
                        press: () async {
                          if (formKey.currentState!.validate()) {
                            checkOldPasswordValidation =
                                await AuthRepo.checkPassword(
                                    FirebaseAuth.instance.currentUser!.email!,
                                    oldPasswordController.text);
                            setState(() {});
                            checkOldPasswordValidation == true
                                ? await AuthRepo.updateUserPass(
                                        newPasswordController.text.trim())
                                    .whenComplete(() {
                                    formKey.currentState!.reset();
                                    newPasswordController.clear();
                                    oldPasswordController.clear();
                                    MessageHandler.showSnackBar(scaffoldKey,
                                        'Your password has been updated');
                                    Future.delayed(Duration(seconds: 3))
                                        .whenComplete(
                                            () => Navigator.pop(context));
                                  })
                                : print('not valid old password');
                            print('form valid');
                          } else {
                            print('form not valid');
                          }
                        },
                        width: 0.7),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

var passwordFormDecoration = InputDecoration(
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
