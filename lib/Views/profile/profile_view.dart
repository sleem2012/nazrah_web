import 'package:flutter/material.dart';
import 'package:nazarih/Views/profile/profileview_mobile.dart';
import 'package:nazarih/Views/profile/profileview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ProfileViewMobile(),
      desktop: ProfileViewTabletDesktop(),
      tablet: ProfileViewTabletDesktop(),
    );
  }
}
