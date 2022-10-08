import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widget/appbar_back_button.dart';
import 'package:e_commerce_app/common/widget/appbar_title.dart';
import 'package:e_commerce_app/common/widget/yellow_button.dart';
import 'package:e_commerce_app/module/payment/screens/payment_screens.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreens extends StatefulWidget {
  const OrderScreens({Key? key}) : super(key: key);

  @override
  State<OrderScreens> createState() => _OrderScreensState();
}

class _OrderScreensState extends State<OrderScreens> {
  CollectionReference users =
      FirebaseFirestore.instance.collection('customers');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
        future: users
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(), // use widget. to pass data statefull class to state object class
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Material(child: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Material(
              color: Colors.grey.shade200,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.grey.shade200,
                  appBar: AppBar(
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.grey.shade200,
                    leading: AppBarBackButton(),
                    title: AppBarTitle(title: 'Place Order'),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Name: ${data['name']}'),
                                Text('Phone: ${data['phone']}'),
                                Text('Address: ${data['address']}'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child:
                                Consumer<Cart>(builder: (context, cart, child) {
                              return ListView.builder(
                                  itemCount: cart.count,
                                  itemBuilder: (context, index) {
                                    final order = cart.getItems[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(width: 0.3)),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15)),
                                              child: SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Image.network(
                                                    order.imagesUrl.first),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    order.name,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors
                                                            .grey.shade600),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 4,
                                                        horizontal: 12),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          ('${order.price.toStringAsFixed(2)} \$'),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        Text(
                                                          'x ${order.quantitycart.toString()}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomSheet: Container(
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: YellowButton(
                        label:
                            'Confirm  ${context.watch<Cart>().totalPrice.toStringAsFixed(2)} \$',
                        width: 1,
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentScreens()));
                        },
                        size: size,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
