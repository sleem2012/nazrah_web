import 'package:flutter/material.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/services/navigation_service.dart';

class NavBarDrawerItem extends StatelessWidget {

  final String title;
  final String navigationPath;
   NavBarDrawerItem(this.title, this.navigationPath);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {

        locator<NavigationService>().navigateAndPop(navigationPath);
        context.findRootAncestorStateOfType<DrawerControllerState>()?.close();

      },
      child: Text(
        title,
        style: TextStyle(
            fontSize: 15,
            fontFamily: "Bahij",
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
