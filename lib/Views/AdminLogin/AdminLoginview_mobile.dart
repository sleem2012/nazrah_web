import 'package:flutter/material.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';

class AdminLoginViewMobile extends StatefulWidget {
  @override
  _AdminLoginViewMobileState createState() => _AdminLoginViewMobileState();
}

class _AdminLoginViewMobileState extends State<AdminLoginViewMobile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CenteredView(child: NavigationBar(currentRoute: 'AdminLogin')),
        ],
      ),
    );
  }
}
