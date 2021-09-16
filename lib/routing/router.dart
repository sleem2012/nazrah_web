import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/Views/AdminLogin/AdminLogin_view.dart';
import 'package:nazarih/Views/adDetails/adDetails_view.dart';
import 'package:nazarih/Views/addAd/addAd_view.dart';
import 'package:nazarih/Views/chatroom/chatroom_view.dart';
import 'package:nazarih/Views/chats/chats_view.dart';
import 'package:nazarih/Views/commission/commission_view.dart';
import 'package:nazarih/Views/congratAd/congratAd_view.dart';
import 'package:nazarih/Views/contactUs/contact_view.dart';
import 'package:nazarih/Views/delegate/delegate_view.dart';
import 'package:nazarih/Views/editAd/editAd_view.dart';
import 'package:nazarih/Views/home/home_view.dart';
import 'package:nazarih/Views/legacy/legacy_view.dart';
import 'package:nazarih/Views/login/login_view.dart';
import 'package:nazarih/Views/membershipInfo/membership_view.dart';
import 'package:nazarih/Views/notifications/notifications_view.dart';
import 'package:nazarih/Views/profile/profile_view.dart';
import 'package:nazarih/Views/repeatedAd/repeatedAd_view.dart';
import 'package:nazarih/Views/signup/signup_view.dart';
import 'package:nazarih/Views/terms/terms_view.dart';
import 'package:nazarih/Views/timelimitAd/timelimitAd_view.dart';
import 'package:nazarih/Views/viewProfile/viewprofile_view.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/extensions/string_extension.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData;
  switch (routingData.route) {
    case HomeRoute:
      return _getPageRoute(HomeView(), settings);
    case LoginRoute:
      return _getPageRoute(LoginView(), settings);
    case SignupRoute:
      return _getPageRoute(SignupView(), settings);
    case ProfileRoute:
      return _getPageRoute(ProfileView(), settings);
    case AddAdRoute:
      return _getPageRoute(AddView(), settings);
    case CongratAdRoute:
      return _getPageRoute(CongratAdView(), settings);
    case RepeatedAdRoute:
      return _getPageRoute(RepeatedAdView(), settings);
    case TimeLimitAdRoute:
      return _getPageRoute(TimelimitAdView(), settings);
    case AdDetailsRoute:
      var id = routingData['id'];
      return _getPageRoute(AdDetailsView(id: id), settings);
    case ContactRoute:
      return _getPageRoute(ContactView(), settings);
    case UserDetailsRoute:
      var id = routingData['id'];
      return _getPageRoute(ViewProfile(id: id), settings);
    case MembershipInfoRoute:
      return _getPageRoute(MembershipView(), settings);
    case CommissionInfoRoute:
      return _getPageRoute(CommissionView(), settings);
    case TermsRoute:
      return _getPageRoute(TermsView(), settings);
    case LegacyRoute:
      return _getPageRoute(LegacyView(), settings);
    case DelegateRoute:
      return _getPageRoute(DelegateView(), settings);
    case ChatRoomRoute:
      var id = routingData['id'];
      return _getPageRoute(ChatRoomView(id: id), settings);
    case ChatsRoute:
      return _getPageRoute(ChatsView(), settings);
    case NotificationsRoute:
      return _getPageRoute(NotificationsView(), settings);
    case AdminRoute:
      return _getPageRoute(AdminLoginView(), settings);
    case EditAdRoute:
      var id = routingData['id'];
      return _getPageRoute(EditAdView(id: id), settings);
    default:
      return _getPageRoute(HomeView(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, settings: settings);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final RouteSettings settings;
  _FadeRoute({this.child, this.settings})
      : super(
      settings: settings,
      pageBuilder: (BuildContext build, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      child,
      transitionsBuilder: (BuildContext build,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) =>
          FadeTransition(
            opacity: animation,
            child: child,
          ));
}
