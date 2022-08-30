import 'package:flutter/material.dart';

import '../../../model/category_list.dart';

class MenCategory extends StatelessWidget {
  const MenCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            'Men',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
        ),
        SizedBox(
          height: size.height * 0.68,
          child: GridView.count(
            mainAxisSpacing: 70,
            crossAxisSpacing: 15,
            crossAxisCount: 3,
            children: List.generate(
              men.length,
              (index) => Column(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: Image(
                      image: AssetImage('assets/images/men/men$index.jpg'),
                    ),
                  ),
                  Text(men[index]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
