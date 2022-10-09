import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/appbar_back_button.dart';
import '../../../common/widget/appbar_title.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: AppBarTitle(
          title: 'Orders',
        ),
        leading: AppBarBackButton(),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('cid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'You have not \n\n any Orders !',
                textAlign: TextAlign.center,
                style: (TextStyle(
                    fontSize: 26,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var order = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ExpansionTile(
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'See More',
                            style: TextStyle(color: Colors.blue),
                          ),
                          Text(
                            order['deliverystatus'],
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      title: Container(
                        constraints: BoxConstraints(maxHeight: 80),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxHeight: 80,
                                  maxWidth: 80,
                                ),
                                child: Image.network(order['orderimage']),
                              ),
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order['ordername'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ('\$') +
                                            (order['orderprice']
                                                .toStringAsFixed(2)),
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(('x ') +
                                          (order['orderquantitycart']
                                              .toString())),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      children: [
                        Container(
                          width: double.infinity,
                          // height: 200,
                          decoration: BoxDecoration(
                            color: order['deliverystatus'] == 'delivered'
                                ? Colors.brown.withOpacity(0.2)
                                : Colors.orange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name: ' + (order['customername']),
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'Phone: ' + (order['phone']),
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'Email: ' + (order['email']),
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'Address: ' + (order['address']),
                                  style: TextStyle(fontSize: 15),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Payment Status: ',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      (order['paymentstatus']),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.purple),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Delivery Status: ',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      (order['deliverystatus']),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.green),
                                    ),
                                  ],
                                ),
                                order['deliverystatus'] == 'shipping'
                                    ? Text(
                                        ('Estimated Delivery Date: ') +
                                            (order['deliverydate']),
                                        style: TextStyle(fontSize: 15),
                                      )
                                    : Text(''),
                                order['deliverystatus'] == 'delivered' &&
                                        order['orderreview'] == false
                                    ? TextButton(
                                        onPressed: () {},
                                        child: Text('Write Review'))
                                    : Text(''),
                                order['deliverystatus'] == 'delivered' &&
                                        order['orderreview'] == true
                                    ? Row(
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            'Review Added',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue),
                                          ),
                                        ],
                                      )
                                    : Text(''),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
