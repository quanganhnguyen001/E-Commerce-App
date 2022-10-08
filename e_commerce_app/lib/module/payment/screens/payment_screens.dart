import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widget/appbar_back_button.dart';
import 'package:e_commerce_app/common/widget/appbar_title.dart';
import 'package:e_commerce_app/common/widget/yellow_button.dart';
import 'package:e_commerce_app/module/payment/screens/payment_screens.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

class PaymentScreens extends StatefulWidget {
  const PaymentScreens({Key? key}) : super(key: key);

  @override
  State<PaymentScreens> createState() => _OrderScreensState();
}

class _OrderScreensState extends State<PaymentScreens> {
  late String orderId;
  int selectedValue = 1;
  CollectionReference users =
      FirebaseFirestore.instance.collection('customers');

  void showProgress() {
    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(
        max: 100, msg: 'pls wait ...', progressBgColor: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    double totalprice = context.watch<Cart>().totalPrice;
    double totalpaid = context.watch<Cart>().totalPrice + 10.0;
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
                    title: AppBarTitle(title: 'Payment'),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 120,
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      totalpaid.toStringAsFixed(2) + '\$',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total order',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                    Text(
                                      totalprice.toStringAsFixed(2) + '\$',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Shipping Cost',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                    Text(
                                      '10.00 \$',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ],
                                ),
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
                            child: Column(
                              children: [
                                RadioListTile(
                                    title: Text('Cash On Delivery'),
                                    subtitle: Text('Pay at Home'),
                                    value: 1,
                                    groupValue: selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedValue = value!;
                                      });
                                    }),
                                RadioListTile(
                                    title: Text('Pay via visa / Master Card'),
                                    subtitle: Row(
                                      children: [
                                        Icon(
                                          Icons.payment,
                                          color: Colors.blue,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Icon(
                                            FontAwesomeIcons.ccMastercard,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        Icon(
                                          FontAwesomeIcons.ccVisa,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                    value: 2,
                                    groupValue: selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedValue = value!;
                                      });
                                    }),
                                RadioListTile(
                                    title: Text('Pay via Paypal'),
                                    subtitle: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.ccPaypal,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                    value: 3,
                                    groupValue: selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedValue = value!;
                                      });
                                    }),
                              ],
                            ),
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
                          if (selectedValue == 1) {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => SizedBox(
                                      height: size.height * 0.3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 100),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Pay At Home ${totalpaid.toStringAsFixed(2)} \$',
                                              style: TextStyle(fontSize: 24),
                                            ),
                                            YellowButton(
                                                size: size,
                                                label:
                                                    'Confirm ${totalpaid.toStringAsFixed(2)} \$',
                                                press: () async {
                                                  showProgress();
                                                  for (var item in context
                                                      .read<Cart>()
                                                      .getItems) {
                                                    CollectionReference
                                                        orderRef =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'orders');
                                                    orderId = Uuid().v4();
                                                    await orderRef
                                                        .doc(orderId)
                                                        .set({
                                                      'cid': data['cid'],
                                                      'customername':
                                                          data['name'],
                                                      'email': data['email'],
                                                      'address':
                                                          data['address'],
                                                      'phone': data['phone'],
                                                      'profileimage':
                                                          data['profileImage'],
                                                      'sid': item.suppId,
                                                      'proid': item.documentId,
                                                      'orderid': orderId,
                                                      'orderimage':
                                                          item.imagesUrl.first,
                                                      'orderquantitycart':
                                                          item.quantitycart,
                                                      'orderprice': item.price *
                                                          item.quantitycart,
                                                      'deliverystatus':
                                                          'preparing',
                                                      'deliverydate': '',
                                                      'orderdate':
                                                          DateTime.now(),
                                                      'paymentstatus':
                                                          'cash on delivery',
                                                      'orderreview': false,
                                                    }).whenComplete(() async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .runTransaction(
                                                              (transaction) async {
                                                        DocumentReference
                                                            documentReference =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'products')
                                                                .doc(item
                                                                    .documentId);
                                                        DocumentSnapshot
                                                            snapshot2 =
                                                            await transaction.get(
                                                                documentReference);
                                                        transaction.update(
                                                            documentReference, {
                                                          'quantity': snapshot2[
                                                                  'quantity'] -
                                                              item.quantitycart
                                                        });
                                                      });
                                                    });
                                                  }
                                                  context
                                                      .read<Cart>()
                                                      .clearCart();
                                                  Navigator.popUntil(
                                                      context,
                                                      ModalRoute.withName(
                                                          '/customer_screens'));
                                                },
                                                width: 0.9),
                                          ],
                                        ),
                                      ),
                                    ));
                          } else if (selectedValue == 2) {
                            print('2');
                          } else if (selectedValue == 3) {
                            print('3');
                          }
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
