import 'package:e_commerce_app/module/home/screens/home_screens.dart';
import 'package:e_commerce_app/module/home/widget/customer_home.dart';
import 'package:flutter/material.dart';

class CartScreens extends StatefulWidget {
  const CartScreens({Key? key}) : super(key: key);

  @override
  State<CartScreens> createState() => _CartScreensState();
}

class _CartScreensState extends State<CartScreens> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerHomeScreen()));
                },
                child: Text(
                  'Continue shopping',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Total: \$ ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '0.00',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(25),
              ),
              width: size.width * 0.45,
              child: MaterialButton(
                onPressed: () {},
                child: Text('CHECK OUT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
