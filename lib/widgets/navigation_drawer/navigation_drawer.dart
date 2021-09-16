import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/widgets/navigation_drawer/drawer_item.dart';
import 'package:nazarih/widgets/navigation_drawer/navigation_drawer_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String phoneNo;
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
    return Container(
      width: 300,

      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 16)]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            NavigationDrawerHeader(),
            GestureDetector(child: DrawerItem(Icons.home, 'الرئيسية', HomeRoute)),
            DrawerItem(Icons.card_membership, 'العضويات', MembershipInfoRoute),
            DrawerItem(Icons.calculate, 'العمولة', CommissionInfoRoute),
            StreamBuilder<DocumentSnapshot>(
              stream: loadMyPages(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool delegate = snapshot.data.data()['Delegate'];
                  if (delegate) {
                    return DrawerItem(
                        Icons.app_registration, 'تسجيل مندوب', DelegateRoute);
                  } else {
                    return Container();
                  }
                } else {
                  return DrawerItem(
                      Icons.app_registration, 'تسجيل مندوب', DelegateRoute);
                }
              },
            ),
            DrawerItem(
                Icons.rule, 'اتفاقية استخدام الموقع والمعلومات', TermsRoute),
            StreamBuilder<DocumentSnapshot>(
              stream: loadMyPages(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool delegate = snapshot.data.data()['Delegate'];
                  if (delegate) {
                    return DrawerItem(
                        Icons.cancel, 'السلع والإعلانات الممنوعة', LegacyRoute);
                  } else {
                    return Container();
                  }
                } else {
                  return DrawerItem(
                      Icons.cancel, 'السلع والإعلانات الممنوعة', LegacyRoute);
                }
              },
            ),
            DrawerItem(Icons.contact_support, 'أتصل بنا', ContactRoute),
            SizedBox(
              height: 50,
            ),
            (phoneNo == null)
                ? Column(
                    children: [
                      DrawerItem(Icons.login, 'تسجيل دخول', LoginRoute),
                      DrawerItem(
                          Icons.app_registration, 'انشاء حساب', SignupRoute),
                    ],
                  )
                : Column(
                    children: [
                      DrawerItem(Icons.person, 'الصفحة الشخصية', ProfileRoute),
                      DrawerItem(
                          Icons.notifications, 'الاشعارات', NotificationsRoute),
                      DrawerItem(Icons.chat, 'الرسائل', ChatsRoute),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      phoneNo = prefs.getString('Phone Number') ?? null;
    });
  }
}
