import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class PreparingOrder extends StatelessWidget {
  const PreparingOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('deliverystatus', isEqualTo: 'preparing')
          .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                          color: Colors.orange.withOpacity(0.2),
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
                              Row(
                                children: [
                                  Text(
                                    'Order Date: ',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    (DateFormat('yyyy-MM-dd')
                                        .format(order['orderdate'].toDate())
                                        .toString()),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.green),
                                  ),
                                ],
                              ),
                              order['deliverystatus'] == 'delivered'
                                  ? Text('This order has already delivered')
                                  : Row(
                                      children: [
                                        Text(
                                          'Change Delivery Status To: ',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        order['deliverystatus'] == 'preparing'
                                            ? TextButton(
                                                onPressed: () {
                                                  DatePicker.showDatePicker(
                                                      context,
                                                      minTime: DateTime.now(),
                                                      maxTime: DateTime.now()
                                                          .add(Duration(
                                                              days: 365)),
                                                      onConfirm: (date) async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('orders')
                                                        .doc(order['orderid'])
                                                        .update({
                                                      'deliverystatus':
                                                          'shipping',
                                                      'deliverydate': date,
                                                    });
                                                  });
                                                },
                                                child: Text('shipping ?'))
                                            : TextButton(
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('orders')
                                                      .doc(order['orderid'])
                                                      .update({
                                                    'deliverystatus':
                                                        'delivered'
                                                  });
                                                },
                                                child: Text('delivered ?')),
                                      ],
                                    ),
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
    );
  }
}
