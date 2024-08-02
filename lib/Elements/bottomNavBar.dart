import 'package:flutter/material.dart';

class CustomBottomNavigationBarItem extends BottomNavigationBarItem {
  CustomBottomNavigationBarItem({required String imagePath})
      : super(
    icon: ImageIcon(
      AssetImage(imagePath),
      color: Colors.black,
      size: 30,
    ),
    label: '',
  );
}