import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

class NotificationsViewTabletDesktop extends StatefulWidget {
  @override
  _NotificationsViewTabletDesktopState createState() =>
      _NotificationsViewTabletDesktopState();
}

class NotificationsInfo {
  String message, type, docId;
  NotificationsInfo({this.message, this.type, this.docId});
}

class _NotificationsViewTabletDesktopState
    extends State<NotificationsViewTabletDesktop> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String phoneNumber;
  Stream<QuerySnapshot> loadMyNotifications() {
    return _firestore
        .collection('users')
        .doc(phoneNumber)
        .collection('Notifications')
        .orderBy('date', descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot> loadAppInfo() {
    return _firestore.collection('info').doc('app').snapshots();
  }

  @override
  void initState() {
    getData();
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => _slidingPage.animateTo(_slidingPage.offset + 0.1,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn));
  }

  ScrollController _slidingPage = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (phoneNumber == null) return Center(child: CircularProgressIndicator());
    return VsScrollbar(
      controller: _slidingPage,
      isAlwaysShown: true,
      showTrackOnHover: true,
      style: VsScrollbarStyle(
        hoverThickness: 10.0, // default 12.0
        radius: Radius.circular(10), // default Radius.circular(8.0)
        thickness: 10.0, // [ default 8.0 ]
        color: Color(0xFF2980b9), // default ColorScheme Theme
      ),
      child: SingleChildScrollView(
        controller: _slidingPage,
        child: Column(
          children: [
            CenteredView(child: NavigationBar(currentRoute: 'Notification')),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF2980b9),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50, left: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        _firestore
                            .collection('users')
                            .doc(phoneNumber)
                            .collection('Notifications')
                            .get()
                            .then((snapshot) => {
                                  for (DocumentSnapshot ds in snapshot.docs)
                                    {ds.reference.delete()}
                                });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFFe74c3c),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "مسح الاشعارات",
                              style: TextStyle(
                                  fontFamily: 'Bahij',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.delete, color: Colors.white),
                          ],
                        ),
                      )).mouseUpOnHover,
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text("الاشعارات",
                        style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: loadMyNotifications(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data.docs.length == 0) {
                  return Center(
                    child: Text(
                      "لاتوجد اشعارات فالوقت الحالي",
                      style: TextStyle(
                          fontFamily: 'Bahij',
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  List<NotificationsInfo> notifications = [];
                  for (var doc in snapshot.data.docs) {
                    notifications.add(NotificationsInfo(
                        docId: doc.data()['docId'],
                        message: doc.data()['message'],
                        type: doc.data()['type']));
                  }
                  return Padding(
                    padding: EdgeInsets.only(
                      right: 50,
                      left: 50,
                    ),
                    child: ListView.builder(
                      itemCount: notifications.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (notifications[index].type == 'message') {
                              // locator<NavigationService>().navigateoneArgument(
                              //     ChatRoomRoute, notifications[index].docId);
                              locator<NavigationService>()
                                  .navigateTo(ChatRoomRoute, queryParams: {
                                'id': notifications[index].docId
                              });
                            } else {
                              locator<NavigationService>()
                                  .navigateTo(AdDetailsRoute, queryParams: {
                                'id': notifications[index].docId
                              });
                              // locator<NavigationService>().navigateArgument(
                              //     AdDetailsRoute, notifications[index].docId, '');
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFF2980b9),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 40, right: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      notifications[index].message,
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 50,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ).mouseUpOnHover.showCursorOnHover,
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF2980b9),
            ),
            Container(
              height: 250,
              child: StreamBuilder<DocumentSnapshot>(
                stream: loadAppInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String appstore = snapshot.data.data()['appstore'];
                    String playstore = snapshot.data.data()['playstore'];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            launch(playstore);
                          },
                          child: Image.asset(
                            'assets/images/icons/googleplay.png',
                            height: 100,
                            width: 150,
                          ).mouseUpOnHover.showCursorOnHover,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            launch(appstore);
                          },
                          child: Image.asset(
                            'assets/images/icons/appstore.png',
                            height: 100,
                            width: 150,
                          ).mouseUpOnHover.showCursorOnHover,
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
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
