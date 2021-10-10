import 'package:flutter/material.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:nazarih/extensions/hover_extension.dart';

class NavBarItem extends StatelessWidget {
  final String title;
  final String navigationPath;
  final Function ontap;
  final Color color;
  const NavBarItem(this.title, this.navigationPath, this.ontap, this.color);

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: ontap,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontFamily: "Bahij",
            color: color,
            fontWeight: FontWeight.bold),
      ),
    ).showCursorOnHover.mouseUpOnHover;
  }
}
