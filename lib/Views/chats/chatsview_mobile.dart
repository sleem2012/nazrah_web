import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/model/user.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/services/firebase_storage.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatsViewMobile extends StatefulWidget {
  @override
  _ChatsViewMobileState createState() => _ChatsViewMobileState();
}

class ChatRoomsInfo {
  String chatRoomId, phoneNumber;
  ChatRoomsInfo({this.chatRoomId, this.phoneNumber});
}

class _ChatsViewMobileState extends State<ChatsViewMobile> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String phoneNo;
  Stream<DocumentSnapshot> loadMyInfo(String phoneNumber) {
    return _firestore.collection('users').doc(phoneNumber).snapshots();
  }

  Stream<DocumentSnapshot> loadAppInfo() {
    return _firestore.collection('info').doc('app').snapshots();
  }

  getChatRooms(String userName) {
    return _firestore
        .collection('ChatRoom')
        .where("users", arrayContains: userName)
        .snapshots();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (phoneNo == null) return Center(child: CircularProgressIndicator());
    return SingleChildScrollView(
      child: Column(
        children: [
          CenteredView(child: NavigationBar(currentRoute: 'ChatView')),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF2980b9),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Text("المحادثات",
                    style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getChatRooms(phoneNo),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "لاتوجد محادثات فالوقت الحالي",
                    style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                List<ChatRoomsInfo> chats = [];

                for (var doc in snapshot.data.docs) {
                  chats.add(ChatRoomsInfo(
                      phoneNumber: doc
                          .data()['chatRoomId']
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(phoneNo, ""),
                      chatRoomId: doc.data()['chatRoomId']));
                }

                return Padding(
                  padding:
                      const EdgeInsets.only(right: 50, left: 50, bottom: 25),
                  child: ListView.builder(
                    itemCount: chats.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          locator<NavigationService>().navigateTo(ChatRoomRoute,
                              queryParams: {'id': chats[index].chatRoomId});
                          // locator<NavigationService>().navigateoneArgument(
                          //     ChatRoomRoute, chats[index].chatRoomId);
                        },
                        child: StreamBuilder<DocumentSnapshot>(
                          stream: loadMyInfo(chats[index].phoneNumber),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              String name = snapshot.data.data()['Name'];
                              double rating = snapshot.data.data()['rating'];
                              String commission =
                                  snapshot.data.data()['Commission'];
                              String membership =
                                  snapshot.data.data()['Membership'];
                              String photoUrl =
                                  snapshot.data.data()['photo_url'];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: Container(
                                  //width: MediaQuery.of(context).size.width / 1.5,
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
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        StreamBuilder<Uri>(
                                          stream:
                                              downloadUrl(photoUrl).asStream(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting)
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            return Container(
                                              width: 100,
                                              height: 100,
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
                                                          snapshot.data
                                                              .toString()))),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        RatingBarIndicator(
                                          itemSize: 20,
                                          rating: rating,
                                          direction: Axis.horizontal,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          name,
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              (membership == 'Premium')
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "عضوية نظره المدفوعة",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Bahij',
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                              (membership == 'Premium')
                                                  ? Row(
                                                children: [
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        fontFamily: 'Bahij',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Image.asset(
                                                    'assets/images/icons/star.png',
                                                    height: 20,
                                                  ),
                                                ],
                                              )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ).showCursorOnHover;
                    },
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
    );
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      phoneNo = prefs.getString('Phone Number') ?? null;
    });
  }
}
