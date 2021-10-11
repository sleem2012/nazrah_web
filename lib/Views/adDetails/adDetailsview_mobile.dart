import 'dart:async';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/services/firebase_storage.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AdDetailsViewMobile extends StatefulWidget {
  final String documentId;
  AdDetailsViewMobile({@required this.documentId});

  @override
  _AdDetailsViewMobileState createState() =>
      _AdDetailsViewMobileState(documentId: documentId);
}

addConversationMessages(String adId, messageMap) {
  FirebaseFirestore.instance
      .collection('ads')
      .doc(adId)
      .collection('ChatRoom')
      .add(messageMap);
}

getConversationMessages(String adId) {
  return FirebaseFirestore.instance
      .collection('ads')
      .doc(adId)
      .collection('ChatRoom')
      .orderBy('time')
      .snapshots();
}

class _AdDetailsViewMobileState extends State<AdDetailsViewMobile> {
  String documentId;

  _AdDetailsViewMobileState({@required this.documentId});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String phoneNo;

  Stream<DocumentSnapshot> loadAppInfo() {
    return _firestore.collection('info').doc('app').snapshots();
  }

  List imgList = [
    'assets/images/no_image.png',
  ];

  Stream<DocumentSnapshot> loadAdDetails(documentId) {
    return _firestore.collection('ads').doc(documentId).snapshots();
  }

  Stream<DocumentSnapshot> loadBanners() {
    return _firestore.collection('info').doc('banners').snapshots();
  }

  TextEditingController messageController = new TextEditingController();
  final ScrollController _scrollController = ScrollController();

  var textDirection = TextDirection.rtl;

