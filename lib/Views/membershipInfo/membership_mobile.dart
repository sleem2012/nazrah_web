import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sizer/sizer.dart';

class MembershipViewMobile extends StatefulWidget {
  @override
  _MembershipViewMobileState createState() => _MembershipViewMobileState();
}

class _MembershipViewMobileState extends State<MembershipViewMobile> {
  bool tap1 = false;
  bool tap2 = false;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<DocumentSnapshot> loadAppInfo() {
    return _firestore.collection('info').doc('app').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CenteredView(child: NavigationBar(currentRoute: 'Membership')),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
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
                        Text(
                          "عضوية موقع نظره",
                          style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 18.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
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
                        width: 100,
                        height: 100,
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
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "العمولة مجانية على الاعلانات المعلن عنها خلال فترة الإشتراك بالاضافة لامكانية تكرار الاعلان اكثر من مره في نفس اليوم",
                          style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.end,
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
                        width: 100,
                        height: 100,
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
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "هذة العضوية هي عضوية مدفوعة تناسب احتياج كل معلن يقوم بتسويق سلع كثيرة و مرتفعة الثمن مثل السيارات و العقارات",
                          style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.end,
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
                        fontSize: 18.sp,
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
                      fontSize: 18.sp,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
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
              height: 550,
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
                        fontSize: 18.sp,
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
                      fontSize: 12.sp,
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
                      fontSize: 12.sp,
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
                      fontSize: 12.sp,
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
                      fontSize: 12.sp,
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
                      fontSize: 12.sp,
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
                      fontSize: 20,
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
              height: 900,
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
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
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
                          width: MediaQuery.of(context).size.width - 60,
                          padding: EdgeInsets.only(top: 20, bottom: 20),
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
                                        fontSize: 18.sp,
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
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        "رقم الحساب",
                                        style: TextStyle(
                                            fontFamily: 'Bahij',
                                            fontSize: 12.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        "471000010006086055873",
                                        style: TextStyle(
                                            fontFamily: 'Bahij',
                                            fontSize: 12.sp,
                                            color: Color(0xFF2980b9),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        "رقم الايبان",
                                        style: TextStyle(
                                            fontFamily: 'Bahij',
                                            fontSize: 12.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        "SA4980000471608016055873",
                                        style: TextStyle(
                                            fontFamily: 'Bahij',
                                            fontSize: 12.sp,
                                            color: Color(0xFF2980b9),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                        ).showCursorOnHover.mouseUpOnHover,
                      ),
                      SizedBox(
                        height: 30,
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
                          width: MediaQuery.of(context).size.width - 60,
                          padding: EdgeInsets.only(top: 20, bottom: 20),
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
                                        fontSize: 18.sp,
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
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        "رقم الحساب",
                                        style: TextStyle(
                                            fontFamily: 'Bahij',
                                            fontSize: 12.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        "18700000322007",
                                        style: TextStyle(
                                            fontFamily: 'Bahij',
                                            fontSize: 12.sp,
                                            color: Color(0xFF2980b9),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        "رقم الايبان",
                                        style: TextStyle(
                                            fontFamily: 'Bahij',
                                            fontSize: 12.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        "SA10000018700000322007",
                                        style: TextStyle(
                                            fontFamily: 'Bahij',
                                            fontSize: 12.sp,
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
    );
  }
}
