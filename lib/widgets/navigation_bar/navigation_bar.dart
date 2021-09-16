import 'package:flutter/material.dart';
import 'package:nazarih/widgets/navigation_bar/navigationbar_mobile.dart';
import 'package:nazarih/widgets/navigation_bar/navigationbar_tablet_desktop.dart';
import 'package:nazarih/widgets/navigation_bar/navigationbar_tablet_desktop_not.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationBar extends StatefulWidget {
  final String currentRoute;

  NavigationBar({@required this.currentRoute});

  @override
  _NavigationBarState createState() =>
      _NavigationBarState(currentRoute: currentRoute);
}

class _NavigationBarState extends State<NavigationBar> {
  String currentRoute;

  _NavigationBarState({@required this.currentRoute});

  bool user;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (user == false) {
      return ScreenTypeLayout(
        mobile: NavigationBarMobile(),
        tablet: NavigationBarTabletDekstop(
          currentRoute: currentRoute,
        ),
        desktop: NavigationBarTabletDekstop(
          currentRoute: currentRoute,
        ),
      );
    } else {
      return ScreenTypeLayout(
        mobile: NavigationBarMobile(),
        tablet: NavigationBarTabletDekstopNot(currentRoute: currentRoute),
        desktop: NavigationBarTabletDekstopNot(currentRoute: currentRoute),
      );
    }
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      user = prefs.getBool('Login') ?? false;
    });
  }
}
