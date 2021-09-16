import 'package:flutter/material.dart';
import 'package:nazarih/extensions/hover_extension.dart';

Widget textPhotoCategories(
    String text, String imagePath, Function ontap, Color color) {
  return TextButton(
      onPressed: ontap,
      style: TextButton.styleFrom(
        backgroundColor: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              text,
              style: TextStyle(
                  fontFamily: 'Bahij',
                  fontSize: 20,
                  color: (color == Color(0xFF2980b9))
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      )).mouseUpOnHover;
}

Widget textCategories(String text, Function ontap, Color color) {
  return TextButton(
      onPressed: ontap,
      style: TextButton.styleFrom(
        backgroundColor: color,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Bahij',
              fontSize: 20,
              color: (color == Color(0xFF2980b9)) ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold),
        ),
      )).mouseUpOnHover;
}

Widget photoCategories(String imagePath, Function ontap, Color color) {
  return TextButton(
      onPressed: ontap,
      style: TextButton.styleFrom(
        backgroundColor: color,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          width: 100,
          height: 85,
        ),
      )).mouseUpOnHover;
}
