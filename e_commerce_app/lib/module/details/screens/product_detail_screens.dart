import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widget/appbar_back_button.dart';
import 'package:e_commerce_app/common/widget/message_handler.dart';
import 'package:e_commerce_app/common/widget/yellow_button.dart';
import 'package:e_commerce_app/module/cart/screens/cart_screens.dart';
import 'package:e_commerce_app/module/details/screens/full_screens.dart';
import 'package:e_commerce_app/module/profile/widget/profile_headers.dart';
import 'package:e_commerce_app/module/store/widget/store_details.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/wish_provider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../gallery/widget/product_model.dart';
import 'package:collection/collection.dart';

class ProductDetailScreens extends StatefulWidget {
  const ProductDetailScreens({Key? key, required this.prodList})
      : super(key: key);
  final dynamic prodList;

  @override
  State<ProductDetailScreens> createState() => _ProductDetailScreensState();
}

class _ProductDetailScreensState extends State<ProductDetailScreens> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    final List<dynamic> imageList = widget.prodList['prodimages'];
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: widget.prodList['maincateg'])
        .where('subcateory', isEqualTo: widget.prodList['subcateory'])
        .snapshots();
    final Stream<QuerySnapshot> _reviewStream = FirebaseFirestore.instance
        .collection('products')
        .doc(widget.prodList['proid'])
        .collection('review')
        .snapshots();
    final Size size = MediaQuery.of(context).size;
    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullScreens(
                                    imageslist: imageList,
                                  )));
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: size.height * 0.45,
                          child: Swiper(
                              pagination: SwiperPagination(
                                  builder: SwiperPagination.fraction),
                              itemBuilder: (context, index) {
                                return Image(
                                    image: NetworkImage(imageList[index]));
                              },
                              itemCount: imageList.length),
                        ),
                        Positioned(
                            left: 15,
                            top: 20,
                            child: CircleAvatar(
                              backgroundColor: Colors.yellow,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )),
                        Positioned(
                            right: 15,
                            top: 20,
                            child: CircleAvatar(
                              backgroundColor: Colors.yellow,
                              child: IconButton(
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.black,
                                ),
                                onPressed: () {},
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 8, left: 8, top: 8, bottom: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.prodList['prodname'],
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '\$',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      widget.prodList['price']
                                          .toStringAsFixed(2),
                                      style: widget.prodList['discount'] != 0
                                          ? TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontWeight: FontWeight.w600)
                                          : TextStyle(
                                              color: Colors.red,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    widget.prodList['discount'] != 0
                                        ? Text(
                                            ((1 -
                                                        (widget.prodList[
                                                                'discount'] /
                                                            100)) *
                                                    widget.prodList['price'])
                                                .toStringAsFixed(2),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(''),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  context
                                              .read<Wish>()
                                              .getWishItems
                                              .firstWhereOrNull((product) =>
                                                  product.documentId ==
                                                  widget.prodList['proid']) !=
                                          null
                                      ? context
                                          .read<Wish>()
                                          .removeThis(widget.prodList['proid'])
                                      : context.read<Wish>().addWishItems(
                                          widget.prodList['prodname'],
                                          widget.prodList['discount'] != 0
                                              ? ((1 -
                                                      (widget.prodList[
                                                              'discount'] /
                                                          100)) *
                                                  widget.prodList['price'])
                                              : widget.prodList['price'],
                                          1,
                                          widget.prodList['quantity'],
                                          widget.prodList['prodimages'],
                                          widget.prodList['proid'],
                                          widget.prodList['sid']);
                                },
                                icon: context
                                            .watch<Wish>()
                                            .getWishItems
                                            .firstWhereOrNull((product) =>
                                                product.documentId ==
                                                widget.prodList['proid']) !=
                                        null
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 30,
                                      )
                                    : Icon(
                                        Icons.favorite_outline,
                                        color: Colors.red,
                                        size: 30,
                                      )),
                          ],
                        ),
                        widget.prodList['quantity'] == 0
                            ? Text(
                                'This item is sold out',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16),
                              )
                            : Text(
                                (widget.prodList['quantity'].toString()) +
                                    (' prod available in cart'),
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                        ProfileHeaders(name: 'Item Description'),
                        Text(
                          widget.prodList['proddescrip'],
                          textScaleFactor: 1.1,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey.shade800),
                        ),
                        ExpandableTheme(
                            data: ExpandableThemeData(
                              iconSize: 30,
                              iconColor: Colors.blue,
                            ),
                            child: review(_reviewStream)),
                        ProfileHeaders(name: 'Similar Items'),
                        SizedBox(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _productsStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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
                                    staggeredTileBuilder: (context) =>
                                        StaggeredTile.fit(1)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoreDetails(
                                        adminId: widget.prodList['sid'])));
                          },
                          icon: Icon(Icons.store)),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartScreens(
                                          back: AppBarBackButton(),
                                        )));
                          },
                          icon: Badge(
                              showBadge: context.read<Cart>().getItems.isEmpty
                                  ? false
                                  : true,
                              padding: EdgeInsets.all(2),
                              badgeColor: Colors.yellow,
                              badgeContent: Text(
                                context
                                    .watch<Cart>()
                                    .getItems
                                    .length
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              child: Icon(Icons.shopping_cart))),
                    ],
                  ),
                  YellowButton(
                      size: size,
                      label: 'Add to cart',
                      press: () {
                        if (widget.prodList['quantity'] == 0) {
                          MessageHandler.showSnackBar(
                              _scaffoldKey, 'this item is sold out');
                        } else if (context
                                .read<Cart>()
                                .getItems
                                .firstWhereOrNull((product) =>
                                    product.documentId ==
                                    widget.prodList['proid']) !=
                            null) {
                          MessageHandler.showSnackBar(
                              _scaffoldKey, 'this item already in your cart');
                        } else {
                          context.read<Cart>().addItems(
                              widget.prodList['prodname'],
                              widget.prodList['discount'] != 0
                                  ? ((1 - (widget.prodList['discount'] / 100)) *
                                      widget.prodList['price'])
                                  : widget.prodList['price'],
                              1,
                              widget.prodList['quantity'],
                              widget.prodList['prodimages'],
                              widget.prodList['proid'],
                              widget.prodList['sid']);
                        }
                      },
                      width: 0.5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget review(var _reviewStream) {
  return ExpandablePanel(
      header: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Review',
          style: TextStyle(
              color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      collapsed: SizedBox(
        height: 230,
        child: reviewAll(_reviewStream),
      ),
      expanded: reviewAll(_reviewStream));
}

Widget reviewAll(var _reviewStream) {
  return StreamBuilder<QuerySnapshot>(
    stream: _reviewStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
      if (snapshot2.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        );
      }
      if (snapshot2.data!.docs.isEmpty) {
        return Center(
          child: Text(
            'This Item \n\n has no reviews yet',
            textAlign: TextAlign.center,
            style: (TextStyle(
                fontSize: 26,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold)),
          ),
        );
      }

      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot2.data!.docs.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(snapshot2.data!.docs[index]['profileimages']),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(snapshot2.data!.docs[index]['name']),
                  Row(
                    children: [
                      Text(snapshot2.data!.docs[index]['rate'].toString()),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    ],
                  ),
                ],
              ),
              subtitle: Text(snapshot2.data!.docs[index]['comment']),
            );
          });
    },
  );
}
