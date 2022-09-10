import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/module/auth/widget/message_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../widget/auth_button.dart';
import '../../widget/auth_header.dart';
import '../../widget/have_account.dart';

class CustomerSignup extends StatefulWidget {
  const CustomerSignup({Key? key}) : super(key: key);

  @override
  State<CustomerSignup> createState() => _CustomerSignupState();
}

class _CustomerSignupState extends State<CustomerSignup> {
  bool isVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late String name;
  late String email;
  late String password;
  late String profileImage;
  late String _uid;
  bool _isLoading = false;

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  void _pickImageCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (error) {
      rethrow;
    }
  }

  void _pickImageGalerry() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (error) {
      rethrow;
    }
  }

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);

          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref('customer-image/$email.jpg');

          await ref.putFile(File(_imageFile!.path));

          profileImage = await ref.getDownloadURL();
          _uid = FirebaseAuth.instance.currentUser!.uid;
          await customers.doc(_uid).set({
            'name': name,
            'email': email,
            'profileImage': profileImage,
            'phone': '',
            'address': '',
            'cid': _uid,
          });
          _formKey.currentState!.reset();
          setState(() {
            _imageFile = null;
          });

          Navigator.pushReplacementNamed(context, '/customer_login');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            setState(() {
              _isLoading = false;
            });
            MessageHandler.showSnackBar(
                _scaffoldKey, 'The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            setState(() {
              _isLoading = false;
            });
            MessageHandler.showSnackBar(
                _scaffoldKey, 'The account already exists for that email.');
          }
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        MessageHandler.showSnackBar(_scaffoldKey, 'Pls pick an image');
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
                              backgroundImage: _imageFile == null
                                  ? null
                                  : FileImage(File(_imageFile!.path)),
                              radius: 60,
                              backgroundColor: Colors.purpleAccent,
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _pickImageCamera();
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.purple,
                                  size: 40,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _pickImageGalerry();
                                },
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
                          onChanged: (value) {
                            name = value;
                          },
                          // controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Pls enter your name';
                            }
                            return null;
                          },
                          decoration: textFormDecoration.copyWith(
                              labelText: 'Username',
                              hintText: 'Enter your name'),
                        ),
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
                      HaveAccount(
                        haveAccount: 'Already have an account ?',
                        actionLabel: 'Login',
                        press: () {
                          Navigator.pushReplacementNamed(
                              context, '/customer_login');
                        },
                      ),
                      _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.purple,
                            )
                          : AuthButton(
                              label: 'Sign Up',
                              press: () {
                                _signUp();
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
