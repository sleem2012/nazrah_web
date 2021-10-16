

import 'dart:async';

import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nazarih/services/firebase_storage.dart';
import 'package:nazarih/widgets/search_widget/SearchWidget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

class PanelHome extends StatefulWidget {
  @override
  _PanelHomeState createState() => _PanelHomeState();
}

List<bool> selected = [true, false, false, false, false, false];

class UserInfo {
  String phoneNo, username, documentId, membership, commission;

  UserInfo(
      {this.phoneNo,
        this.documentId,
        this.username,
        this.membership,
        this.commission});
}

class InquiryInfo {
  String phoneNo, username, documentId, message;

  InquiryInfo({
    this.phoneNo,
    this.documentId,
    this.username,
    this.message,
  });
}

class AdsInfo {
  String title, category, country, username, user, docID;

  AdsInfo(
      {this.title,
        this.category,
        this.country,
        this.username,
        this.user,
        this.docID});
}

class DelegateInfo {
  String name, id, country, email, phone, imageCount, docID;

  DelegateInfo(
      {this.name,
        this.id,
        this.country,
        this.email,
        this.phone,
        this.imageCount,
        this.docID});
}

class _PanelHomeState extends State<PanelHome> {
  ScrollController _slidingPage = ScrollController();
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.clear();
    resultsMemberShip.clear();
    super.dispose();
  }

  List<UserInfo> users = [];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<IconData> icon = [
    Feather.home,
    Feather.users,
    Feather.database,
    Feather.inbox,
    Feather.pen_tool,
    Feather.settings,
  ];
  int user = 0;
  int events = 0;

  void select(int n) {
    for (int i = 0; i < 6; i++) {
      if (i == n) {
        selected[i] = true;
      } else {
        selected[i] = false;
      }
    }
  }

  Stream<QuerySnapshot> loadUsers() {
    return _firestore.collection('users').snapshots();
  }

  Stream<QuerySnapshot> loadInquires() {
    return _firestore.collection('inquires').snapshots();
  }

  Stream<QuerySnapshot> loadDelegates() {
    return _firestore.collection('delegate').snapshots();
  }

  Stream<QuerySnapshot> loadEvents() {
    return _firestore.collection('ads').snapshots();
  }

  List selectedUser = [];
  List resultsMemberShip = [];
  List selectedAd = [];

  Stream<DocumentSnapshot> loadBanners() {
    return _firestore.collection('info').doc('banners').snapshots();
  }

  String iphone, android;

  bool wait = false;
  bool wait2 = false;
  bool wait3 = false;
  bool wait4 = false;
  final dateTime = DateTime.now();
  var path;

  @override
  void initState() {
    path = '/default/ads/ads-$dateTime';
    super.initState();

    super.initState();
    _slidingPage = ScrollController();
    Timer(
        Duration(seconds: 5),
            () => _slidingPage.animateTo(_slidingPage.offset + 0.1,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: VsScrollbar(
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
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  height: MediaQuery.of(context).size.height,
                  width: 101,
                  decoration: BoxDecoration(
                      color: Color(0xFF2980b9),
                      borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 110,
                          child: Column(
                            children: icon
                                .map((e) => NavBarItem(
                              icon: e,
                              selected: selected[icon.indexOf(e)],
                              onTap: () {
                                setState(() {
                                  select(icon.indexOf(e));
                                });
                              },
                            ))
                                .toList(),
                          ))
                    ],
                  ),
                ),
                (selected[0] == true)
                    ? Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 125, right: 125),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "مرحبا!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 45),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 80,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        4,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF2980b9),
                                              Colors.lightBlue
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[300],
                                              offset: Offset(0, 3),
                                              blurRadius: 16)
                                        ]),
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: loadUsers(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    title: CustomText(
                                                      text: "المستخدمين",
                                                      size: 25,
                                                      weight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    subtitle: CustomText(
                                                      text:
                                                      "كم حساب تم انشاءه",
                                                      size: 16,
                                                      weight:
                                                      FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(left: 14),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      CustomText(
                                                        text: "0",
                                                        size: 25,
                                                        weight: FontWeight
                                                            .bold,
                                                        color:
                                                        Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            user =
                                                snapshot.data.docs.length;
                                            return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    title: CustomText(
                                                      text: "المستخدمين",
                                                      size: 25,
                                                      weight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    subtitle: CustomText(
                                                        text:
                                                        "كم حساب تم انشاءه",
                                                        size: 16,
                                                        weight: FontWeight
                                                            .w400,
                                                        color:
                                                        Colors.black),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(left: 14),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      CustomText(
                                                        text: user
                                                            .toString(),
                                                        size: 25,
                                                        weight: FontWeight
                                                            .bold,
                                                        color:
                                                        Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        }),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 80,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        4,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF2980b9),
                                              Colors.lightBlue
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[300],
                                              offset: Offset(0, 3),
                                              blurRadius: 16)
                                        ]),
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: loadEvents(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    title: CustomText(
                                                      text: "الاعلانات",
                                                      size: 25,
                                                      weight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    subtitle: CustomText(
                                                      text:
                                                      "كم اعلان تم انشاءه",
                                                      size: 16,
                                                      weight:
                                                      FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(left: 14),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      CustomText(
                                                        text: "0",
                                                        size: 25,
                                                        weight: FontWeight
                                                            .bold,
                                                        color:
                                                        Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            events =
                                                snapshot.data.docs.length;
                                            return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    title: CustomText(
                                                      text: "الاعلانات",
                                                      size: 25,
                                                      weight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    subtitle: CustomText(
                                                      text:
                                                      "كم اعلان تم انشاءه",
                                                      size: 16,
                                                      weight:
                                                      FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(left: 14),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      CustomText(
                                                        text: events
                                                            .toString(),
                                                        size: 25,
                                                        weight: FontWeight
                                                            .bold,
                                                        color:
                                                        Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        }),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 80,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        4,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF2980b9),
                                              Colors.lightBlue
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[300],
                                              offset: Offset(0, 3),
                                              blurRadius: 16)
                                        ]),
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: loadInquires(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    title: CustomText(
                                                      text: "الاستفسارات",
                                                      size: 25,
                                                      weight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    subtitle: CustomText(
                                                      text:
                                                      "كم استفسار مرسل",
                                                      size: 16,
                                                      weight:
                                                      FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(left: 14),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      CustomText(
                                                        text: "0",
                                                        size: 25,
                                                        weight: FontWeight
                                                            .bold,
                                                        color:
                                                        Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            user =
                                                snapshot.data.docs.length;
                                            return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    title: CustomText(
                                                      text: "الاستفسارات",
                                                      size: 25,
                                                      weight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    subtitle: CustomText(
                                                      text:
                                                      "كم استفسار مرسل",
                                                      size: 16,
                                                      weight:
                                                      FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(left: 14),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      CustomText(
                                                        text: user
                                                            .toString(),
                                                        size: 25,
                                                        weight: FontWeight
                                                            .bold,
                                                        color:
                                                        Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 80,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        4,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF2980b9),
                                              Colors.lightBlue
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[300],
                                              offset: Offset(0, 3),
                                              blurRadius: 16)
                                        ]),
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: loadDelegates(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    title: CustomText(
                                                      text: "المندوبين",
                                                      size: 25,
                                                      weight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    subtitle: CustomText(
                                                      text:
                                                      "كم طلب تم ارساله",
                                                      size: 16,
                                                      weight:
                                                      FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(left: 14),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      CustomText(
                                                        text: "0",
                                                        size: 25,
                                                        weight: FontWeight
                                                            .bold,
                                                        color:
                                                        Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            user =
                                                snapshot.data.docs.length;
                                            return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    title: CustomText(
                                                      text: "المندوبين",
                                                      size: 25,
                                                      weight:
                                                      FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    subtitle: CustomText(
                                                      text:
                                                      "كم طلب تم ارساله",
                                                      size: 16,
                                                      weight:
                                                      FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(left: 14),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      CustomText(
                                                        text: user
                                                            .toString(),
                                                        size: 25,
                                                        weight: FontWeight
                                                            .bold,
                                                        color:
                                                        Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                    : (selected[1] == true)
                    ? Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 125, right: 125),
                  child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "المستخدمين",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 45),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 250,
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: TextFormField(
                                        controller: searchController,
                                        onChanged: (v) {
                                          setState(() {
                                            resultsMemberShip = users
                                                .where(
                                                  (e) => e.phoneNo
                                                  .startsWith(
                                                v,
                                              ),
                                            )
                                                .toList();
                                            print(
                                                resultsMemberShip.length);
                                          });
                                        },
                                        decoration: InputDecoration(
                                            labelText:
                                            'ادخل رقم المستخدم',
                                            contentPadding:
                                            EdgeInsets.only(
                                                right: 10),
                                            suffixIcon:
                                            Icon(Icons.search_sharp),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                RaisedButton.icon(
                                    onPressed: () async {
                                      for (var i = 0;
                                      i < selectedUser.length;
                                      i++) {
                                        _firestore
                                            .collection('users')
                                            .doc(selectedUser[i])
                                            .delete();
                                        await _firestore
                                            .collection('ChatRoom')
                                          ..where("users",
                                              arrayContains:
                                              selectedUser[i])
                                              .get()
                                              .then((QuerySnapshot
                                          snapshot) {
                                            for (var doc
                                            in snapshot.docs) {
                                              _firestore
                                                  .collection('ChatRoom')
                                                  .doc(doc.id)
                                                  .delete();
                                            }
                                          });
                                        await _firestore
                                            .collection('ads')
                                            .where('user',
                                            isEqualTo:
                                            selectedUser[i])
                                            .get()
                                            .then(
                                                (QuerySnapshot snapshot) {
                                              for (var doc in snapshot.docs) {
                                                _firestore
                                                    .collection('ads')
                                                    .doc(doc.id)
                                                    .delete();
                                              }
                                            });
                                      }
                                    },
                                    icon: Icon(Icons.remove),
                                    label: Text("مسح المستخدم")),
                                SizedBox(
                                  width: 10,
                                ),
                                RaisedButton.icon(
                                    onPressed: () {
                                      for (var i = 0;
                                      i < selectedUser.length;
                                      i++) {
                                        _firestore.collection('users').doc(selectedUser[i]).update({'Membership': 'free'});
                                        _firestore.collection('users').doc(selectedUser[i]).get().then((value) {
                                          print(value.data()['Membership'] +" is " + value.data()['Name']);
                                          FirebaseFirestore.instance.collection('ads').where('user', isEqualTo: value.data()['Phone Number']).get().then((QuerySnapshot snapshot) => {
                                            snapshot.docs.forEach((element) {
                                              print(element.id);
                                              _firestore.collection('ads').doc(element.id).update({
                                                'Membership': 'free',
                                              });
                                              print(element['Membership']);
                                            })
                                          });
                                        });

                                      }
                                    },
                                    icon: Icon(Icons.change_history),
                                    label: Text("عضوية مجانية")),
                                SizedBox(
                                  width: 10,
                                ),
                                RaisedButton.icon(
                                    onPressed: () {
                                      for (var i = 0;
                                      i < selectedUser.length; i++) {
                                        _firestore.collection('users').doc(selectedUser[i]).update({'Membership': 'Premium'});

                                        _firestore.collection('users').doc(selectedUser[i]).get().then((value) {
                                          print(value.data()['Membership'] +" is " + value.data()['Name']);
                                          FirebaseFirestore.instance.collection('ads').where('user', isEqualTo: value.data()['Phone Number']).get().then((QuerySnapshot snapshot) => {
                                            snapshot.docs.forEach((element) {
                                              print(element.id);
                                              _firestore.collection('ads').doc(element.id).update({
                                                'Membership': 'Premium',
                                              });
                                              print(element['Membership']);
                                            })
                                          });
                                        });


                                      }
                                    },
                                    icon: Icon(Icons.card_membership),
                                    label: Text(
                                        "عضوية السيارات والسلع المتكرره")),
                                SizedBox(
                                  width: 10,
                                ),
                                RaisedButton.icon(
                                    onPressed: () {
                                      for (var i = 0;
                                      i < selectedUser.length;
                                      i++) {
                                        _firestore
                                            .collection('users')
                                            .doc(selectedUser[i])
                                            .update(
                                            {'Commission': 'unpaid'});
                                      }
                                    },
                                    icon: Icon(Icons.money_off),
                                    label: Text("لم يدفع العمولة")),
                                SizedBox(
                                  width: 10,
                                ),
                                RaisedButton.icon(
                                    onPressed: () {
                                      for (var i = 0; i < selectedUser.length; i++) {
                                        _firestore.collection('users').doc(selectedUser[i]).update({'Commission': 'Paid'});

                                      }
                                    },
                                    icon: Icon(Icons.money),
                                    label: Text("تم دفع العمولة")),
                              ],
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: loadUsers(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data.docs.length == 0) {
                                  return Center(
                                    child: Text(
                                        "لا يوجد مستخدمين فالوقت الحالي"),
                                  );
                                } else {
                                  if (users.isEmpty)
                                    for (var doc in snapshot.data.docs) {
                                      users.add(UserInfo(
                                          documentId: doc.id,
                                          phoneNo:
                                          doc.data()['Phone Number'],
                                          username: doc.data()['Name'],
                                          commission:
                                          (doc.data()['Commission'] ==
                                              'Paid')
                                              ? 'تم دفع عمولة'
                                              : 'لم يدفع عمولة',
                                          membership: (doc.data()[
                                          'Membership'] ==
                                              'Premium')
                                              ? 'معارض السيارات والسلع المتكرره'
                                              : 'مجانية'));


                                    }
                                  return Padding(
                                    padding: EdgeInsets.all(40),
                                    child: VsScrollbar(
                                      controller: _slidingPage,
                                      isAlwaysShown: true,
                                      showTrackOnHover: true,
                                      style: VsScrollbarStyle(
                                        hoverThickness: 10.0,
                                        // default 12.0
                                        radius: Radius.circular(10),
                                        // default Radius.circular(8.0)
                                        thickness: 10.0,
                                        // [ default 8.0 ]
                                        color: Color(
                                            0xFF2980b9), // default ColorScheme Theme
                                      ),
                                      child: SingleChildScrollView(
                                        controller: _slidingPage,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          child: DataTable(
                                            dividerThickness: 5,
                                            columns: [
                                              DataColumn(
                                                  label: Text('الاسم'),
                                                  tooltip:
                                                  'يظهر اسم المستخدم المسجل من المستخدم'),
                                              DataColumn(
                                                  label:
                                                  Text('رقم الهاتف'),
                                                  tooltip:
                                                  'يظهر رقم الهاتف السمجل من المستخدم'),
                                              DataColumn(
                                                  label: Text('العضوية'),
                                                  tooltip:
                                                  'يظهر نوع عضوية المستخدم'),
                                              DataColumn(
                                                  label: Text('العمولة'),
                                                  tooltip:
                                                  'يظهر اذا كان المستخدم دفع عمولة من قبل ام لا'),
                                            ],
                                            rows:
                                            searchController.text !=
                                                ""
                                                ? resultsMemberShip
                                                .map(
                                                    (e) =>
                                                    DataRow(
                                                      selected:
                                                      selectedUser.contains(e.documentId),
                                                      onSelectChanged:
                                                          (isSelected) =>
                                                          setState(() {
                                                            final isAdding =
                                                                isSelected != null && isSelected;
                                                            isAdding
                                                                ? selectedUser.add(e.documentId)
                                                                : selectedUser.remove(e.documentId);
                                                          }),
                                                      cells: [
                                                        DataCell(
                                                          Text(e.username),
                                                        ),
                                                        DataCell(
                                                            Text(e.phoneNo)),
                                                        DataCell(
                                                            Text(e.membership)),
                                                        DataCell(
                                                            Text(e.commission))
                                                      ],
                                                    ))
                                                .toList()
                                                : users
                                                .map(
                                                    (e) =>
                                                    DataRow(
                                                      selected:
                                                      selectedUser.contains(e.documentId),
                                                      onSelectChanged:
                                                          (isSelected) =>
                                                          setState(() {
                                                            final isAdding =
                                                                isSelected != null && isSelected;
                                                            isAdding
                                                                ? selectedUser.add(e.documentId)
                                                                : selectedUser.remove(e.documentId);
                                                          }),
                                                      cells: [
                                                        DataCell(
                                                          Text(e.username),
                                                        ),
                                                        DataCell(
                                                            Text(e.phoneNo)),
                                                        DataCell(
                                                            Text(e.membership)),
                                                        DataCell(
                                                            Text(e.commission))
                                                      ],
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            )
                          ])),
                )
                    : (selected[2] == true)
                    ? Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 125, right: 125),
                  child: Container(
                      child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "الاعلانات",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RaisedButton.icon(
                                onPressed: () {
                                  for (var i = 0;
                                  i < selectedAd.length;
                                  i++) {
                                    _firestore
                                        .collection('ads')
                                        .doc(selectedAd[i])
                                        .delete();
                                  }
                                },
                                icon: Icon(Icons.remove),
                                label: Text("مسح الاعلان")),
                            SizedBox(
                              height: 20,
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: loadEvents(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData ||
                                      snapshot.data.docs.length ==
                                          0) {
                                    return Center(
                                      child: Text(
                                          "لا توجد اعلانات فالوقت الحالي"),
                                    );
                                  } else {
                                    List<AdsInfo> ads = [];

                                    for (var doc
                                    in snapshot.data.docs) {
                                      ads.add(AdsInfo(
                                          docID: doc.id,
                                          title: doc.data()['Title'],
                                          category: doc.data()[
                                          'selectedCategory'],
                                          country:
                                          doc.data()['Country'],
                                          user: doc.data()['user'],
                                          username: doc
                                              .data()['userName']));
                                    }

                                    return Padding(
                                      padding: EdgeInsets.all(20),
                                      child: VsScrollbar(
                                        controller: _slidingPage,
                                        showTrackOnHover: true,
                                        // default false
                                        isAlwaysShown: true,
                                        // default false
                                        scrollbarFadeDuration:
                                        Duration(
                                            milliseconds: 500),
                                        // default : Duration(milliseconds: 300)
                                        scrollbarTimeToFade: Duration(
                                            milliseconds: 800),
                                        // default : Duration(milliseconds: 600)
                                        style: VsScrollbarStyle(
                                          hoverThickness: 10.0,
                                          // default 12.0
                                          radius: Radius.circular(10),
                                          // default Radius.circular(8.0)
                                          thickness: 10.0,
                                          // [ default 8.0 ]
                                          color: Colors.purple
                                              .shade900, // default ColorScheme Theme
                                        ),
                                        child: SingleChildScrollView(
                                          controller: _slidingPage,
                                          child: Container(
                                            width:
                                            MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: DataTable(
                                              dividerThickness: 5,
                                              columns: [
                                                DataColumn(
                                                    label: Text(
                                                        'عنوان الاعلان'),
                                                    tooltip:
                                                    'يظهر عنوان الاعلان'),
                                                DataColumn(
                                                    label: Text(
                                                        'تصنيف الاعلان'),
                                                    tooltip:
                                                    'يظهر تصنيف الاعلان'),
                                                DataColumn(
                                                    label: Text(
                                                        'المدينة'),
                                                    tooltip:
                                                    'يظهر المدينة المستهدفة من الاعلان'),
                                                DataColumn(
                                                    label: Text(
                                                        'اسم المعلن'),
                                                    tooltip:
                                                    'يظهر اسم المعلن'),
                                                DataColumn(
                                                    label: Text(
                                                        'هاتف المعلن'),
                                                    tooltip:
                                                    'يظهر هاتف المعلن'),
                                              ],
                                              rows: ads
                                                  .map((e) => DataRow(
                                                  selected: selectedAd
                                                      .contains(e
                                                      .docID),
                                                  onSelectChanged:
                                                      (isSelected) =>
                                                      setState(() {
                                                        final isAdding = isSelected != null && isSelected;
                                                        isAdding ? selectedAd.add(e.docID) : selectedAd.remove(e.docID);
                                                      }),
                                                  cells: [
                                                    DataCell(
                                                        Text(e
                                                            .title),
                                                        onTap:
                                                            () {
                                                          launch(
                                                              'https://nazrahsa.com/#/adDetails?id=${e.docID}');
                                                        }),
                                                    DataCell(
                                                        Text(e
                                                            .category)),
                                                    DataCell(
                                                        Text(e
                                                            .country)),
                                                    DataCell(
                                                        Text(e
                                                            .username)),
                                                    DataCell(
                                                        Text(e
                                                            .user)),
                                                  ]))
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          ])),
                )
                    : (selected[3] == true)
                    ? Padding(
                  padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 125,
                      right: 125),
                  child: Container(
                      child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "الاستفسارات",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Row(
                            //   children: [
                            //     RaisedButton.icon(
                            //         onPressed: () {
                            //           for (var i = 0;
                            //               i < selectedUser.length;
                            //               i++) {
                            //             _firestore
                            //                 .collection('users')
                            //                 .doc(selectedUser[i])
                            //                 .delete();
                            //           }
                            //         },
                            //         icon: Icon(Icons.remove),
                            //         label: Text("مسح المستخدم")),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     RaisedButton.icon(
                            //         onPressed: () {
                            //           for (var i = 0;
                            //               i < selectedUser.length;
                            //               i++) {
                            //             _firestore
                            //                 .collection('users')
                            //                 .doc(selectedUser[i])
                            //                 .update({'Membership': 'free'});
                            //           }
                            //         },
                            //         icon: Icon(Icons.change_history),
                            //         label: Text("عضوية مجانية")),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     RaisedButton.icon(
                            //         onPressed: () {
                            //           for (var i = 0;
                            //               i < selectedUser.length;
                            //               i++) {
                            //             _firestore
                            //                 .collection('users')
                            //                 .doc(selectedUser[i])
                            //                 .update(
                            //                     {'Membership': 'Premium'});
                            //           }
                            //         },
                            //         icon: Icon(Icons.card_membership),
                            //         label: Text(
                            //             "عضوية السيارات والسلع المتكرره")),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     RaisedButton.icon(
                            //         onPressed: () {
                            //           for (var i = 0;
                            //               i < selectedUser.length;
                            //               i++) {
                            //             _firestore
                            //                 .collection('users')
                            //                 .doc(selectedUser[i])
                            //                 .update({'Commission': 'unpaid'});
                            //           }
                            //         },
                            //         icon: Icon(Icons.money_off),
                            //         label: Text("لم يدفع العمولة")),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     RaisedButton.icon(
                            //         onPressed: () {
                            //           for (var i = 0;
                            //               i < selectedUser.length;
                            //               i++) {
                            //             _firestore
                            //                 .collection('users')
                            //                 .doc(selectedUser[i])
                            //                 .update({'Commission': 'Paid'});
                            //           }
                            //         },
                            //         icon: Icon(Icons.money),
                            //         label: Text("تم دفع العمولة")),
                            //   ],
                            // ),
                            StreamBuilder<QuerySnapshot>(
                              stream: loadInquires(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data.docs.length ==
                                        0) {
                                  return Center(
                                    child: Text(
                                        "لا يوجد استفسارات فالوقت الحالي"),
                                  );
                                } else {
                                  List<InquiryInfo> inquires = [];

                                  for (var doc
                                  in snapshot.data.docs) {
                                    inquires.add(InquiryInfo(
                                        documentId: doc.id,
                                        phoneNo: doc.data()[
                                        'phone number'],
                                        username:
                                        doc.data()['name'],
                                        message: doc
                                            .data()['message']));
                                  }
                                  return Padding(
                                    padding: EdgeInsets.all(20),
                                    child: SingleChildScrollView(
                                      scrollDirection:
                                      Axis.vertical,
                                      child: Container(
                                        width:
                                        MediaQuery.of(context)
                                            .size
                                            .width,
                                        child:
                                        SingleChildScrollView(
                                          scrollDirection:
                                          Axis.vertical,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .all(8.0),
                                            child: DataTable(
                                              dividerThickness: 3,
                                              columns: [
                                                DataColumn(
                                                    label: Text(
                                                        'الاسم'),
                                                    tooltip:
                                                    'يظهر اسم المستخدم المسجل من المستخدم'),
                                                DataColumn(
                                                    label: Text(
                                                        'رقم الهاتف'),
                                                    tooltip:
                                                    'يظهر رقم الهاتف السمجل من المستخدم'),
                                                DataColumn(
                                                    label: Text(
                                                        'الاستفسار'),
                                                    tooltip:
                                                    'يظهر استفسار المستخدم'),
                                                DataColumn(
                                                  label: Text(
                                                      ' انسخ الاستفسار'),
                                                ),
                                              ],
                                              rows: inquires
                                                  .map(
                                                      (e) =>
                                                      DataRow(
                                                        cells: [
                                                          DataCell(
                                                            Text(e.username),
                                                          ),
                                                          DataCell(
                                                            Text(e.phoneNo),
                                                          ),
                                                          DataCell(Tooltip(
                                                            height: MediaQuery.of(context).size.height * .05,
                                                            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                            message: e.message,
                                                            child: SizedBox(
                                                              width: MediaQuery.of(context).size.width * .1,
                                                              child: Text(
                                                                e.message,
                                                                overflow: TextOverflow.clip,
                                                              ),
                                                            ),
                                                          )),
                                                          DataCell(InkWell(child: Icon(Icons.copy),onTap: (){
                                                            FlutterClipboard.copy(e.message);
                                                          },))
                                                        ],
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            )
                          ])),
                )
                    : (selected[4] == true)
                    ? Padding(
                  padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 125,
                      right: 125),
                  child: Container(
                      child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.all(8.0),
                              child: Text(
                                "طلبات تسجيل مندوبين",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: 45),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: loadDelegates(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data.docs
                                        .length ==
                                        0) {
                                  return Center(
                                    child: Text(
                                        "لا يوجد طلبات فالوقت الحالي"),
                                  );
                                } else {
                                  List<DelegateInfo>
                                  delegates = [];

                                  for (var doc
                                  in snapshot.data.docs) {
                                    delegates.add(DelegateInfo(
                                        docID: doc.id,
                                        phone: doc.data()[
                                        'phone number'],
                                        name: doc
                                            .data()['name'],
                                        email: doc
                                            .data()['email'],
                                        country: doc.data()[
                                        'country'],
                                        id: doc.data()['id'],
                                        imageCount: doc
                                            .data()[
                                        'imageCount']
                                            .toString()));
                                  }
                                  return Padding(
                                    padding:
                                    EdgeInsets.all(20),
                                    child: VsScrollbar(
                                      child:
                                      SingleChildScrollView(
                                        child: Container(
                                          width:
                                          MediaQuery.of(
                                              context)
                                              .size
                                              .width,
                                          child: DataTable(
                                            dividerThickness:
                                            5,
                                            columns: [
                                              DataColumn(
                                                  label: Text(
                                                      'الاسم'),
                                                  tooltip:
                                                  'يظهر اسم المندوب'),
                                              DataColumn(
                                                  label: Text(
                                                      'رقم الهاتف'),
                                                  tooltip:
                                                  'يظهر رقم الهاتف السمجل من المندوب'),
                                              DataColumn(
                                                  label: Text(
                                                      'المدينة'),
                                                  tooltip:
                                                  'يظهر مدينة المندوب'),
                                              DataColumn(
                                                  label: Text(
                                                      'رقم الهوية - الاقامة'),
                                                  tooltip:
                                                  'يظهر رقم الهوية او الاقامة الخاصة بالمندوب'),
                                              DataColumn(
                                                  label: Text(
                                                      'البريد الالكتروني'),
                                                  tooltip:
                                                  'يظهر البريد الالكتروني الخاص بالمندوب'),
                                            ],
                                            rows: delegates
                                                .map((e) =>
                                                DataRow(
                                                  cells: [
                                                    DataCell(
                                                        Text(e.name),
                                                        onTap: () {
                                                          if (e.imageCount != null &&
                                                              e.imageCount != '0') {
                                                            _onDelegatePressed(context, e.docID);
                                                          }
                                                        }),
                                                    DataCell(
                                                        Text(e.phone)),
                                                    DataCell(
                                                        Text(e.country)),
                                                    DataCell(
                                                        Text(e.id)),
                                                    DataCell(Text((e.email != null)
                                                        ? e.email
                                                        : 'لا يوجد')),
                                                  ],
                                                ))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            )
                          ])),
                )
                    : Padding(
                  padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 125,
                      right: 125),
                  child: VsScrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Text(
                              "الاعدادات",
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  fontSize: 45),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Text(
                              "رفع الاعلان الاول",
                              style:
                              TextStyle(fontSize: 45),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(
                                left: 20),
                            child: Container(
                                width:
                                MediaQuery.of(context)
                                    .size
                                    .width,
                                height: 300,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: Color(
                                            0xFF2980b9)),
                                    borderRadius:
                                    BorderRadius
                                        .circular(5)),
                                child: (wait == false)
                                    ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      wait = true;
                                    });

                                    uploadAdToStorage(
                                        1, path);
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Icon(
                                        Icons
                                            .camera_alt,
                                        color: Colors
                                            .grey,
                                        size: 100,
                                      ),
                                      Text(
                                        'رفع صوره',
                                        style: TextStyle(
                                            fontFamily:
                                            'Bahij',
                                            fontSize:
                                            40,
                                            color: Colors
                                                .grey,
                                            fontWeight:
                                            FontWeight.bold),
                                      )
                                    ],
                                  ).showCursorOnHover,
                                )
                                    : StreamBuilder<
                                    DocumentSnapshot>(
                                  stream:
                                  loadBanners(),
                                  builder: (context,
                                      snapshot) {
                                    if (snapshot
                                        .hasData &&
                                        snapshot.data !=
                                            null) {
                                      if (snapshot
                                          .connectionState ==
                                          ConnectionState
                                              .waiting)
                                        return Center(
                                          child:
                                          CircularProgressIndicator(),
                                        );
                                      bool banner1 =
                                          snapshot.data
                                              .data()['ads 1'] ==
                                              path;
                                      return (banner1)
                                          ? Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/icons/checked.png',
                                            height: 100,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '!قد تم رفع الصوره',
                                            style: TextStyle(fontFamily: 'Bahij', fontSize: 40, color: Colors.grey, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                          : Center(
                                        child:
                                        CircularProgressIndicator(),
                                      );
                                    } else {
                                      return Center(
                                        child:
                                        CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Text(
                              "رفع الاعلان الثاني",
                              style:
                              TextStyle(fontSize: 45),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(
                                left: 20),
                            child: Container(
                                width:
                                MediaQuery.of(context)
                                    .size
                                    .width,
                                height: 300,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: Color(
                                            0xFF2980b9)),
                                    borderRadius:
                                    BorderRadius
                                        .circular(5)),
                                child: (wait2 == false)
                                    ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      wait2 = true;
                                    });

                                    uploadAdToStorage(
                                        2, path);
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Icon(
                                        Icons
                                            .camera_alt,
                                        color: Colors
                                            .grey,
                                        size: 100,
                                      ),
                                      Text(
                                        'رفع صوره',
                                        style: TextStyle(
                                            fontFamily:
                                            'Bahij',
                                            fontSize:
                                            40,
                                            color: Colors
                                                .grey,
                                            fontWeight:
                                            FontWeight.bold),
                                      )
                                    ],
                                  ).showCursorOnHover,
                                )
                                    : StreamBuilder<
                                    DocumentSnapshot>(
                                  stream:
                                  loadBanners(),
                                  builder: (context,
                                      snapshot) {
                                    if (snapshot
                                        .hasData &&
                                        snapshot.data !=
                                            null) {
                                      if (snapshot
                                          .connectionState ==
                                          ConnectionState
                                              .waiting)
                                        return Center(
                                          child:
                                          CircularProgressIndicator(),
                                        );
                                      bool banner1 =
                                          snapshot.data
                                              .data()['ads 2'] ==
                                              path;
                                      return (banner1)
                                          ? Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/icons/checked.png',
                                            height: 100,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '!قد تم رفع الصوره',
                                            style: TextStyle(fontFamily: 'Bahij', fontSize: 40, color: Colors.grey, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                          : Center(
                                        child:
                                        CircularProgressIndicator(),
                                      );
                                    } else {
                                      return Center(
                                        child:
                                        CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text(
                          //     "رفع الاعلان الثالث",
                          //     style: TextStyle(fontSize: 45),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(left: 20),
                          //   child: Container(
                          //       width: MediaQuery.of(context)
                          //           .size
                          //           .width,
                          //       height: 300,
                          //       decoration: BoxDecoration(
                          //           border: Border.all(
                          //               width: 4,
                          //               color:
                          //                   Color(0xFF2980b9)),
                          //           borderRadius:
                          //               BorderRadius.circular(
                          //                   5)),
                          //       child: (wait3 == false)
                          //           ? GestureDetector(
                          //               onTap: () {
                          //                 setState(() {
                          //                   wait3 = true;
                          //                 });

                          //                 uploadAdToStorage(
                          //                     3, path);
                          //               },
                          //               child: Column(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment
                          //                         .center,
                          //                 children: [
                          //                   Icon(
                          //                     Icons.camera_alt,
                          //                     color:
                          //                         Colors.grey,
                          //                     size: 100,
                          //                   ),
                          //                   Text(
                          //                     'رفع صوره',
                          //                     style: TextStyle(
                          //                         fontFamily:
                          //                             'Bahij',
                          //                         fontSize: 40,
                          //                         color: Colors
                          //                             .grey,
                          //                         fontWeight:
                          //                             FontWeight
                          //                                 .bold),
                          //                   )
                          //                 ],
                          //               ).showCursorOnHover,
                          //             )
                          //           : StreamBuilder<
                          //               DocumentSnapshot>(
                          //               stream: loadBanners(),
                          //               builder: (context,
                          //                   snapshot) {
                          //                 if (snapshot
                          //                         .hasData &&
                          //                     snapshot.data !=
                          //                         null) {
                          //                   if (snapshot
                          //                           .connectionState ==
                          //                       ConnectionState
                          //                           .waiting)
                          //                     return Center(
                          //                       child:
                          //                           CircularProgressIndicator(),
                          //                     );
                          //                   bool banner1 = snapshot
                          //                               .data
                          //                               .data()[
                          //                           'ads 3'] ==
                          //                       path;
                          //                   return (banner1)
                          //                       ? Column(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment
                          //                                   .center,
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment
                          //                                   .center,
                          //                           children: [
                          //                             Image
                          //                                 .asset(
                          //                               'assets/images/icons/checked.png',
                          //                               height:
                          //                                   100,
                          //                             ),
                          //                             SizedBox(
                          //                               height:
                          //                                   10,
                          //                             ),
                          //                             Text(
                          //                               '!قد تم رفع الصوره',
                          //                               style: TextStyle(
                          //                                   fontFamily:
                          //                                       'Bahij',
                          //                                   fontSize:
                          //                                       40,
                          //                                   color:
                          //                                       Colors.grey,
                          //                                   fontWeight: FontWeight.bold),
                          //                             ),
                          //                           ],
                          //                         )
                          //                       : Center(
                          //                           child:
                          //                               CircularProgressIndicator(),
                          //                         );
                          //                 } else {
                          //                   return Center(
                          //                     child:
                          //                         CircularProgressIndicator(),
                          //                   );
                          //                 }
                          //               },
                          //             )),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text(
                          //     "رفع الاعلان الرابع",
                          //     style: TextStyle(fontSize: 45),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(left: 20),
                          //   child: Container(
                          //       width: MediaQuery.of(context)
                          //           .size
                          //           .width,
                          //       height: 300,
                          //       decoration: BoxDecoration(
                          //           border: Border.all(
                          //               width: 4,
                          //               color:
                          //                   Color(0xFF2980b9)),
                          //           borderRadius:
                          //               BorderRadius.circular(
                          //                   5)),
                          //       child: (wait4 == false)
                          //           ? GestureDetector(
                          //               onTap: () {
                          //                 setState(() {
                          //                   wait4 = true;
                          //                 });

                          //                 uploadAdToStorage(
                          //                     4, path);
                          //               },
                          //               child: Column(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment
                          //                         .center,
                          //                 children: [
                          //                   Icon(
                          //                     Icons.camera_alt,
                          //                     color:
                          //                         Colors.grey,
                          //                     size: 100,
                          //                   ),
                          //                   Text(
                          //                     'رفع صوره',
                          //                     style: TextStyle(
                          //                         fontFamily:
                          //                             'Bahij',
                          //                         fontSize: 40,
                          //                         color: Colors
                          //                             .grey,
                          //                         fontWeight:
                          //                             FontWeight
                          //                                 .bold),
                          //                   )
                          //                 ],
                          //               ).showCursorOnHover,
                          //             )
                          //           : StreamBuilder<
                          //               DocumentSnapshot>(
                          //               stream: loadBanners(),
                          //               builder: (context,
                          //                   snapshot) {
                          //                 if (snapshot
                          //                         .hasData &&
                          //                     snapshot.data !=
                          //                         null) {
                          //                   if (snapshot
                          //                           .connectionState ==
                          //                       ConnectionState
                          //                           .waiting)
                          //                     return Center(
                          //                       child:
                          //                           CircularProgressIndicator(),
                          //                     );
                          //                   bool banner1 = snapshot
                          //                               .data
                          //                               .data()[
                          //                           'ads 4'] ==
                          //                       path;
                          //                   return (banner1)
                          //                       ? Column(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment
                          //                                   .center,
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment
                          //                                   .center,
                          //                           children: [
                          //                             Image
                          //                                 .asset(
                          //                               'assets/images/icons/checked.png',
                          //                               height:
                          //                                   100,
                          //                             ),
                          //                             SizedBox(
                          //                               height:
                          //                                   10,
                          //                             ),
                          //                             Text(
                          //                               '!قد تم رفع الصوره',
                          //                               style: TextStyle(
                          //                                   fontFamily:
                          //                                       'Bahij',
                          //                                   fontSize:
                          //                                       40,
                          //                                   color:
                          //                                       Colors.grey,
                          //                                   fontWeight: FontWeight.bold),
                          //                             ),
                          //                           ],
                          //                         )
                          //                       : Center(
                          //                           child:
                          //                               CircularProgressIndicator(),
                          //                         );
                          //                 } else {
                          //                   return Center(
                          //                     child:
                          //                         CircularProgressIndicator(),
                          //                   );
                          //                 }
                          //               },
                          //             )),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Text(
                              "روابط التطبيق",
                              style:
                              TextStyle(fontSize: 45),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width:
                                MediaQuery.of(context)
                                    .size
                                    .width /
                                    2,
                                child: Directionality(
                                  textDirection:
                                  TextDirection.rtl,
                                  child: TextField(
                                    onChanged: (val) {
                                      android = val;
                                    },
                                    textAlign:
                                    TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                    ),
                                    keyboardType:
                                    TextInputType
                                        .text,
                                    decoration:
                                    InputDecoration(
                                        hintText:
                                        'جوجل بلاي',
                                        fillColor:
                                        Colors.blueGrey[
                                        50],
                                        filled: true,
                                        icon: Icon(Icons
                                            .android),
                                        labelStyle:
                                        TextStyle(
                                          fontSize:
                                          20,
                                          fontFamily:
                                          'Bahij',
                                        ),
                                        hintStyle:
                                        TextStyle(
                                          fontSize:
                                          20,
                                          fontFamily:
                                          'Bahij',
                                        ),
                                        contentPadding:
                                        EdgeInsets.only(
                                            right:
                                            30,
                                            left:
                                            30),
                                        focusedBorder:
                                        OutlineInputBorder(
                                            borderSide:
                                            BorderSide(
                                              color:
                                              Colors.blueGrey[50],
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                15)),
                                        enabledBorder:
                                        OutlineInputBorder(
                                            borderSide:
                                            BorderSide(
                                              color:
                                              Colors.blueGrey[50],
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(15))),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius
                                        .circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors
                                              .blue[100],
                                          spreadRadius:
                                          10,
                                          blurRadius: 20)
                                    ]),
                                child: ElevatedButton(
                                  child: Container(
                                    width:
                                    double.infinity,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                          "تغير",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                            'Bahij',
                                          ),
                                        )),
                                  ),
                                  onPressed: () async {
                                    if (android != null) {
                                      _firestore
                                          .collection(
                                          'info')
                                          .doc('app')
                                          .update({
                                        'playstore':
                                        android
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(
                                          0xFF2980b9),
                                      onPrimary:
                                      Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              15))),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width:
                                MediaQuery.of(context)
                                    .size
                                    .width /
                                    2,
                                child: Directionality(
                                  textDirection:
                                  TextDirection.rtl,
                                  child: TextField(
                                    onChanged: (val) {
                                      iphone = val;
                                    },
                                    textAlign:
                                    TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                    ),
                                    keyboardType:
                                    TextInputType
                                        .text,
                                    decoration:
                                    InputDecoration(
                                        hintText:
                                        'بلاي ستور',
                                        fillColor:
                                        Colors.blueGrey[
                                        50],
                                        filled: true,
                                        icon: Icon(Icons
                                            .phone_iphone),
                                        labelStyle:
                                        TextStyle(
                                          fontSize:
                                          20,
                                          fontFamily:
                                          'Bahij',
                                        ),
                                        hintStyle:
                                        TextStyle(
                                          fontSize:
                                          20,
                                          fontFamily:
                                          'Bahij',
                                        ),
                                        contentPadding:
                                        EdgeInsets.only(
                                            right:
                                            30,
                                            left:
                                            30),
                                        focusedBorder:
                                        OutlineInputBorder(
                                            borderSide:
                                            BorderSide(
                                              color:
                                              Colors.blueGrey[50],
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                15)),
                                        enabledBorder:
                                        OutlineInputBorder(
                                            borderSide:
                                            BorderSide(
                                              color:
                                              Colors.blueGrey[50],
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(15))),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius
                                        .circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors
                                              .blue[100],
                                          spreadRadius:
                                          10,
                                          blurRadius: 20)
                                    ]),
                                child: ElevatedButton(
                                  child: Container(
                                    width:
                                    double.infinity,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                          "تغير",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                            'Bahij',
                                          ),
                                        )),
                                  ),
                                  onPressed: () async {
                                    if (iphone != null) {
                                      _firestore
                                          .collection(
                                          'info')
                                          .doc('app')
                                          .update({
                                        'appstore': iphone
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(
                                          0xFF2980b9),
                                      onPrimary:
                                      Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              15))),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Text(
                              "اخفاء واظهار الصفحات",
                              style:
                              TextStyle(fontSize: 45),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius
                                        .circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors
                                              .blue[100],
                                          spreadRadius:
                                          10,
                                          blurRadius: 20)
                                    ]),
                                child: ElevatedButton(
                                  child: Container(
                                    width:
                                    double.infinity,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                          "أخفاء صفحة تسجيل مندوب",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                            'Bahij',
                                          ),
                                        )),
                                  ),
                                  onPressed: () async {
                                    _firestore
                                        .collection(
                                        'info')
                                        .doc('Pages')
                                        .update({
                                      'Delegate': false
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(
                                          0xFF2980b9),
                                      onPrimary:
                                      Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              15))),
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius
                                        .circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors
                                              .blue[100],
                                          spreadRadius:
                                          10,
                                          blurRadius: 20)
                                    ]),
                                child: ElevatedButton(
                                  child: Container(
                                    width:
                                    double.infinity,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                          "أظهار صفحة تسجيل مندوب",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                            'Bahij',
                                          ),
                                        )),
                                  ),
                                  onPressed: () async {
                                    _firestore
                                        .collection(
                                        'info')
                                        .doc('Pages')
                                        .update({
                                      'Delegate': true
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(
                                          0xFF2980b9),
                                      onPrimary:
                                      Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              15))),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius
                                        .circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors
                                              .blue[100],
                                          spreadRadius:
                                          10,
                                          blurRadius: 20)
                                    ]),
                                child: ElevatedButton(
                                  child: Container(
                                    width:
                                    double.infinity,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                          "أخفاء صفحة السلع والاعلانات الممنوعة",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                            'Bahij',
                                          ),
                                        )),
                                  ),
                                  onPressed: () async {
                                    _firestore
                                        .collection(
                                        'info')
                                        .doc('Pages')
                                        .update({
                                      'Legacy': false
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(
                                          0xFF2980b9),
                                      onPrimary:
                                      Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              15))),
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius
                                        .circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors
                                              .blue[100],
                                          spreadRadius:
                                          10,
                                          blurRadius: 20)
                                    ]),
                                child: ElevatedButton(
                                  child: Container(
                                    width:
                                    double.infinity,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                          "أظهار صفحة السلع والاعلانات الممنوعة",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                            'Bahij',
                                          ),
                                        )),
                                  ),
                                  onPressed: () async {
                                    _firestore
                                        .collection(
                                        'info')
                                        .doc('Pages')
                                        .update({
                                      'Legacy': true
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(
                                          0xFF2980b9),
                                      onPrimary:
                                      Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              15))),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _createEvent(context) {
    String eventName,
        eventDate,
        eventTime,
        eventType,
        eventAddress,
        eventImage,
        eventDescription;

    Alert(
        context: context,
        title: "Add Event",
        content: Column(
          children: [
            TextField(
              onChanged: (val) {
                eventName = val;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Event Name',
              ),
            ),
            TextField(
              onChanged: (val) {
                eventType = val;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.category),
                labelText: 'Event Type',
              ),
            ),
            TextField(
              onChanged: (val) {
                eventDate = val;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: 'Event Date',
              ),
            ),
            TextField(
              onChanged: (val) {
                eventTime = val;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.timer),
                labelText: 'Event Time',
              ),
            ),
            TextField(
              onChanged: (val) {
                eventAddress = val;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.map),
                labelText: 'Event Address',
              ),
            ),
            TextField(
              onChanged: (val) {
                eventDescription = val;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.description),
                labelText: 'Event Description',
              ),
            ),
            TextField(
              onChanged: (val) {
                eventImage = val;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.link),
                labelText: 'Event Image Link',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
              color: Colors.black,
              child: Text(
                "Add Event",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                if (eventName != null ||
                    eventDescription != null ||
                    eventImage != null ||
                    eventType != null ||
                    eventTime != null ||
                    eventDate != null ||
                    eventAddress != null) {
                  _firestore.collection('events').doc().set({
                    "Event Name": eventName,
                    "Event Type": eventType,
                    "Event Date": eventDate,
                    "Event Time": eventTime,
                    "Event Description": eventDescription,
                    "Event Image": eventImage,
                    "Address": eventAddress,
                    "Date": DateTime.now()
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Enter a correct information!',
                        textAlign: TextAlign.left,
                      )));
                }
              })
        ]).show();
  }

  _onAlertWithCustomContentPressed(context) {
    String email;
    String password;
    String userName;
    Alert(
        context: context,
        title: "Add User",
        content: Column(
          children: <Widget>[
            TextField(
              onChanged: (val) {
                userName = val;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Username',
              ),
            ),
            TextField(
              onChanged: (val) {
                email = val;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'Email',
              ),
            ),
            TextField(
              onChanged: (val) {
                password = val;
              },
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: () async {
              if (email != null && password != null && userName != null) {
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Enter a correct information!',
                      textAlign: TextAlign.left,
                    )));
              }
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}

_onDelegatePressed(context, String docId) {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ScrollController list3 = ScrollController();
  Stream<DocumentSnapshot> loadDelegateImages(docId) {
    return _firestore.collection('delegate').doc(docId).snapshots();
  }

  Alert(
      context: context,
      title: "معلومات مندوب",
      content: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 300,
          decoration: BoxDecoration(
              border: Border.all(width: 4, color: Color(0xFF2980b9)),
              borderRadius: BorderRadius.circular(5)),
          child: StreamBuilder<DocumentSnapshot>(
            stream: loadDelegateImages(docId),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.data() != null) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                int photoLimit = snapshot.data.data()['imageCount'];

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: VsScrollbar(
                    controller: list3,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0,
                      radius: Radius.circular(10),
                      thickness: 10.0,
                      color: Color(0xFF2980b9),
                    ),
                    child: GridView.builder(
                      controller: list3,
                      itemCount: photoLimit,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisExtent: 290,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        return StreamBuilder<Uri>(
                          stream: downloadUrl(
                              snapshot.data.data()['photo_url $index'])
                              .asStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            return Image.network(
                              snapshot.data.toString(),
                              fit: BoxFit.cover,
                            );
                          },
                        );
                      },
                    ).showCursorOnHover,
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ))).show();
}

