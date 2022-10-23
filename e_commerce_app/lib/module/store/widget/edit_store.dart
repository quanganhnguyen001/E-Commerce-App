import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widget/alert_dialog.dart';
import 'package:e_commerce_app/common/widget/appbar_back_button.dart';
import 'package:e_commerce_app/common/widget/appbar_title.dart';
import 'package:e_commerce_app/common/widget/message_handler.dart';
import 'package:e_commerce_app/common/widget/yellow_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditStore extends StatefulWidget {
  const EditStore({Key? key, required this.data}) : super(key: key);
  final dynamic data;

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late String storeName;
  late String storeNumber;
  late String storeLogo;
  late String coverImage;
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFileLogo;
  XFile? _imageFileCover;
  dynamic _pickimageError;

  _pickStoreLogo() async {
    try {
      final pickedStoreLogo = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFileLogo = pickedStoreLogo;
      });
    } catch (error) {
      setState(() {
        _pickimageError = error;
      });
    }
  }

  _pickCoverImage() async {
    try {
      final pickedCoverImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFileCover = pickedCoverImage;
      });
    } catch (error) {
      setState(() {
        _pickimageError = error;
      });
    }
  }

  Future uploadStoreLogo() async {
    if (_imageFileLogo != null) {
      try {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('admin-image/${widget.data['email']}.jpg');

        await ref.putFile(File(_imageFileLogo!.path));

        storeLogo = await ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      storeLogo = widget.data['adminimage'];
    }
  }

  Future uploadCoverImage() async {
    if (_imageFileCover != null) {
      try {
        firebase_storage.Reference ref2 = firebase_storage
            .FirebaseStorage.instance
            .ref('admin-image/${widget.data['email']}.jpg-cover');

        await ref2.putFile(File(_imageFileCover!.path));

        coverImage = await ref2.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      coverImage = widget.data['coverimage'];
    }
  }

  saveChanges() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      await uploadStoreLogo().whenComplete(
          () async => await uploadCoverImage().whenComplete(() => editStore()));
    } else {
      MessageHandler.showSnackBar(_scaffoldKey, 'Pls fill all fileds');
    }
  }

  editStore() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('admin')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      transaction.update(documentReference, {
        'adminname': storeName,
        'phone': storeNumber,
        'adminimage': storeLogo,
        'coverimage': coverImage,
      });
    }).whenComplete(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: AppBarTitle(title: 'Edit Store'),
          leading: AppBarBackButton(),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Store Logo',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(widget.data['adminimage']),
                        ),
                        Column(
                          children: [
                            YellowButton(
                                size: size,
                                label: 'Change',
                                press: () {
                                  _pickStoreLogo();
                                },
                                width: 0.25),
                            SizedBox(
                              height: 15,
                            ),
                            _imageFileLogo == null
                                ? SizedBox()
                                : YellowButton(
                                    size: size,
                                    label: 'Reset',
                                    press: () {
                                      setState(() {
                                        _imageFileLogo = null;
                                      });
                                    },
                                    width: 0.25),
                          ],
                        ),
                        _imageFileLogo == null
                            ? SizedBox()
                            : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 60,
                                backgroundImage:
                                    FileImage(File(_imageFileLogo!.path)),
                              ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Divider(
                        color: Colors.yellow,
                        thickness: 2.5,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Cover Image',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(widget.data['coverimage']),
                        ),
                        Column(
                          children: [
                            YellowButton(
                                size: size,
                                label: 'Change',
                                press: () {
                                  _pickCoverImage();
                                },
                                width: 0.25),
                            SizedBox(
                              height: 15,
                            ),
                            _imageFileCover == null
                                ? SizedBox()
                                : YellowButton(
                                    size: size,
                                    label: 'Reset',
                                    press: () {
                                      setState(() {
                                        _imageFileCover = null;
                                      });
                                    },
                                    width: 0.25),
                          ],
                        ),
                        _imageFileCover == null
                            ? SizedBox()
                            : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 60,
                                backgroundImage:
                                    FileImage(File(_imageFileCover!.path)),
                              ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Divider(
                        color: Colors.yellow,
                        thickness: 2.5,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pls Enter your store name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      storeName = value!;
                    },
                    initialValue: widget.data['adminname'],
                    decoration: textFormDecoration.copyWith(
                        labelText: 'Store name', hintText: 'Enter Store name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pls Enter your phone number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      storeNumber = value!;
                    },
                    initialValue: widget.data['phone'],
                    decoration: textFormDecoration.copyWith(
                        labelText: 'Phone', hintText: 'Enter Phone number'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      isLoading
                          ? YellowButton(
                              size: size,
                              label: 'Pls wait ...',
                              press: () {
                                null;
                              },
                              width: 0.5)
                          : YellowButton(
                              size: size,
                              label: 'Save Changes',
                              press: () {
                                saveChanges();
                              },
                              width: 0.5),
                      YellowButton(
                          size: size,
                          label: 'Cancel',
                          press: () {
                            Navigator.pop(context);
                          },
                          width: 0.25),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'Price',
  hintText: 'price ...\$',
  labelStyle: TextStyle(color: Colors.purple),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 1),
    borderRadius: BorderRadius.circular(25),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(25),
  ),
);
