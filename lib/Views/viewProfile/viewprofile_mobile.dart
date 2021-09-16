import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/model/ad.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/services/firebase_storage.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nazarih/services/navigation_service.dart';

class ViewProfileMobile extends StatefulWidget {
  final String phoneNumber;
  ViewProfileMobile({@required this.phoneNumber});
  @override
  _ViewProfileMobileState createState() =>
      _ViewProfileMobileState(phoneNumber: phoneNumber);
}

class _ViewProfileMobileState extends State<ViewProfileMobile> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> loadMyInfo(String phoneNumber) {
    return _firestore.collection('users').doc(phoneNumber).snapshots();
  }

  Stream<QuerySnapshot> loadAds(String phoneNumber) {
    return _firestore
        .collection('ads')
        .where('user', isEqualTo: phoneNumber)
        .snapshots();
  }

  createChatroom(String chatRoomId, chatRoomMap) {
    _firestore.collection('ChatRoom').doc(chatRoomId).set(chatRoomMap);
  }

  String phoneNumber;

  _ViewProfileMobileState({@required this.phoneNumber});

  String phoneNo;

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
    if (phoneNumber == null || phoneNo == null)
      return Center(child: CircularProgressIndicator());
    return SingleChildScrollView(
      child: Column(
        children: [
          CenteredView(
              child: NavigationBar(
            currentRoute: 'ViewProfile',
          )),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF2980b9),
          ),
          SizedBox(
            height: 50,
          ),
          StreamBuilder<DocumentSnapshot>(
            stream: loadMyInfo(phoneNumber),
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
                    width: MediaQuery.of(context).size.width - 40,
                    height: 350,
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4, color: Colors.white),
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
                                        image: NetworkImage(
                                            snapshot.data.toString()))),
                              );
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RatingBar.builder(
                            itemSize: 20,
                            initialRating: rating,
                            minRating: 1,
                            // rating: rating,
                            allowHalfRating: false,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (ratingVal) async {
                              if (ratingVal == 1) {
                                int rating = 0;
                                await _firestore
                                    .collection('users')
                                    .doc(phoneNumber)
                                    .get()
                                    .then((DocumentSnapshot documentSnapshot) =>
                                        {
                                          rating =
                                              documentSnapshot.data()['rating'],
                                        });
                                _firestore
                                    .collection('users')
                                    .doc(phoneNumber)
                                    .update({'rating': rating + 1});
                              } else if (ratingVal == 2) {
                                int rating = 0;
                                await _firestore
                                    .collection('users')
                                    .doc(phoneNumber)
                                    .get()
                                    .then((DocumentSnapshot documentSnapshot) =>
                                        {
                                          rating =
                                              documentSnapshot.data()['rating'],
                                        });
                                _firestore
                                    .collection('users')
                                    .doc(phoneNumber)
                                    .update({'rating': rating + 2});
                              } else if (ratingVal == 3) {
                                int rating = 0;
                                await _firestore
                                    .collection('users')
                                    .doc(phoneNumber)
                                    .get()
                                    .then((DocumentSnapshot documentSnapshot) =>
                                        {
                                          rating =
                                              documentSnapshot.data()['rating'],
                                        });
                                _firestore
                                    .collection('users')
                                    .doc(phoneNumber)
                                    .update({'rating': rating + 3});
                              } else if (ratingVal == 4) {
                                int rating = 0;
                                await _firestore
                                    .collection('users')
                                    .doc(phoneNumber)
                                    .get()
                                    .then((DocumentSnapshot documentSnapshot) =>
                                        {
                                          rating =
                                              documentSnapshot.data()['rating'],
                                        });
                                _firestore
                                    .collection('users')
                                    .doc(phoneNumber)
                                    .update({'rating': rating + 4});
                              } else if (ratingVal == 5) {
                                int rating = 0;
                                await _firestore
                                    .collection('users')
                                    .doc(phoneNumber)
                                    .get()
                                    .then((DocumentSnapshot documentSnapshot) =>
                                        {
                                          rating =
                                              documentSnapshot.data()['rating'],
                                        });
                                _firestore
                                    .collection('users')
                                    .doc(phoneNumber)
                                    .update({'rating': rating + 5});
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                fontFamily: 'Bahij',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (membership == 'Premium')
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "عضوية نظره المدفوعة",
                                            style: TextStyle(
                                                fontFamily: 'Bahij',
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            'assets/images/icons/star.png',
                                            height: 20,
                                          ),
                                        ],
                                      )
                                    : Container(),
                                (commission == 'Paid')
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "دفع العمولة",
                                            style: TextStyle(
                                                fontFamily: 'Bahij',
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            'assets/images/icons/invoice.png',
                                            height: 20,
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            child: Container(
                              //width: double.infinity,
                              height: 35,
                              child: Center(
                                  child: Text(
                                "أرسال رسالة",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Bahij',
                                ),
                              )),
                            ),
                            onPressed: () async {
                              if (phoneNo == null) {
                                locator<NavigationService>()
                                    .navigateTo(LoginRoute);
                              } else {
                                String chatRoomId =
                                    getChatRoomId(phoneNumber, phoneNo);
                                List<String> users = [phoneNumber, phoneNo];
                                Map<String, dynamic> chatRoomMap = {
                                  "users": users,
                                  "chatRoomId": chatRoomId
                                };
                                createChatroom(chatRoomId, chatRoomMap);
                                locator<NavigationService>().navigateTo(
                                    ChatRoomRoute,
                                    queryParams: {'id': chatRoomId});
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF2980b9),
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
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
            stream: loadAds(phoneNumber),
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
                      dateMins: DateTime.now().difference(dateTime).inMinutes));
                }
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListView.builder(
                        itemCount: ads.length,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: TextButton(
                                onPressed: () {
                                  locator<NavigationService>().navigateTo(
                                      AdDetailsRoute,
                                      queryParams: {'id': ads[index].docId});
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF2980b9),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ads[index].title,
                                            style: TextStyle(
                                                fontFamily: 'Bahij',
                                                fontSize: 30,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
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
                                                  fontSize: 20,
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
                                                    : (ads[index].dateHours !=
                                                            0)
                                                        ? "قبل ${ads[index].dateHours} ساعات"
                                                        : "قبل ${ads[index].dateMins} دقائق",
                                                style: TextStyle(
                                                  fontFamily: 'Bahij',
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      (ads[index].photoBool == 'true')
                                          ? FutureBuilder<Uri>(
                                              future: downloadUrl(
                                                  ads[index].photoPath),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting)
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.network(
                                                    snapshot.data.toString(),
                                                    width: 150,
                                                    height: 150,
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              },
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/no_image.png',
                                                width: 150,
                                                height: 150,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ],
                                  ),
                                )),
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

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      phoneNo = prefs.getString('Phone Number') ?? null;
    });
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(2, 3).codeUnitAt(0) > b.substring(2, 3).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
