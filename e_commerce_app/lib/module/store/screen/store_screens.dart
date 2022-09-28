import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/module/store/widget/store_details.dart';
import 'package:flutter/material.dart';

class StoreScreens extends StatelessWidget {
  const StoreScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Stores',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('admin').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 25,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoreDetails(
                                      adminId: snapshot.data!.docs[index]
                                          ['aid'],
                                    )));
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: Image.asset(
                                    'assets/images/inapp/store.jpg'),
                              ),
                              Positioned(
                                  bottom: 28,
                                  left: 10,
                                  child: SizedBox(
                                    child: Image.network(
                                      snapshot.data!.docs[index]['adminimage'],
                                      fit: BoxFit.cover,
                                    ),
                                    height: 40,
                                    width: 100,
                                  )),
                            ],
                          ),
                          Text(
                            snapshot.data!.docs[index]['adminname'],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  });
            }
            return Center(
              child: Text('No Stores'),
            );
          },
        ),
      ),
    );
  }
}
