import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widget/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../widget/product_model.dart';

class ShoesGallery extends StatefulWidget {
  const ShoesGallery({Key? key, this.fromOnboard = false}) : super(key: key);
  final bool fromOnboard;

  @override
  State<ShoesGallery> createState() => _ShoesGalleryState();
}

class _ShoesGalleryState extends State<ShoesGallery> {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincateg', isEqualTo: 'men')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.fromOnboard == true
          ? AppBar(
              title: AppBarTitle(
                title: 'Shoes',
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.black,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/customer_screens');
                },
              ),
            )
          : null,
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
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
                'This category \n\n has no item yet',
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
                staggeredTileBuilder: (context) => StaggeredTile.fit(1)),
          );
        },
      ),
    );
  }
}
