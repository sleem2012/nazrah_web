import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/services/firebase_storage.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

class ChatRoomViewTabletDesktop extends StatefulWidget {
  final String chatRoomId;

  ChatRoomViewTabletDesktop({@required this.chatRoomId});
  @override
  _ChatRoomViewTabletDesktopState createState() =>
      _ChatRoomViewTabletDesktopState(chatRoomId: chatRoomId);
}

addConversationMessages(String chatRoomId, messageMap) {
  FirebaseFirestore.instance
      .collection('ChatRoom')
      .doc(chatRoomId)
      .collection('chats')
      .add(messageMap);
}

getChatRoom(String chatRoomId) {
  return FirebaseFirestore.instance
      .collection('ChatRoom')
      .doc(chatRoomId)
      .snapshots();
}

getConversationMessages(String chatRoomId) {
  return FirebaseFirestore.instance
      .collection('ChatRoom')
      .doc(chatRoomId)
      .collection('chats')
      .orderBy('time')
      .snapshots();
}

class _ChatRoomViewTabletDesktopState extends State<ChatRoomViewTabletDesktop> {
  String chatRoomId;
  _ChatRoomViewTabletDesktopState({@required this.chatRoomId});
  TextEditingController messageController = new TextEditingController();
  Stream chatMessagesStream;
  String phoneNo;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var textDirection = TextDirection.rtl;

  Stream<DocumentSnapshot> loadMyInfo(String phoneNumber) {
    return _firestore.collection('users').doc(phoneNumber).snapshots();
  }

  Stream<DocumentSnapshot> loadAppInfo() {
    return _firestore.collection('info').doc('app').snapshots();
  }

  Widget chatMessagesList() {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return (snapshot.hasData)
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      snapshot.data.docs[index]["message"],
                      snapshot.data.docs[index]["sendBy"] == phoneNo,
                      snapshot.data.docs[index]["name"]);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() async {
    if (messageController.text.isNotEmpty) {
      String username;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(phoneNo)
          .get()
          .then((DocumentSnapshot documentSnapshot) => {
                username = documentSnapshot.data()['Name'],
              });
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": phoneNo,
        "time": DateTime.now().microsecondsSinceEpoch,
        'name': username
      };
      addConversationMessages(chatRoomId, messageMap);
      messageController.text = '';
      scolldown();
      String tempPhoneNumber =
          chatRoomId.toString().replaceAll("_", "").replaceAll(phoneNo, "");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(tempPhoneNumber)
          .collection('Notifications')
          .doc()
          .set({
        "message": "لقد تلقيت رسالة جديده من" + " " + username,
        'date': DateTime.now().microsecondsSinceEpoch,
        'type': 'message',
        'docId': chatRoomId
      });
    }
  }

  final ScrollController _scrollController = ScrollController();

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
        Duration(seconds: 1),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn));
    super.initState();
  }

  ScrollController _slidingPage = ScrollController();

  @override
  Widget build(BuildContext context) {
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
            CenteredView(child: NavigationBar(currentRoute: 'ChatRoom')),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
            ),
            SizedBox(
              height: 50,
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: getChatRoom(chatRoomId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String phoneNumber = snapshot.data
                      .data()['chatRoomId']
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(phoneNo, "");
                  return StreamBuilder<DocumentSnapshot>(
                    stream: loadMyInfo(phoneNumber),
                    builder: (context, snapshot) {
                      String name = snapshot.data.data()['Name'];
                      String chatPhoneNumber =
                          snapshot.data.data()['Phone Number'];
                      String photoUrl = snapshot.data.data()['photo_url'];
                      return Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // locator<NavigationService>().navigateoneArgument(
                                //   UserDetailsRoute,
                                //   chatPhoneNumber,
                                // );
                                locator<NavigationService>().navigateTo(
                                    UserDetailsRoute,
                                    queryParams: {'id': chatPhoneNumber});
                              },
                              child: StreamBuilder<Uri>(
                                stream: downloadUrl(photoUrl).asStream(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting)
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  return Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 4, color: Colors.white),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              color:
                                                  Colors.black.withOpacity(0.1),
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
                            ).showCursorOnHover,
                            Text("محادثة مع" + " " + name,
                                style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 50,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    },
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
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                  color: Color(0xFF2980b9),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue[100],
                        spreadRadius: 10,
                        blurRadius: 20)
                  ]),
              child: Stack(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: getConversationMessages(chatRoomId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data.docs.length == 0) {
                        return Center(
                          child: Text(
                            "لاتوجد رسائل فالوقت الحالي",
                            style: TextStyle(
                                fontFamily: 'Bahij',
                                fontSize: 35,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return MessageTile(
                                snapshot.data.docs[index]["message"],
                                snapshot.data.docs[index]["sendBy"] == phoneNo,
                                snapshot.data.docs[index]["name"]);
                          },
                        );
                      }
                    },
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Color(0x54FFFFFF),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: messageController,
                              textAlign: TextAlign.right,
                              textDirection: textDirection,
                              onChanged: (val) {
                                RegExp exp = RegExp("[a-zA-Z]");
                                if (exp.hasMatch(
                                        val.substring(val.length - 1)) &&
                                    val.substring(val.length - 1) != " ") {
                                  setState(() {
                                    textDirection = TextDirection.ltr;
                                  });
                                } else if (val.substring(val.length - 1) !=
                                        " " &&
                                    !exp.hasMatch(
                                        val.substring(val.length - 1))) {
                                  setState(() {
                                    textDirection = TextDirection.rtl;
                                  });
                                }
                              },
                              style: TextStyle(
                                  fontFamily: 'Bahij',
                                  fontSize: 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  hintText: "الرسالة....",
                                  hintStyle: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 35,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  border: InputBorder.none),
                            )),
                            GestureDetector(
                              onTap: () {
                                sendMessage();
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ).showCursorOnHover.mouseUpOnHover
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
  MessageTile(this.message, this.isSendByME, this.sendBy);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
            : Column(
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
                  Text(
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
    );
  }
}
