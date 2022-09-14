import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MenGallery extends StatefulWidget {
  const MenGallery({Key? key}) : super(key: key);

  @override
  State<MenGallery> createState() => _MenGalleryState();
}

class _MenGalleryState extends State<MenGallery> {
  final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              leading: Image(
                image: NetworkImage(data['prodimages'][0]),
              ),
              title: Text(data['prodname']),
              subtitle: Text(data['price'].toString()),
            );
          }).toList(),
        );
      },
    );
  }
}
