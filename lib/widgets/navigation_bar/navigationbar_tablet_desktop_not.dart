import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/widgets/navigation_bar/navbar_item.dart';
import 'package:nazarih/widgets/navigation_bar/navbar_logo.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationBarTabletDekstopNot extends StatefulWidget {
  final String currentRoute;

  NavigationBarTabletDekstopNot({@required this.currentRoute});

  @override
  _NavigationBarTabletDekstopNotState createState() =>
      _NavigationBarTabletDekstopNotState(currentRoute: currentRoute);
}

class _NavigationBarTabletDekstopNotState
    extends State<NavigationBarTabletDekstopNot> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String phoneNumber;
  String currentRoute;

  _NavigationBarTabletDekstopNotState({@required this.currentRoute});

  Stream<QuerySnapshot> loadMyNotifications() {
    return _firestore
        .collection('users')
        .doc(phoneNumber)
        .collection('Notifications')
        .snapshots();
  }

  Stream<DocumentSnapshot> loadMyPages() {
    return _firestore.collection('info').doc('Pages').snapshots();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;

    return Container(
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  locator<NavigationService>().navigateTo(ProfileRoute);
                },
                child: Image.asset(
                  'assets/images/icons/profile.png',
                  height: 50,
                ),
              ).showCursorOnHover.mouseUpOnHover,
              SizedBox(
                width: 40,
              ),
              GestureDetector(
                onTap: () {
                  locator<NavigationService>().navigateTo(ChatsRoute);
                },
                child: Image.asset(
                  'assets/images/icons/chat.png',
                  height: 50,
                ),
              ).showCursorOnHover.mouseUpOnHover,
              SizedBox(
                width: 40,
              ),
              GestureDetector(
                  onTap: () {
                    locator<NavigationService>().navigateTo(NotificationsRoute);
                  },
                  child: StreamBuilder<QuerySnapshot>(
                    stream: loadMyNotifications(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data.docs.length == 0) {
                        return Image.asset(
                          'assets/images/icons/notification_free.png',
                          height: 50,
                        );
                      } else {
                        return Image.asset(
                          'assets/images/icons/notification.png',
                          height: 50,
                        );
                      }
                    },
                  )).showCursorOnHover.mouseUpOnHover,
            ],
          ),

          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
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
                            if (legacy == true) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NavBarLogo(),
                SizedBox(
                  height: 5,
                ),
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

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      phoneNumber = prefs.getString('Phone Number') ?? null;
    });
  }
}
