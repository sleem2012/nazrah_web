import 'package:flutter/material.dart';
import 'package:nazarih/Views/login/loginview_mobile.dart';
import 'package:nazarih/Views/login/loginview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: LoginViewMobile(),
      desktop: LoginViewTabletDesktop(),
      tablet: LoginViewTabletDesktop(),
    );
  }
}
