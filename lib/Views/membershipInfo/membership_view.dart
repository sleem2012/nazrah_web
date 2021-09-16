import 'package:flutter/material.dart';
import 'package:nazarih/Views/membershipInfo/membership_mobile.dart';
import 'package:nazarih/Views/membershipInfo/membership_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MembershipView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MembershipViewMobile(),
      desktop: MembershipViewTabletDesktop(),
      tablet: MembershipViewTabletDesktop(),
    );
  }
}
