import 'package:flutter/material.dart';
import 'package:nazarih/Views/notifications/notificationsview_mobile.dart';
import 'package:nazarih/Views/notifications/notificationsview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NotificationsViewMobile(),
      desktop: NotificationsViewTabletDesktop(),
      tablet: NotificationsViewTabletDesktop(),
    );
  }
}
