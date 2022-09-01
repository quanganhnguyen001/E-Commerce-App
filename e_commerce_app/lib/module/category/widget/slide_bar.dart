import 'package:flutter/material.dart';

class SlideBar extends StatelessWidget {
  const SlideBar({
    Key? key,
    required this.size,
    required this.mainCategName,
  }) : super(key: key);

  final Size size;
  final String mainCategName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.8,
      width: size.width * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                mainCategName == 'beauty'
                    ? Text('')
                    : Text(
                        ' << ',
                        style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 10,
                            fontSize: 16),
                      ),
                Text(
                  mainCategName.toUpperCase(),
                  style: style,
                ),
                mainCategName == 'men'
                    ? Text('')
                    : Text(
                        ' >> ',
                        style: style,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const style = TextStyle(
    color: Colors.brown,
    fontWeight: FontWeight.w600,
    letterSpacing: 10,
    fontSize: 16);
