import 'package:flutter/material.dart';
import 'package:nazarih/Views/legacy/legacyview_mobile.dart';
import 'package:nazarih/Views/legacy/legacyview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LegacyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: LegacyViewMobile(),
      desktop: LegacyViewTabletDesktop(),
      tablet: LegacyViewTabletDesktop(),
    );
  }
}
