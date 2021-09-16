import 'package:flutter/material.dart';
import 'package:nazarih/widgets/navigation_bar/navbar_logo.dart';

class NavigationBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => Container(
              height: 80,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Center(child: NavBarLogo())),
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Color(0xFF2980b9),
                      ),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      }),
                ],
              ),
            ));
  }
}
