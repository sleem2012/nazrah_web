import 'package:flutter/material.dart';
import 'package:nazarih/widgets/navigation_drawer/navbar_item.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String navigationPath;
   DrawerItem(this.icon, this.title, this.navigationPath);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 30, top: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          NavBarDrawerItem(title, navigationPath),
          SizedBox(
            width: 30,
          ),
          Icon(icon),
        ],
      ),
    );
  }
}
