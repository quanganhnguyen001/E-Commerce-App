import 'dart:io';

import 'package:e_commerce_app/common/widget/appbar_back_button.dart';
import 'package:e_commerce_app/common/widget/appbar_title.dart';
import 'package:e_commerce_app/common/widget/yellow_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditStore extends StatefulWidget {
  const EditStore({Key? key, required this.data}) : super(key: key);
  final dynamic data;

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: AppBarTitle(title: 'Edit Store'),
        leading: AppBarBackButton(),
      ),
      body: SingleChildScrollView(
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
                      backgroundImage: NetworkImage(widget.data['adminimage']),
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
                      backgroundImage: NetworkImage(widget.data['coverimage']),
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
                initialValue: widget.data['adminname'],
                decoration: textFormDecoration.copyWith(
                    labelText: 'Store name', hintText: 'Enter Store name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.data['phone'],
                decoration: textFormDecoration.copyWith(
                    labelText: 'Phone', hintText: 'Enter Phone number'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  YellowButton(
                      size: size,
                      label: 'Save Changes',
                      press: () {
                        Navigator.pop(context);
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
