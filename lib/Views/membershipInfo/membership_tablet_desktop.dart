import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

class MembershipViewTabletDesktop extends StatefulWidget {
  @override
  _MembershipViewTabletDesktopState createState() =>
      _MembershipViewTabletDesktopState();
}

class _MembershipViewTabletDesktopState
    extends State<MembershipViewTabletDesktop> {
  bool tap1 = false;
  bool tap2 = false;

  ScrollController _slidingPage = ScrollController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
            CenteredView(child: NavigationBar(currentRoute: 'Membership')),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF2980b9),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 40,
                    child: Image.asset("assets/images/vectors/membership.png"),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 40,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "عضوية موقع نظره",
                              style: TextStyle(
                                  fontFamily: 'Bahij',
                                  fontSize: 50,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 40,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF2980b9),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/icons/feature.png'))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "مزايا العضوية",
                          style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "العمولة مجانية على الاعلانات المعلن عنها خلال فترة الإشتراك بالاضافة لامكانية تكرار الاعلان اكثر من مره في نفس اليوم",
                            style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 30,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 40,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF2980b9),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/icons/member.png'))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "عن العضوية",
                          style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "هذة العضوية هي عضوية مدفوعة تناسب احتياج كل معلن يقوم بتسويق سلع كثيرة و مرتفعة الثمن مثل السيارات و العقارات",
                            style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 30,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFF2980b9),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/images/icons/money.png'))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "سعر العضوية",
                      style: TextStyle(
                          fontFamily: 'Bahij',
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "اشتراك لمدة سنة بسعر 850 ريال",
                      style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: double.infinity,
                height: 750,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFF2980b9),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/icons/qualification.png'))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "شروط العضوية",
                      style: TextStyle(
                          fontFamily: 'Bahij',
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "عدم الاعلان للغير • ",
                      style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "عدم تكرار الإعلان عن نفس السلعة أكثر من مره خلال يومين • ",
                      style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "عدم التنازل عن العضوية لعضو آخر او بيع العضوية • ",
                      style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "ذكر سعر السلعة • ",
                      style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "الرد على رسائل اعضاء الموقع عبر الرسائل الخاصة • ",
                      style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "الرد على استفسارات اعضاء الموقع عبر الردود • ",
                      style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: double.infinity,
                height: 650,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFF2980b9),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/icons/debit-card.png'))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "طرق الدفع",
                      style: TextStyle(
                          fontFamily: 'Bahij',
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tap1 = !tap1;
                            });
                            FlutterClipboard.copy(
                                'Al-Rajhi Bank\nAccount Number: 471000010006086055873\nIBAN Number: SA4980000471608016055873');
                          },
                          child: Container(
                            width: 500,
                            height: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: (tap1) ? Colors.green : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                            ),
                            child: (tap1)
                                ? Center(
                                    child: Text(
                                      "تم النسخ",
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 50,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/payment_methods/1.png",
                                            height: 100,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "مؤسسة موقع نظره للخدمات التسويقية",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "رقم الحساب",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "471000010006086055873",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Color(0xFF2980b9),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "رقم الايبان",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "SA4980000471608016055873",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Color(0xFF2980b9),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                          ).showCursorOnHover.mouseUpOnHover,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tap2 = !tap2;
                            });
                            FlutterClipboard.copy(
                                'National Commercial Bank\nAccount Number: 18700000322007\nIBAN Number: SA10000018700000322007');
                          },
                          child: Container(
                            width: 500,
                            height: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: (tap2) ? Colors.green : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                            ),
                            child: (tap2)
                                ? Center(
                                    child: Text(
                                      "تم النسخ",
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 50,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/payment_methods/ncb.png",
                                            height: 100,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "مؤسسة موقع نظره للخدمات التسويقية",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "رقم الحساب",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "18700000322007",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Color(0xFF2980b9),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "رقم الايبان",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "SA10000018700000322007",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Color(0xFF2980b9),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                          ).showCursorOnHover.mouseUpOnHover,
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
}
