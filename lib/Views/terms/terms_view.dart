import 'package:flutter/material.dart';
import 'package:nazarih/Views/terms/termsview_mobile.dart';
import 'package:nazarih/Views/terms/termsview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TermsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: TermsViewMobile(),
      desktop: TermsViewTabletDesktop(),
      tablet: TermsViewTabletDesktop(),
    );
  }
}
