import 'package:flutter/material.dart';
import 'package:nazarih/Views/layout_template/layout_template.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/routing/router.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:sizer/sizer.dart';

void main() {
  setupLoactor();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'موقع نظره',
        builder: (context, child) => LayoutTemplate(child: child),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: generateRoute,
        initialRoute: HomeRoute,
      );
    });
  }
}
