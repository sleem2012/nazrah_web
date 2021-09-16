import 'package:flutter/material.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:nazarih/extensions/hover_extension.dart';

class NavBarBtn extends StatelessWidget {
  final String title;
  final String navigationPath;
  const NavBarBtn(this.title, this.navigationPath);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        locator<NavigationService>().navigateTo(navigationPath);
      },
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFF2980b9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
        primary: Colors.white,
        textStyle: TextStyle(
            fontSize: 18, fontFamily: "Bahij", fontWeight: FontWeight.bold),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          title,
        ),
      ),
    ).showCursorOnHover.mouseUpOnHover;
  }
}
