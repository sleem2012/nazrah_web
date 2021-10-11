import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:nazarih/services/Shareddata.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

class LoginViewTabletDesktop extends StatefulWidget {
  @override
  _LoginViewTabletDesktopState createState() => _LoginViewTabletDesktopState();
}

class _LoginViewTabletDesktopState extends State<LoginViewTabletDesktop> {
  String phoneNo;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool error1 = false;
  bool error2 = false;
  bool writing = false;

  ScrollController _slidingPage = ScrollController();
  Stream<DocumentSnapshot> loadAppInfo() {
    return _firestore.collection('info').doc('app').snapshots();
  }

  @override
  Widget build(BuildContext context) {
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
            CenteredView(child: NavigationBar(currentRoute: 'Login')),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF2980b9),
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/vectors/login.png',
                          height: 250,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width:
                              ((MediaQuery.of(context).size.width / 2) - 40) /
                                  2,
                          child: Directionality(
                            textDirection: (writing == false)
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child: TextField(
                              onChanged: (val) {
                                if (val != '') {
                                  setState(() {
                                    writing = true;
                                  });
                                } else {
                                  setState(() {
                                    writing = false;
                                  });
                                }
                                phoneNo = val;
                              },
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: 'Bahij',
                                fontSize: 20,
                              ),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'أدخل رقم هاتفك' +
                                      " : " +
                                      "05" +
                                      'xxxxxxxx',
                                  fillColor: Colors.blueGrey[50],
                                  filled: true,
                                  // icon: Icon(Icons.phone_android),
                                  labelStyle: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Bahij',
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Bahij',
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(right: 30, left: 30),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blueGrey[50],
                                      ),
                                      borderRadius: BorderRadius.circular(15)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blueGrey[50],
                                      ),
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width:
                              ((MediaQuery.of(context).size.width / 2) - 40) /
                                  2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blue[100],
                                    spreadRadius: 10,
                                    blurRadius: 20)
                              ]),
                          child: ElevatedButton(
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              child: Center(
                                  child: Text(
                                "سجل دخول",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Bahij',
                                ),
                              )),
                            ),
                            onPressed: () async {
                              if (phoneNo == null || phoneNo == '') {
                                setState(() {
                                  error1 = true;
                                });
                              } else {
                                var test = await _firestore
                                    .collection('users')
                                    .doc(phoneNo.replaceAll(' ', ''))
                                    .get();
                                if (test.exists == true) {
                                  String name;
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(phoneNo.replaceAll(' ', ''))
                                      .get()
                                      .then(
                                          (DocumentSnapshot documentSnapshot) =>
                                              {
                                                name = documentSnapshot
                                                    .data()['Name'],
                                              });
                                  savePhoneNumber(phoneNo.replaceAll(' ', ''));
                                  saveName(name);
                                  saveLogin(true);
                                  locator<NavigationService>()
                                      .navigateTo(HomeRoute);
                                } else {
                                  setState(() {
                                    error1 = false;
                                    error2 = true;
                                  });
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF2980b9),
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ).mouseUpOnHover,
                        (error1 == true)
                            ? Container(
                                width:
                                    ((MediaQuery.of(context).size.width / 2) -
                                            40) /
                                        2,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "الرجاء ادخال المعلومات بشكل صحيح",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                      fontFamily: 'Bahij',
                                    ),
                                  ),
                                ),
                              )
                            : (error2)
                                ? Container(
                                    width: ((MediaQuery.of(context).size.width /
                                                2) -
                                            40) /
                                        2,
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "رقم الهاتف غير مسجل في قاعدة البيانات برجاء انشاء حساب",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.red,
                                          fontFamily: 'Bahij',
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 40,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "سجل دخولك الان \nلموقع نظره",
                            style: TextStyle(
                                fontFamily: 'Bahij',
                                fontSize: 50,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "إذا كنت لا تملك حساب",
                            style: TextStyle(
                                fontFamily: 'Bahij',
                                fontSize: 30,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              locator<NavigationService>()
                                  .navigateTo(SignupRoute);
                            },
                            child: Text(
                              "!يمكنك أنشاء حساب في موقع نظره الان",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Bahij',
                                  fontSize: 40,
                                  color: Color(0xFF2980b9),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ).showCursorOnHover.mouseUpOnHover,
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100,
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
}
