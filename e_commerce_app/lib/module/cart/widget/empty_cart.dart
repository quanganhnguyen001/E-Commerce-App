import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
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
            'Your Cart is empty',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 50,
          ),
          Material(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(25),
            child: MaterialButton(
              minWidth: size.width * 0.6,
              onPressed: () {
                Navigator.canPop(context)
                    ? Navigator.pop(context)
                    : Navigator.pushReplacementNamed(
                        context, '/customer_screens');
              },
              child: Text(
                'Continue shopping',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
