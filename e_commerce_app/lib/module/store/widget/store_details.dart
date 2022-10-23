import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widget/appbar_back_button.dart';
import 'package:e_commerce_app/common/widget/orange_back_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../gallery/widget/product_model.dart';
import 'edit_store.dart';

class StoreDetails extends StatefulWidget {
  const StoreDetails({Key? key, required this.adminId}) : super(key: key);
  final String adminId;

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  bool isFollow = false;
  @override
  Widget build(BuildContext context) {
    CollectionReference admin = FirebaseFirestore.instance.collection('admin');
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('sid', isEqualTo: widget.adminId)
        .snapshots();
    return FutureBuilder<DocumentSnapshot>(
      future: admin.doc(widget.adminId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Material(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Colors.blueGrey.shade100,
            appBar: AppBar(
              leading: OrangeBackButton(),
              title: Row(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        data['adminimage'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.orange),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          data['adminname'],
                          style: TextStyle(fontSize: 20, color: Colors.orange),
                        ),
                        data['aid'] == FirebaseAuth.instance.currentUser!.uid
                            ? Container(
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditStore(
                                                  data: data,
                                                )));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('Edit'),
                                      Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.orange,
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                              )
                            : Container(
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      isFollow = !isFollow;
                                    });
                                  },
                                  child: isFollow
                                      ? Text(
                                          'Following',
                                          style: TextStyle(fontSize: 16),
                                        )
                                      : Text(
                                          'Follow',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                ),
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.orange,
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
              toolbarHeight: 100,
              flexibleSpace: data['coverimage'] == ''
                  ? Image.asset(
                      'assets/images/inapp/coverimage.jpg',
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      data['coverimage'],
                      fit: BoxFit.cover,
                    ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: _productsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        'This stores \n\n has no item yet',
                        textAlign: TextAlign.center,
                        style: (TextStyle(
                            fontSize: 26,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold)),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    child: StaggeredGridView.countBuilder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        crossAxisCount: 2,
                        itemBuilder: (context, index) {
                          return ProductModel(
                            products: snapshot.data!.docs[index],
                          );
                        },
                        staggeredTileBuilder: (context) =>
                            StaggeredTile.fit(1)),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {},
            ),
          );
        }

        return Center(
            child: CircularProgressIndicator(
          color: Colors.purple,
        ));
      },
    );
  }
}