class NavBarItem extends StatefulWidget {
  final IconData icon;
  final Function onTap;
  final bool selected;

  NavBarItem({
    this.icon,
    this.onTap,
    this.selected,
  });

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> with TickerProviderStateMixin {
  AnimationController _controller1;
  AnimationController _controller2;

  Animation<double> _anim1;
  Animation<double> _anim2;
  Animation<double> _anim3;
  Animation<Color> _color;

  bool hovered = false;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 275),
    );
    _anim1 = Tween(begin: 101.0, end: 75.0).animate(_controller1);
    _anim2 = Tween(begin: 101.0, end: 25.0).animate(_controller2);
    _anim3 = Tween(begin: 101.0, end: 50.0).animate(_controller2);
    _color = ColorTween(end: Color(0xff332a7c), begin: Colors.white)
        .animate(_controller2);

    _controller1.addListener(() {
      setState(() {});
    });
    _controller2.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.selected) {
      Future.delayed(Duration(milliseconds: 10), () {
        //_controller1.reverse();
      });
      _controller1.reverse();
      _controller2.reverse();
    } else {
      _controller1.forward();
      _controller2.forward();
      Future.delayed(Duration(milliseconds: 10), () {
        //_controller2.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (value) {
          setState(() {
            hovered = false;
          });
        },
        child: Container(
          width: 101,
          color:
          hovered && !widget.selected ? Colors.white12 : Colors.transparent,
          child: Stack(
            children: [
              Container(
                child: CustomPaint(
                  painter: CurvePainter(
                    value1: 0,
                    animValue1: _anim3.value,
                    animValue2: _anim2.value,
                    animValue3: _anim1.value,
                  ),
                ),
              ),
              Container(
                height: 80,
                width: 101,
                child: Center(
                  child: Icon(
                    widget.icon,
                    color: _color.value,
                    size: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final double value1; // 200
  final double animValue1; // static value1 = 50.0
  final double animValue2; //static value1 = 75.0
  final double animValue3; //static value1 = 75.0

  CurvePainter({
    this.value1,
    this.animValue1,
    this.animValue2,
    this.animValue3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.moveTo(101, value1);
    path.quadraticBezierTo(101, value1 + 20, animValue3,
        value1 + 20); // have to use animValue3 for x2
    path.lineTo(animValue1, value1 + 20); // have to use animValue1 for x
    path.quadraticBezierTo(animValue2, value1 + 20, animValue2,
        value1 + 40); // animValue2 = 25 // have to use animValue2 for both x
    path.lineTo(101, value1 + 40);
    // path.quadraticBezierTo(25, value1 + 60, 50, value1 + 60);
    // path.lineTo(75, value1 + 60);
    // path.quadraticBezierTo(101, value1 + 60, 101, value1 + 80);
    path.close();

    path.moveTo(101, value1 + 80);
    path.quadraticBezierTo(101, value1 + 60, animValue3, value1 + 60);
    path.lineTo(animValue1, value1 + 60);
    path.quadraticBezierTo(animValue2, value1 + 60, animValue2, value1 + 40);
    path.lineTo(101, value1 + 40);
    path.close();

    paint.color = Colors.white;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;

  // name constructor that has a positional parameters with the text required
  // and the other parameters optional
  CustomText({@required this.text, this.size, this.color, this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size ?? 16,
          color: Colors.white,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}




