import 'package:flutter/material.dart';
import 'package:nazarih/Views/addAd/addAdview_mobile.dart';
import 'package:nazarih/Views/addAd/addAdview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: AddAdViewMobile(),
      desktop: AddAdViewTabletDesktop(),
      tablet: AddAdViewTabletDesktop(),
    );
  }
}
