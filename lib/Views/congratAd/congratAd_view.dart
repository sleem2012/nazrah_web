import 'package:flutter/material.dart';
import 'package:nazarih/Views/congratAd/congratAdview_mobile.dart';
import 'package:nazarih/Views/congratAd/congratAdview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CongratAdView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: CongratAdViewMobile(),
      desktop: CongratAdViewTabletDesktop(),
      tablet: CongratAdViewTabletDesktop(),
    );
  }
}
