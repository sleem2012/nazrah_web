import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:nazarih/widgets/navigation_bar/navbar_btn.dart';
import 'package:nazarih/widgets/navigation_bar/navbar_item.dart';
import 'package:nazarih/widgets/navigation_bar/navbar_logo.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class NavigationBarTabletDekstop extends StatefulWidget {
  final String currentRoute;

  NavigationBarTabletDekstop({@required this.currentRoute});

  @override
  _NavigationBarTabletDekstopState createState() =>
      _NavigationBarTabletDekstopState(currentRoute: currentRoute);
}

class _NavigationBarTabletDekstopState
    extends State<NavigationBarTabletDekstop> {
  String currentRoute;

  _NavigationBarTabletDekstopState({@required this.currentRoute});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> loadMyPages() {
    return _firestore.collection('info').doc('Pages').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;

    return Container(
      height: 140,
      alignment: Alignment.centerRight,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavBarBtn('أنشاء حساب', SignupRoute),
              SizedBox(
                width: 40,
              ),
              NavBarBtn('تسجيل الدخول', LoginRoute),
              SizedBox(
                width: 40,
              ),
            ],
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NavBarItem('أتصل بنا', ContactRoute, () {
                      locator<NavigationService>().navigateTo(ContactRoute);
                      setState(() {
                        currentRoute = 'Contact';
                      });
                    },
                        (currentRoute == 'Contact')
                            ? Color(0xFF2980b9)
                            : Colors.black),
                    SizedBox(
                      width: 40,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: loadMyPages(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            bool legacy = snapshot.data.data()['Legacy'];
                            if (legacy) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: NavBarItem(
                                    'السلع والإعلانات الممنوعة', LegacyRoute, () {
                                  locator<NavigationService>()
                                      .navigateTo(LegacyRoute);
                                  setState(() {
                                    currentRoute = 'Legacy';
                                  });
                                },
                                    (currentRoute == 'Legacy')
                                        ? Color(0xFF2980b9)
                                        : Colors.black),
                              );
                            } else {
                              return Container();
                            }
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: NavBarItem(
                                  'السلع والإعلانات الممنوعة', LegacyRoute, () {
                                locator<NavigationService>().navigateTo(LegacyRoute);
                                setState(() {
                                  currentRoute = 'Legacy';
                                });
                              },
                                  (currentRoute == 'Legacy')
                                      ? Color(0xFF2980b9)
                                      : Colors.black),
                            );
                          }
                        }),
                    // SizedBox(
                    //   width: 40,
                    // ),
                    NavBarItem('اتفاقية استخدام الموقع والمعلومات', TermsRoute, () {
                      locator<NavigationService>().navigateTo(TermsRoute);
                      setState(() {
                        currentRoute = 'Terms';
                      });
                    }, (currentRoute == 'Terms') ? Color(0xFF2980b9) : Colors.black),
                    SizedBox(
                      width: 40,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: loadMyPages(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            bool delegate = snapshot.data.data()['Delegate'];
                            if (delegate) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: NavBarItem('تسجيل مندوب', DelegateRoute, () {
                                  locator<NavigationService>()
                                      .navigateTo(DelegateRoute);
                                  setState(() {
                                    currentRoute = 'Delegate';
                                  });
                                },
                                    (currentRoute == 'Delegate')
                                        ? Color(0xFF2980b9)
                                        : Colors.black),
                              );
                            } else {
                              return Container();
                            }
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: NavBarItem('تسجيل مندوب', DelegateRoute, () {
                                locator<NavigationService>()
                                    .navigateTo(DelegateRoute);
                                setState(() {
                                  currentRoute = 'Delegate';
                                });
                              },
                                  (currentRoute == 'Delegate')
                                      ? Color(0xFF2980b9)
                                      : Colors.black),
                            );
                          }
                        }),
                    // SizedBox(
                    //   width: 40,
                    // ),
                    NavBarItem('العمولة', CommissionInfoRoute, () {
                      locator<NavigationService>().navigateTo(CommissionInfoRoute);
                      setState(() {
                        currentRoute = 'Commission';
                      });
                    },
                        (currentRoute == 'Commission')
                            ? Color(0xFF2980b9)
                            : Colors.black),
                    SizedBox(
                      width: 40,
                    ),
                    NavBarItem('العضويات', MembershipInfoRoute, () {
                      locator<NavigationService>().navigateTo(MembershipInfoRoute);
                      setState(() {
                        currentRoute = 'Membership';
                      });
                    },
                        (currentRoute == 'Membership')
                            ? Color(0xFF2980b9)
                            : Colors.black),
                    SizedBox(
                      width: 40,
                    ),
                    NavBarItem('الرئيسية', HomeRoute, () {
                      locator<NavigationService>().navigateTo(HomeRoute);
                      setState(() {
                        currentRoute = 'Home';
                      });
                    }, (currentRoute == 'Home') ? Color(0xFF2980b9) : Colors.black),
                  ],
                ),

              ],
            ),
          ),
          Container(
            height: 140,
            width: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                NavBarLogo(),
                SizedBox(
                  height: 5,
                ),
                // Text(
                //   'وما توفيقي الا بالله',
                //   style: TextStyle(
                //       fontSize: 30,
                //       fontFamily: "Arslan Wessam",
                //       color: Colors.black,
                //       fontWeight: FontWeight.bold),
                //   textAlign: TextAlign.center,
                // )
                DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Arslan Wessam",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('وما توفيقي الا بالله',
                          speed: Duration(milliseconds: 200)),
                    ],
                    isRepeatingAnimation: true,
                    repeatForever: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
