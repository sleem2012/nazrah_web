import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:sizer/sizer.dart';

class ContactViewMobile extends StatefulWidget {
  @override
  _ContactViewMobileState createState() => _ContactViewMobileState();
}

class _ContactViewMobileState extends State<ContactViewMobile> {
  String name, phoneNum, message;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool done = false;
  bool error = false;
  bool writing2 = false;
  var textDirection = TextDirection.rtl;

  Stream<DocumentSnapshot> loadAppInfo() {
    return _firestore.collection('info').doc('app').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CenteredView(child: NavigationBar(currentRoute: 'Contact')),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
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
                        'assets/images/vectors/contact.png',
                        height: 250,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            onChanged: (val) {
                              name = val;
                            },
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Bahij',
                            ),
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                                hintText: 'أدخل اسمك',
                                fillColor: Colors.blueGrey[50],
                                filled: true,
                                //icon: Icon(Icons.person),
                                labelStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Bahij',
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Bahij',
                                ),
                                contentPadding: EdgeInsets.only(right: 30),
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
                        width: MediaQuery.of(context).size.width / 2,
                        child: Directionality(
                          textDirection: (writing2 == false)
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          child: TextField(
                            onChanged: (val) {
                              if (val != '') {
                                setState(() {
                                  writing2 = true;
                                });
                              } else {
                                setState(() {
                                  writing2 = false;
                                });
                              }
                              phoneNum = val;
                            },
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Bahij',
                            ),
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'أدخل رقم هاتفك',
                                fillColor: Colors.blueGrey[50],
                                filled: true,
                                //icon: Icon(Icons.phone_android),
                                labelStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Bahij',
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Bahij',
                                ),
                                contentPadding: EdgeInsets.only(right: 30),
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
                        width: MediaQuery.of(context).size.width / 2,
                        child: Directionality(
                          textDirection: textDirection,
                          child: TextField(
                            onChanged: (val) {
                              RegExp exp = RegExp("[a-zA-Z]");
                              if (exp.hasMatch(val.substring(val.length - 1)) &&
                                  val.substring(val.length - 1) != " ") {
                                setState(() {
                                  textDirection = TextDirection.ltr;
                                });
                              } else if (val.substring(val.length - 1) != " " &&
                                  !exp.hasMatch(
                                      val.substring(val.length - 1))) {
                                setState(() {
                                  textDirection = TextDirection.rtl;
                                });
                              }
                              message = val;
                            },
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Bahij',
                            ),
                            textAlign: TextAlign.right,
                            maxLines: 5,
                            decoration: InputDecoration(
                                hintText: 'أستفسارك',
                                fillColor: Colors.blueGrey[50],
                                filled: true,
                                //icon: Icon(Icons.contact_support),
                                labelStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Bahij',
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Bahij',
                                ),
                                contentPadding: EdgeInsets.only(
                                    right: 30, left: 30, top: 10, bottom: 10),
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
                        width: MediaQuery.of(context).size.width / 2,
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
                              "أرسل",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Bahij',
                              ),
                            )),
                          ),
                          onPressed: () async {
                            if (name == null ||
                                phoneNum == null ||
                                message == null) {
                            } else {
                              final dateTime = DateTime.now();
                              _firestore
                                  .collection('inquires')
                                  .doc(dateTime.toString())
                                  .set({
                                'name': name,
                                'phone number': phoneNum,
                                'message': message,
                                'datetime': dateTime
                              });
                              setState(() {
                                error = false;
                                done = true;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ).mouseUpOnHover,
                      (error)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "!برجاء ادخال جميع المعلومات المطلوبة",
                                style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 12.sp,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.end,
                              ),
                            )
                          : (done)
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    "!لقد تلقينا استفسارك",
                                    style: TextStyle(
                                        fontFamily: 'Bahij',
                                        fontSize: 12.sp,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.end,
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
                          "تواصل معنا الان",
                          style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 18.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "من خلال",
                          style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 12.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   "واتساب: 0509020021",
                        //   style: TextStyle(
                        //       //decoration: TextDecoration.underline,
                        //       fontFamily: 'Bahij',
                        //       fontSize: 12.sp,
                        //       color: Color(0xFF2980b9),
                        //       fontWeight: FontWeight.bold),
                        //   textAlign: TextAlign.right,
                        // ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "info@nazrahsa.com :ايميل",
                          style: TextStyle(
                              //decoration: TextDecoration.underline,
                              fontFamily: 'Bahij',
                              fontSize: 12.sp,
                              color: Color(0xFF2980b9),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                launch("https://wa.me/9660509020021");
                              },
                              child: Image.asset(
                                'assets/images/icons/whatsapp (1).png',
                                height: 3.h,
                              ).mouseUpOnHover.showCursorOnHover,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            GestureDetector(
                              onTap: () {
                                launch("https://www.instagram.com/nazrahsa/");
                              },
                              child: Image.asset(
                                'assets/images/icons/instagram.png',
                                height: 3.h,
                              ).mouseUpOnHover.showCursorOnHover,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            GestureDetector(
                              onTap: () {
                                launch("https://twitter.com/NazrahSA");
                              },
                              child: Image.asset(
                                      'assets/images/icons/twitter.png',
                                      height: 3.h)
                                  .mouseUpOnHover
                                  .showCursorOnHover,
                            ),
                          ],
                        )
                        // Text(
                        //   "NazrahSA :الانستغرام",
                        //   style: TextStyle(
                        //       //decoration: TextDecoration.underline,
                        //       fontFamily: 'Bahij',
                        //       fontSize: 20,
                        //       color: Color(0xFF2980b9),
                        //       fontWeight: FontWeight.bold),
                        //   textAlign: TextAlign.right,
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Text(
                        //   "NazrahSA :تويتر",
                        //   style: TextStyle(
                        //       //decoration: TextDecoration.underline,
                        //       fontFamily: 'Bahij',
                        //       fontSize: 20,
                        //       color: Color(0xFF2980b9),
                        //       fontWeight: FontWeight.bold),
                        //   textAlign: TextAlign.right,
                        // ),
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
        ],
      ),
    );
  }
}
