import 'package:flutter/material.dart';
import 'package:nazarih/Views/repeatedAd/repeatedAdView_mobile.dart';
import 'package:nazarih/Views/repeatedAd/repeatedAdView_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RepeatedAdView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: RepeatedAdViewMobile(),
      desktop: RepeatedAdViewTabletDesktop(),
      tablet: RepeatedAdViewTabletDesktop(),
    );
  }
}
