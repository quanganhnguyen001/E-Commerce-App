import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:e_commerce_app/common/widget/alert_dialog.dart';
import 'package:e_commerce_app/common/widget/appbar_back_button.dart';
import 'package:e_commerce_app/common/widget/appbar_title.dart';
import 'package:e_commerce_app/common/widget/message_handler.dart';
import 'package:e_commerce_app/common/widget/yellow_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late String firstName;
  late String lastName;
  late String phone;
  String countryValue = 'Choose Country';
  String stateValue = 'Choose State';
  String cityValue = 'Choose City';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: AppBarTitle(title: 'Address'),
          leading: AppBarBackButton(),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 40, 30, 40),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            width: size.width * 0.5,
                            child: TextFormField(
                              onSaved: (value) {
                                firstName = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Pls enter first name';
                                }
                                return null;
                              },
                              decoration: textFormDecoration.copyWith(
                                  labelText: 'First Name',
                                  hintText: 'Enter your first name'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            width: size.width * 0.5,
                            child: TextFormField(
                              onSaved: (value) {
                                lastName = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Pls enter last name';
                                }
                                return null;
                              },
                              decoration: textFormDecoration.copyWith(
                                  labelText: 'Last Name',
                                  hintText: 'Enter your last name'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            width: size.width * 0.5,
                            child: TextFormField(
                              onSaved: (value) {
                                phone = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Pls enter phone num';
                                }
                                return null;
                              },
                              decoration: textFormDecoration.copyWith(
                                  labelText: 'Phone',
                                  hintText: 'Enter your phone'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SelectState(
                    // style: TextStyle(color: Colors.red),
                    onCountryChanged: (value) {
                      setState(() {
                        countryValue = value;
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        stateValue = value;
                      });
                    },
                    onCityChanged: (value) {
                      setState(() {
                        cityValue = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: YellowButton(
                          size: size,
                          label: 'Add new Address',
                          press: () async {
                            if (_formKey.currentState!.validate()) {
                              if (countryValue != 'Choose Country' &&
                                  stateValue != 'Choose State' &&
                                  cityValue != 'Choose City') {
                                _formKey.currentState!.save();
                                CollectionReference addressRef =
                                    FirebaseFirestore.instance
                                        .collection('customers')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection('address');
                                var addressId = Uuid().v4();
                                await addressRef.doc(addressId).set({
                                  'address': addressId,
                                  'firstname': firstName,
                                  'lastname': lastName,
                                  'phone': phone,
                                  'country': countryValue,
                                  'state': stateValue,
                                  'city': cityValue,
                                }).whenComplete(() => Navigator.pop(context));
                              } else {
                                MessageHandler.showSnackBar(
                                    _scaffoldKey, 'Pls set your Location');
                              }
                            } else {
                              MessageHandler.showSnackBar(
                                  _scaffoldKey, 'Pls fill all fields');
                            }
                          },
                          width: 0.8),
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
}

var textFormDecoration = InputDecoration(
  labelText: 'Username',
  hintText: 'Enter username',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
  ),
);
