import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widget/message_handler.dart';
import 'package:e_commerce_app/common/widget/yellow_button.dart';
import 'package:e_commerce_app/model/category_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key, required this.items}) : super(key: key);
  final dynamic items;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late double price;
  late int quantity;
  late String productName;
  late String productDescription;
  late String prodId;
  int? discount = 0;
  String _mainCategoryValue = 'select category';
  String _subCategoryValue = 'subcategory';
  List<String> _subCategoryList = [];
  bool isLoading = false;

  void _selectedMainCateg(value) {
    if (value == 'select category') {
      _subCategoryList = [];
    } else if (value == 'men') {
      _subCategoryList = men;
    } else if (value == 'women') {
      _subCategoryList = women;
    } else if (value == 'electronics') {
      _subCategoryList = electronics;
    } else if (value == 'accessories') {
      _subCategoryList = accessories;
    } else if (value == 'shoes') {
      _subCategoryList = shoes;
    } else if (value == 'home & garden') {
      _subCategoryList = homeandgarden;
    } else if (value == 'beauty') {
      _subCategoryList = beauty;
    } else if (value == 'kids') {
      _subCategoryList = kids;
    } else if (value == 'bags') {
      _subCategoryList = bags;
    }
    setState(() {
      _mainCategoryValue = value.toString();
      _subCategoryValue = 'subcategory';
    });
  }

  List<XFile> _imagesList = [];
  List<String> _imagesUrlList = [];
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

  Future<void> uploadImages() async {
    if (_mainCategoryValue != 'select category' &&
        _subCategoryValue != 'subcategory') {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (_imagesList.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          try {
            for (var images in _imagesList) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${path.basename(images.path)}');

              await ref.putFile(File(images.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  _imagesUrlList.add(value);
                });
              });
            }
          } catch (e) {
            print(e);
          }
        } else {
          MessageHandler.showSnackBar(
              _scaffoldKey, 'Pls pick some images first');
        }
      } else {
        MessageHandler.showSnackBar(_scaffoldKey, 'Pls fill all fileds');
      }
    } else {
      MessageHandler.showSnackBar(_scaffoldKey, 'Pls select categories');
    }
  }

  void uploadData() async {
    if (_imagesUrlList.isNotEmpty) {
      CollectionReference productRef =
          FirebaseFirestore.instance.collection('products');
      prodId = Uuid().v4(); // generate random id
      await productRef.doc(prodId).set({
        'maincateg': _mainCategoryValue,
        'subcateory': _subCategoryValue,
        'price': price,
        'quantity': quantity,
        'prodname': productName,
        'proddescrip': productDescription,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'prodimages': _imagesUrlList,
        'discount': discount,
        'proid': prodId,
      }).whenComplete(() {
        setState(() {
          isLoading = false;
          _imagesList = [];
          _mainCategoryValue = 'select category';
          // _subCategoryValue = 'subcategory';
          _subCategoryList = [];
          _imagesUrlList = [];
        });
        _formKey.currentState!.reset();
      });
    } else {}
  }

  void uploadProduct() async {
    await uploadImages().whenComplete(() {
      return uploadData();
    });
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
                          child: _previewCurrentImage()),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          Text(
                            'Main Category',
                            style: TextStyle(color: Colors.red),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            margin: EdgeInsets.all(6),
                            constraints:
                                BoxConstraints(minWidth: size.width * 0.3),
                            child: Text(
                              widget.items['maincateg'],
                              textAlign: TextAlign.center,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'subcategory',
                            style: TextStyle(color: Colors.red),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            margin: EdgeInsets.all(6),
                            constraints:
                                BoxConstraints(minWidth: size.width * 0.3),
                            child: Text(
                              widget.items['subcateory'],
                              textAlign: TextAlign.center,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          Text(
                            '* Select Main Category',
                            style: TextStyle(color: Colors.red),
                          ),
                          DropdownButton(
                              iconSize: 40,
                              iconEnabledColor: Colors.red,
                              dropdownColor: Colors.orange,
                              value: _mainCategoryValue,
                              items: maincateg
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                _selectedMainCateg(value);
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Select subcategory',
                            style: TextStyle(color: Colors.red),
                          ),
                          DropdownButton(
                              iconSize: 40,
                              iconEnabledColor: Colors.red,
                              iconDisabledColor: Colors.black,
                              menuMaxHeight: 500,
                              dropdownColor: Colors.orange,
                              disabledHint: Text('select category'),
                              value: _subCategoryValue,
                              items: _subCategoryList
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _subCategoryValue = value.toString();
                                });
                              }),
                        ],
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
                  Row(
                    children: [
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
                          width: size.width * 0.4,
                          child: TextFormField(
                            maxLength: 2,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              } else if (value.isValidDiscount() != true) {
                                return 'Invalid discount';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              discount = int.parse(value!);
                            },
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: textFormDecoration.copyWith(
                              labelText: 'Discount',
                              hintText: 'discount ...\%',
                            ),
                          ),
                        ),
                      ),
                    ],
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        YellowButton(
                            size: size,
                            label: 'Cancel',
                            press: () {
                              Navigator.pop(context);
                            },
                            width: 0.25),
                        YellowButton(
                            size: size,
                            label: 'Save Changes',
                            press: () {
                              Navigator.pop(context);
                            },
                            width: 0.5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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

  Widget _previewCurrentImage() {
    List<dynamic> itemImages = widget.items['prodimages'];
    return ListView.builder(
        itemCount: itemImages.length,
        itemBuilder: (context, index) {
          return Image.network(itemImages[index].toString());
        });
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

extension DiscountValidator on String {
  bool isValidDiscount() {
    return RegExp(r'^([0-9]*)$').hasMatch(this);
  }
}
