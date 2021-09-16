import 'package:flutter/material.dart';
import 'package:nazarih/Views/timelimitAd/timelimitAdView_mobile.dart';
import 'package:nazarih/Views/timelimitAd/timelimitAdView_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TimelimitAdView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: TimelimitAdViewMobile(),
      desktop: TimelimitAdViewTabletDesktop(),
      tablet: TimelimitAdViewTabletDesktop(),
    );
  }
}
