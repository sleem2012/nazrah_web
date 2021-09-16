import 'package:flutter/material.dart';

class NavigationDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.white,
      alignment: Alignment.center,
      child: Image.asset('assets/images/logo/logo.png'),
    );
  }
}
