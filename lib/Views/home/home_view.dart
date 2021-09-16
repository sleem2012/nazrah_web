import 'package:flutter/material.dart';
import 'package:nazarih/Views/home/homeview_mobile.dart';
import 'package:nazarih/Views/home/homeview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeViewMobile(),
      desktop: HomeViewTabletDesktop(),
      tablet: HomeViewTabletDesktop(),
    );
  }
}
