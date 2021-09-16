import 'package:flutter/material.dart';
import 'package:nazarih/Views/adDetails/adDetailsview_mobile.dart';
import 'package:nazarih/Views/adDetails/adDetailsview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdDetailsView extends StatelessWidget {
  final String id;
  const AdDetailsView({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: AdDetailsViewMobile(documentId: id),
      desktop: AdDetailsViewTabletDesktop(
        documentId: id,
      ),
      tablet: AdDetailsViewTabletDesktop(documentId: id),
    );
  }
}
