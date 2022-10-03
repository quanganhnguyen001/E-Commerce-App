import 'package:flutter/material.dart';

class EmptyWishList extends StatelessWidget {
  const EmptyWishList({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your WishList is empty',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
