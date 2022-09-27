import 'package:flutter/material.dart';

import 'package:e_commerce_app/common/widget/appbar_back_button.dart';

class FullScreens extends StatefulWidget {
  const FullScreens({
    Key? key,
    required this.imageslist,
  }) : super(key: key);
  final List<dynamic> imageslist; // mark as List to use length

  @override
  State<FullScreens> createState() => _FullScreensState();
}

class _FullScreensState extends State<FullScreens> {
  final PageController _controller = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: AppBarBackButton(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(
                ('${index + 1}') +
                    ('/') +
                    (widget.imageslist.length.toString()),
                style: TextStyle(fontSize: 24, letterSpacing: 8),
              ),
            ),
            SizedBox(
              height: size.height * 0.5,
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                controller: _controller,
                children: images(),
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
              child: imageView(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> images() {
    return List.generate(widget.imageslist.length, (index) {
      return InteractiveViewer(
        transformationController: TransformationController(),
        child: Image.network(widget.imageslist[index].toString()),
      );
    });
  }

  ListView imageView() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.imageslist.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _controller.jumpToPage(index);
            },
            child: Container(
                margin: EdgeInsets.all(8),
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.orange),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.imageslist[index].toString(),
                    fit: BoxFit.cover,
                  ),
                )),
          );
        });
  }
}
