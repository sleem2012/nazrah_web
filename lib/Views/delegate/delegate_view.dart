import 'package:flutter/material.dart';
import 'package:nazarih/Views/delegate/delegateview_mobile.dart';
import 'package:nazarih/Views/delegate/delegateview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DelegateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: DelegateViewMobile(),
      desktop: DelegateViewTabletDesktop(),
      tablet: DelegateViewTabletDesktop(),
    );
  }
}
