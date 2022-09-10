import 'package:flutter/material.dart';

class UploadScreens extends StatefulWidget {
  const UploadScreens({Key? key}) : super(key: key);

  @override
  State<UploadScreens> createState() => _UploadScreensState();
}

class _UploadScreensState extends State<UploadScreens> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    color: Colors.grey.shade300,
                    height: size.width * 0.5,
                    width: size.width * 0.5,
                    child: Center(
                        child: Text(
                      'You have not \n \n picked images yet !',
                      textAlign: TextAlign.center,
                      style: (TextStyle(fontSize: 16)),
                    )),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                child: Divider(
                  color: Colors.orange,
                  thickness: 1.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: size.width * 0.4,
                  child: TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: textFormDecoration.copyWith(
                      labelText: 'Price',
                      hintText: 'price ...\$',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: size.width * 0.5,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: textFormDecoration.copyWith(
                      labelText: 'Quantity',
                      hintText: 'Add Quantity',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: size.width * 0.7,
                  child: TextFormField(
                    maxLength: 100,
                    maxLines: 3,
                    decoration: textFormDecoration.copyWith(
                      labelText: 'Product Name',
                      hintText: 'Enter Product Name',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: size.width * 0.9,
                  child: TextFormField(
                    maxLines: 5,
                    maxLength: 800,
                    decoration: textFormDecoration.copyWith(
                      labelText: 'Product Description',
                      hintText: 'Enter Product Description',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.orange,
              child: Icon(
                Icons.photo_library,
                color: Colors.black,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.orange,
            child: Icon(
              Icons.upload,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'Price',
  hintText: 'price ...\$',
  labelStyle: TextStyle(color: Colors.purple),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 1),
    borderRadius: BorderRadius.circular(25),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(25),
  ),
);
