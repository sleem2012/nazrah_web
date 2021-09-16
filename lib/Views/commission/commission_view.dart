import 'package:flutter/material.dart';
import 'package:nazarih/Views/commission/commissionview_mobile.dart';
import 'package:nazarih/Views/commission/commissionview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CommissionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: CommissionViewMobile(),
      desktop: CommissionViewTabletDesktop(),
      tablet: CommissionViewTabletDesktop(),
    );
  }
}
