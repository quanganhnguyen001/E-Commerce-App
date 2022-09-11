import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widget/message_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreens extends StatefulWidget {
  const UploadScreens({Key? key}) : super(key: key);

  @override
  State<UploadScreens> createState() => _UploadScreensState();
}

class _UploadScreensState extends State<UploadScreens> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late double price;
  late int quantity;
  late String productName;
  late String productDescription;

  void uploadProduct() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_imagesList.isNotEmpty) {
        setState(() {
          _imagesList = [];
        });
        _formKey.currentState!.reset();
      } else {
        MessageHandler.showSnackBar(_scaffoldKey, 'Pls pick some images first');
      }
    } else {
      MessageHandler.showSnackBar(_scaffoldKey, 'Pls fill all fileds');
    }
  }

  List<XFile> _imagesList = [];
  final ImagePicker _picker = ImagePicker();
  dynamic _pickedImageError;

  void _pickImageProduct() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);
      setState(() {
        _imagesList = pickedImages!;
      });
    } catch (error) {
      setState(() {
        _pickedImageError = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.grey.shade300,
                        height: size.width * 0.5,
                        width: size.width * 0.5,
                        child: _imagesList != null
                            ? _previewImage()
                            : Center(
                                child: Text(
                                'You have not \n \n picked images yet !',
                                textAlign: TextAlign.center,
                                style: (TextStyle(fontSize: 16)),
                              )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.orange,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: size.width * 0.4,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pls enter price';
                          } else if (value.isValidPrice() != true) {
                            return 'Invalid Price';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          price = double.parse(value!);
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Price',
                          hintText: 'price ...\$',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: size.width * 0.5,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pls enter quantity';
                          } else if (value.isValidQuantity() != true) {
                            return 'Not Valid Quantity';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          quantity = int.parse(value!);
                        },
                        keyboardType: TextInputType.number,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Quantity',
                          hintText: 'Add Quantity',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: size.width * 0.7,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pls enter product name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          productName = value!;
                        },
                        maxLength: 100,
                        maxLines: 3,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Product Name',
                          hintText: 'Enter Product Name',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: size.width * 0.9,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pls enter product description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          productDescription = value!;
                        },
                        maxLines: 5,
                        maxLength: 800,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Product Description',
                          hintText: 'Enter Product Description',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FloatingActionButton(
                onPressed: _imagesList.isEmpty
                    ? () {
                        _pickImageProduct();
                      }
                    : () {
                        setState(() {
                          _imagesList = [];
                        });
                      },
                backgroundColor: Colors.orange,
                child: _imagesList.isEmpty
                    ? Icon(
                        Icons.photo_library,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                uploadProduct();
              },
              backgroundColor: Colors.orange,
              child: Icon(
                Icons.upload,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewImage() {
    if (_imagesList.isNotEmpty) {
      return ListView.builder(
          itemCount: _imagesList.length,
          itemBuilder: (context, index) {
            return Image.file(File(_imagesList[index].path));
          });
    } else {
      return Center(
          child: Text(
        'You have not \n \n picked images yet !',
        textAlign: TextAlign.center,
        style: (TextStyle(fontSize: 16)),
      ));
    }
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

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}
