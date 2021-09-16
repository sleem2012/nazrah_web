import 'package:flutter/material.dart';
import 'package:nazarih/Views/editAd/editAdView_mobile.dart';
import 'package:nazarih/Views/editAd/editAdView_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EditAdView extends StatelessWidget {
  final String id;
  const EditAdView({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: EditAdViewMobile(documentId: id),
      desktop: EditAdViewTabletDesktop(documentId: id),
      tablet: EditAdViewTabletDesktop(documentId: id),
    );
  }
}
