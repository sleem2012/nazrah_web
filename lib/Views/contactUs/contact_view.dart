import 'package:flutter/material.dart';
import 'package:nazarih/Views/contactUs/contactview_mobile.dart';
import 'package:nazarih/Views/contactUs/contactview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ContactView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ContactViewMobile(),
      desktop: ContactViewTabletDekstop(),
      tablet: ContactViewTabletDekstop(),
    );
  }
}
