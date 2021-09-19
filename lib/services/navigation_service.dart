import 'package:flutter/cupertino.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName,
      {Map<String, String> queryParams}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateAndPop(String routeName,
      {Map<String, String> queryParams}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState.popAndPushNamed(routeName);
  }

  Future<dynamic> navigateArgument(
      String routeName, String argument, String user) {
    return navigatorKey.currentState
        .pushNamed(routeName, arguments: {'docid': argument, 'user': user});
  }

  Future<dynamic> navigateoneArgument(String routeName, String argument) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: argument);
  }

  goBack() {
    navigatorKey.currentState.pop();
  }
}
