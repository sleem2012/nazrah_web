import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/model/ad.dart';
import 'package:nazarih/model/user.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/services/Shareddata.dart';
import 'package:nazarih/services/firebase_storage.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

class ProfileViewTabletDesktop extends StatefulWidget {
  @override
  _ProfileViewTabletDesktopState createState() =>
      _ProfileViewTabletDesktopState();
}

class _ProfileViewTabletDesktopState extends State<ProfileViewTabletDesktop> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String phoneNo;

  Stream<DocumentSnapshot> loadMyInfo() {
    return _firestore.collection('users').doc(phoneNo).snapshots();
  }

  Stream<QuerySnapshot> loadAds(String phoneNumber) {
    return _firestore
        .collection('ads')
        .where('user', isEqualTo: phoneNumber)
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
    final double width=MediaQuery.of(context).size.width;
    if (phoneNo == null) return Center(child: CircularProgressIndicator());
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
            CenteredView(child: NavigationBar(currentRoute: 'Profile')),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF2980b9),
            ),
            SizedBox(
              height: 50,
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: loadMyInfo(),
              builder: (context, snapshot) {
                {
                  if (snapshot.hasData) {
                    String name = snapshot.data.data()['Name'];
                    int rating_count = snapshot.data.data()['rating'];
                    String commission = snapshot.data.data()['Commission'];
                    String membership = snapshot.data.data()['Membership'];
                    String photoUrl = snapshot.data.data()['photo_url'];

                    double rating = (rating_count != 0)
                        ? (rating_count * 5) / rating_count
                        : 0;

                    return Container(
                      width: MediaQuery.of(context).size.width - 200,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue[100],
                                spreadRadius: 10,
                                blurRadius: 20)
                          ]),
                      child: Padding(
                        padding:  EdgeInsets.only(left: width*0.08, right: width*0.08),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
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
                                  height: 50,
                                  child: Center(
                                      child: Text(
                                    "تسحيل خروج",
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Bahij',
                                    ),
                                  )),
                                ),
                                onPressed: () async {
                                  saveLogin(false);
                                  saveName(null);
                                  savePhoneNumber(null);
                                  locator<NavigationService>()
                                      .navigateTo(HomeRoute);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF2980b9),
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                            ).mouseUpOnHover,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    (membership == 'Premium')
                                        ? Row(
                                      children: [
                                        Text(
                                          "",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 25,
                                              color: Colors.black,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Image.asset(
                                          'assets/images/icons/star.png',
                                          height: 35,
                                        ),
                                      ],
                                    )
                                        : Container(),
                                    Text(
                                      name,
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 40,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [

                                      (commission == 'Paid')
                                          ? Row(
                                              children: [
                                                Text(
                                                  "دفع العمولة",
                                                  style: TextStyle(
                                                      fontFamily: 'Bahij',
                                                      fontSize: 25,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Image.asset(
                                                  'assets/images/icons/invoice.png',
                                                  height: width*0.02,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   width: 100,
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    StreamBuilder<Uri>(
                                      stream: downloadUrl(photoUrl).asStream(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting)
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        return Container(
                                          width: width*0.08,
                                          height: width*0.08,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 4,
                                                  color: Colors.white),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(0, 10))
                                              ],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      snapshot.data.toString(),
                                                  ))),
                                        );
                                      },
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            uploadToStorage(phoneNo, phoneNo);
                                          },
                                          child: Container(
                                                  height: width*0.028,
                                                  width: width*0.028,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF2980b9),
                                                      border: Border.all(
                                                          width: 4,
                                                          color: Colors.white),
                                                      shape: BoxShape.circle),
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: width*0.018,
                                                  ))
                                              .showCursorOnHover
                                              .mouseUpOnHover,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                RatingBarIndicator(
                                  rating: rating,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemSize:width*0.022,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              },
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                "الاعلانات",
                style: TextStyle(fontFamily: 'Bahij', fontSize: 50),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: loadAds(phoneNo),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data.docs.length == 0) {
                  return Center(
                    child: Text("لاتوجد اعلانات فالوقت الحالي"),
                  );
                } else {
                  List<AdDisplayInfo> ads = [];
                  for (var doc in snapshot.data.docs) {
                    final Timestamp timestamp = doc.data()['date'] as Timestamp;
                    final DateTime dateTime = timestamp.toDate();

                    ads.add(AdDisplayInfo(
                        title: doc.data()['Title'],
                        country: doc.data()['Country'],
                        photoBool: doc.data()['photoBool'],
                        docId: doc.id,
                        photoPath: (doc.data()['photoBool'] == 'true')
                            ? doc.data()['photo_url 0']
                            : '',
                        user: doc.data()['user'],
                        dateDays: DateTime.now().difference(dateTime).inDays,
                        dateHours: DateTime.now().difference(dateTime).inHours,

                        dateMins:
                            DateTime.now().difference(dateTime).inMinutes));
                  }
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      width: width*0.8,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100, right: 100),
                        child: ListView.builder(
                          itemCount: ads.length,
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: Stack(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        locator<NavigationService>().navigateTo(
                                            AdDetailsRoute,
                                            queryParams: {
                                              'id': ads[index].docId
                                            });
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Color(0xFF2980b9),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10,),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width *0.32,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    ads[index].title,
                                                    maxLines: 3,

                                                    style: TextStyle(
                                                        fontFamily: 'Bahij',
                                                        fontSize: 25,

                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.pin_drop,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        ads[index].country,
                                                        style: TextStyle(
                                                          fontFamily: 'Bahij',
                                                          fontSize: 30,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.timelapse,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        (ads[index].dateDays != 0)
                                                            ? "قبل ${ads[index].dateDays} ايام"
                                                            : (ads[index]
                                                                        .dateHours !=
                                                                    0)
                                                                ? "قبل ${ads[index].dateHours} ساعات"
                                                                : "قبل ${ads[index].dateMins} دقائق",
                                                        style: TextStyle(
                                                          fontFamily: 'Bahij',
                                                          fontSize: 30,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            (ads[index].photoBool == 'true')
                                                ? FutureBuilder<Uri>(
                                                    future: downloadUrl(
                                                        ads[index].photoPath),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting)
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      return ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.network(
                                                          snapshot.data
                                                              .toString(),
                                                          width: MediaQuery.of(context).size.width *0.17,
                                                          height: MediaQuery.of(context).size.width *0.1,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.asset(
                                                      'assets/images/no_image.png',
                                                      width: MediaQuery.of(context).size.width *0.17,
                                                      height: MediaQuery.of(context).size.width *0.1,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                  ).mouseUpOnHover,
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              locator<NavigationService>()
                                                  .navigateTo(EditAdRoute,
                                                      queryParams: {
                                                    'id': ads[index].docId
                                                  });
                                            },
                                            child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        border:
                                                            Border.all(
                                                                width: 4,
                                                                color: Colors
                                                                    .white),
                                                        shape: BoxShape.circle),
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                    ))
                                                .showCursorOnHover
                                                .mouseUpOnHover,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _firestore
                                                  .collection('ads')
                                                  .doc(ads[index].docId)
                                                  .delete();
                                            },
                                            child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        border:
                                                            Border.all(
                                                                width: 4,
                                                                color: Colors
                                                                    .white),
                                                        shape: BoxShape.circle),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ))
                                                .showCursorOnHover
                                                .mouseUpOnHover,
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
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
      phoneNo = prefs.getString('Phone Number') ?? null;
    });
  }
}
