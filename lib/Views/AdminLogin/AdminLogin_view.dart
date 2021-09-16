import 'package:flutter/material.dart';
import 'package:nazarih/Views/AdminLogin/AdminLoginview_mobile.dart';
import 'package:nazarih/Views/AdminLogin/AdminLoginview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminLoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: AdminLoginViewMobile(),
      desktop: AdminLoginViewTabletDesktop(),
      tablet: AdminLoginViewTabletDesktop(),
    );
  }
}
