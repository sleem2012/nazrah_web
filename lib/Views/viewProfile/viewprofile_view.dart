import 'package:flutter/material.dart';
import 'package:nazarih/Views/viewProfile/viewprofile_mobile.dart';
import 'package:nazarih/Views/viewProfile/viewprofile_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ViewProfile extends StatelessWidget {
  final String id;
  const ViewProfile({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ViewProfileMobile(phoneNumber: id),
      desktop: ViewProfileTabletDesktop(phoneNumber: id),
      tablet: ViewProfileTabletDesktop(phoneNumber: id),
    );
  }
}
