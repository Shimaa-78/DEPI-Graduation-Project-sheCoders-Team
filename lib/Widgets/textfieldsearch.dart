
import 'package:flutter/material.dart';

class Textfieldsearch  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none, // Removing the border
          suffixIcon: Icon(Icons.search), // أيقونة البحث في نهاية الـ TextField
        ),
      ),
    );
  }}