  void scolldown() {
    Timer(
        Duration(seconds: 1),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn));
  }

  @override
  void initState() {
    getData();
    Timer(
        Duration(seconds: 2),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CenteredView(child: NavigationBar(currentRoute: 'AdDetails')),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF2980b9),
          ),
          SizedBox(
            height: 50,
          ),
          StreamBuilder<DocumentSnapshot>(
            stream: loadBanners(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String banner1 = snapshot.data.data()['ads 2'];
                return Container(
                  width: 728,
                  height: 90,
                  child: StreamBuilder<Uri>(
                    stream: downloadUrl(banner1).asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      return Image.network(
                        snapshot.data.toString(),
                        gaplessPlayback: true,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SizedBox(
            height: 30,
          ),
          StreamBuilder(
            stream: loadAdDetails(documentId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String country = snapshot.data.data()['Country'];
                String subCountry = snapshot.data.data()['subCountry'];
                String title = snapshot.data.data()['Title'];
                String communication = snapshot.data.data()['Communication'];
                String description = snapshot.data.data()['Description'];
                String priceBool = snapshot.data.data()['priceBool'];
                String price = snapshot.data.data()['price'];
                String photoBool = snapshot.data.data()['photoBool'];
                String userName = snapshot.data.data()['userName'];
                String user = snapshot.data.data()['user'];
                String membership=snapshot.data.data()['Membership'];

                final Timestamp timestamp =
                    snapshot.data.data()['date'] as Timestamp;
                final DateTime dateTime = timestamp.toDate();

                int dateDays = DateTime.now().difference(dateTime).inDays;
                int dateHours = DateTime.now().difference(dateTime).inHours;
                int dateMins = DateTime.now().difference(dateTime).inMinutes;
                List imagePaths = [];

                if (photoBool == 'true') {
                  int imageCount = snapshot.data.data()['imageCount'];
                  for (var i = 0; i < imageCount; i++) {
                    imagePaths.add(snapshot.data.data()['photo_url $i']);
                  }
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Expanded(
                            child: Text(
                              title,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: 'Bahij',
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (phoneNo != null) {
                                    String username;
                                    String membership2;
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(phoneNo)
                                        .get()
                                        .then((DocumentSnapshot
                                                documentSnapshot) =>
                                            {
                                              username = documentSnapshot.data()['Name'],
                                              membership2 = documentSnapshot.data()['Membership'],

                                            });
                                    if (username == userName) {
                                      locator<NavigationService>()
                                          .navigateTo(ProfileRoute);
                                    } else {
                                      locator<NavigationService>().navigateTo(
                                          UserDetailsRoute,
                                          queryParams: {'id': user});
                                    }
                                  } else {
                                    locator<NavigationService>()
                                        .navigateTo(LoginRoute);
                                  }
                                },
                                child: Row(
                                  children: [
                                    (membership == 'Premium')
                                        ? Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          'assets/images/icons/star.png',
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )
                                        : Container(),
                                    Text(
                                      userName,
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 20,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    (photoBool == 'true')
                        ? FutureBuilder<List<String>>(
                            future: downloadUrls(imagePaths),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                List<String> list = snapshot.data;
                                return CarouselSlider(
                                    items: list.map((imgPath) {
                                      return Builder(
                                          builder: (BuildContext context) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 30, bottom: 30),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.blue[100],
                                                      spreadRadius: 10,
                                                      blurRadius: 20)
                                                ]),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                imgPath,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    }).toList(),

                                    options: CarouselOptions(
                                      height: 300,
                                      autoPlay: true,
                                      initialPage: 0,
                                      enlargeCenterPage: true,
                                      autoPlayInterval: Duration(seconds: 2),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 2000),
                                    ));
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          )
                        : CarouselSlider(
                            items: imgList.map((imgPath) {
                              return Builder(builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 30),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.blue[100],
                                              spreadRadius: 10,
                                              blurRadius: 20)
                                        ]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        imgPath,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              });
                            }).toList(),
                            options: CarouselOptions(
                              height: 300,
                              autoPlay: true,
                              initialPage: 0,
                              enlargeCenterPage: true,
                              autoPlayInterval: Duration(seconds: 2),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 2000),
                            )),
                    SizedBox(
                      height: 5,
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        description,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Bahij',
                          fontSize: 23,
                          color: Colors.black,

                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  country,
                                  style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.pin_drop,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  (subCountry == 'null') ? country : subCountry,
                                  style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.map,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  (dateDays != 0)
                                      ? "قبل $dateDays ايام"
                                      : (dateHours != 0)
                                          ? "قبل $dateHours ساعات"
                                          : "قبل $dateMins دقائق",
                                  style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.timelapse,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  communication,
                                  style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF2980b9),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue[100],
                                spreadRadius: 10,
                                blurRadius: 20)
                          ]),
                      //width: 50,
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              (priceBool == 'true')
                                  ? "$price ريال"
                                  : 'لم يتم تحديد السعر',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Bahij',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Stack(
                              children: [
                                (phoneNo == null)
                                    ? Center(
                                        child: Text(
                                          "الرجاء تسجيل الدخول لرؤية الرسائل",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : StreamBuilder<QuerySnapshot>(
                                        stream:
                                            getConversationMessages(documentId),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData ||
                                              snapshot.data.docs.length == 0) {
                                            return Center(
                                              child: Text(
                                                "لاتوجد رسائل فالوقت الحالي",
                                                style: TextStyle(
                                                    fontFamily: 'Bahij',
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          } else {
                                            return ListView.builder(
                                              controller: _scrollController,
                                              itemCount:
                                                  snapshot.data.docs.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return MessageTile(
                                                    snapshot.data.docs[index]
                                                        ["message"],
                                                    snapshot.data.docs[index]
                                                            ["sendBy"] ==
                                                        phoneNo,
                                                    snapshot.data.docs[index]
                                                        ["name"],
                                                    userName,
                                                    snapshot.data.docs[index]
                                                        ["sendBy"]);
                                              },
                                            );
                                          }
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Directionality(
                        textDirection: textDirection,
                        child: TextField(
                          controller: messageController,
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          onChanged: (val) {
                            RegExp exp = RegExp("[a-zA-Z]");
                            if (exp.hasMatch(val.substring(val.length - 1)) &&
                                val.substring(val.length - 1) != " ") {
                              setState(() {
                                textDirection = TextDirection.ltr;
                              });
                            } else if (val.substring(val.length - 1) != " " &&
                                !exp.hasMatch(val.substring(val.length - 1))) {
                              setState(() {
                                textDirection = TextDirection.rtl;
                              });
                            }
                          },
                          style: TextStyle(fontFamily: 'Bahij'),
                          decoration: InputDecoration(
                              hintText: 'أكتب سؤالك للمعلن هنا',
                              fillColor: Colors.blueGrey[50],
                              filled: true,
                              hintStyle: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Bahij',
                              ),
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Bahij',
                              ),
                              contentPadding: EdgeInsets.only(
                                  right: 30, top: 20, bottom: 20, left: 30),
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
                      height: 50,
                    ),
                    Container(
                      width: 300,
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
                            "ارسال",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Bahij',
                            ),
                          )),
                        ),
                        onPressed: () async {
                          if (phoneNo == null) {
                            locator<NavigationService>().navigateTo(LoginRoute);
                          } else {
                            if (messageController.text.isNotEmpty) {
                              String username;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(phoneNo)
                                  .get()
                                  .then((DocumentSnapshot documentSnapshot) => {
                                        username =
                                            documentSnapshot.data()['Name'],
                                      });
                              Map<String, dynamic> messageMap = {
                                "message": messageController.text,
                                "sendBy": phoneNo,
                                "time": DateTime.now().microsecondsSinceEpoch,
                                'name': username
                              };
                              addConversationMessages(documentId, messageMap);
                              messageController.text = '';
                              scolldown();
                              if (username != userName) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user)
                                    .collection('Notifications')
                                    .doc()
                                    .set({
                                  "message":
                                      "لقد تلقيت رسالة جديده علي اعلانك" +
                                          " - " +
                                          title,
                                  'date': DateTime.now().microsecondsSinceEpoch,
                                  'type': 'ad',
                                  'docId': documentId
                                });
                              } else {
                                List phoneNumbers = [];
                                await _firestore
                                    .collection('ads')
                                    .doc(documentId)
                                    .collection('ChatRoom')
                                    .where('sendBy', isNotEqualTo: phoneNo)
                                    .get()
                                    .then((snapshot) => {
                                          for (DocumentSnapshot ds
                                              in snapshot.docs)
                                            {
                                              if (!phoneNumbers.contains(
                                                  ds.data()['sendBy']))
                                                {
                                                  phoneNumbers
                                                      .add(ds.data()['sendBy'])
                                                }
                                            }
                                        });
                                for (String phone in phoneNumbers) {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(phone)
                                      .collection('Notifications')
                                      .doc()
                                      .set({
                                    "message": "اضاف المعلن رسالة جديده" +
                                        " - " +
                                        title,
                                    'date':
                                        DateTime.now().microsecondsSinceEpoch,
                                    'type': 'ad',
                                    'docId': documentId
                                  });
                                }
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF2980b9),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text("....برجاء الانتظار"),
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

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByME;
  final String sendBy;
  final String userName;
  final String phoneNo;
  MessageTile(
      this.message, this.isSendByME, this.sendBy, this.userName, this.phoneNo);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      width: MediaQuery.of(context).size.width,
      alignment: (isSendByME) ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: (isSendByME)
                    ? [const Color(0xffe84118), const Color(0xffc23616)]
                    : [const Color(0xff2f3640), const Color(0xff353b48)]),
            borderRadius: (isSendByME)
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23))),
        child: (isSendByME)
            ? Text(
                message,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            : GestureDetector(
                onTap: () {
                  locator<NavigationService>().navigateTo(UserDetailsRoute,
                      queryParams: {'id': phoneNo});
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(message,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    (sendBy == userName)
                        ? Text(
                            "مرسله من المعلن",
                            style: TextStyle(
                                color: Colors.amberAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          )
                        : Text(
                            "مرسله من" + " " + sendBy,
                            style: TextStyle(
                                color: Colors.amberAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
