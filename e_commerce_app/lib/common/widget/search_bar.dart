import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade200,
      ),
      child: TextField(
        decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 18),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            hintText: 'What are you looking for ?'),
      ),
    );
  }
}
