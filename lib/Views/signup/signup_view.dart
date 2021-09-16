import 'package:flutter/material.dart';
import 'package:nazarih/Views/signup/signupview_mobile.dart';
import 'package:nazarih/Views/signup/signupview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: SignupViewMobile(),
      desktop: SignupViewTabletDesktop(),
      tablet: SignupViewTabletDesktop(),
    );
  }
}
