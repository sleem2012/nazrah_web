import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class RepeatedAdViewMobile extends StatefulWidget {
  @override
  _RepeatedAdViewMobileState createState() => _RepeatedAdViewMobileState();
}

class _RepeatedAdViewMobileState extends State<RepeatedAdViewMobile> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 15),
        () => locator<NavigationService>().navigateTo(HomeRoute));
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> loadAppInfo() {
    return _firestore.collection('info').doc('app').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

      child: Column(
        children: [
          CenteredView(child: NavigationBar(currentRoute: 'Repeated')),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF2980b9),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icons/wrong.png',
                  height: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "لا يسمح بالاعانات المكرره الا فالعضويات المدفوعة",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Bahij',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ],
            ),
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
                        ),
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
                        ),
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
}
