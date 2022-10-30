// import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerce_app/common/widget/appbar_back_button.dart';
// import 'package:e_commerce_app/common/widget/appbar_title.dart';
// import 'package:e_commerce_app/common/widget/yellow_button.dart';
// import 'package:e_commerce_app/module/profile/widget/add_address.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

// import '../../gallery/widget/product_model.dart';

// class AddressBook extends StatefulWidget {
//   const AddressBook({Key? key}) : super(key: key);

//   @override
//   State<AddressBook> createState() => _AddressBookState();
// }

// class _AddressBookState extends State<AddressBook> {
//   final Stream<QuerySnapshot> _addressStream = FirebaseFirestore.instance
//       .collection('customers')
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .collection('address')
//       .snapshots();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: AppBarBackButton(),
//         title: AppBarTitle(title: 'Address Book'),
//       ),
//       body: SafeArea(
//           child: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _addressStream,
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasError) {
//                   return Text('Something went wrong');
//                 }

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Material(
//                     child: Center(
//                       child: CircularProgressIndicator(
//                         color: Colors.purple,
//                       ),
//                     ),
//                   );
//                 }
//                 if (snapshot.data!.docs.isEmpty) {
//                   return Center(
//                     child: Text(
//                       'You don\'t have set \n\n address yet',
//                       textAlign: TextAlign.center,
//                       style: (TextStyle(
//                           fontSize: 26,
//                           color: Colors.blueGrey,
//                           fontWeight: FontWeight.bold)),
//                     ),
//                   );
//                 }

//                 return ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       var customer = snapshot.data!.docs[index];
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Card(
//                           color: Colors.grey,
//                           child: ListTile(
//                             title: SizedBox(
//                               height: 50,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                       '${customer['firstname']} - ${customer['lastname']}'),
//                                   Text(customer['phone']),
//                                 ],
//                               ),
//                             ),
//                             subtitle: SizedBox(
//                               height: 50,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                       'city/state: ${customer['city']} ${customer['state']}'),
//                                   Text('country: ${customer['country']}'),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     });
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//             child: YellowButton(
//                 size: MediaQuery.of(context).size,
//                 label: 'Add new address',
//                 press: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => AddAddress()));
//                 },
//                 width: 0.8),
//           ),
//         ],
//       )),
//     );
//   }
// }
