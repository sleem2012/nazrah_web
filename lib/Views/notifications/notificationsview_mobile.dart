import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/model/user.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsViewMobile extends StatefulWidget {
  @override
  _NotificationsViewMobileState createState() =>
      _NotificationsViewMobileState();
}

class NotificationsInfo {
  String message, type, docId;
  NotificationsInfo({this.message, this.type, this.docId});
}

class _NotificationsViewMobileState extends State<NotificationsViewMobile> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String phoneNumber;
  Stream<QuerySnapshot> loadMyNotifications() {
    return _firestore
        .collection('users')
        .doc(phoneNumber)
        .collection('Notifications')
        .orderBy('date')
        .snapshots();
  }

  Stream<DocumentSnapshot> loadAppInfo() {
    return _firestore.collection('info').doc('app').snapshots();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (phoneNumber == null) return Center(child: CircularProgressIndicator());
    return SingleChildScrollView(
      child: Column(
        children: [
          CenteredView(child: NavigationBar(currentRoute: 'Notification')),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
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
                                fontSize: 15,
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
                          fontSize: 30,
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
                        fontSize: 30,
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
                                        fontSize: 30,
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
    );
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      phoneNumber = prefs.getString('Phone Number') ?? null;
    });
  }
}
