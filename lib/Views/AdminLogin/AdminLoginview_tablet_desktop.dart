import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/Views/AdminPanel/AdminPanelview_tablet_desktop.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

class AdminLoginViewTabletDesktop extends StatefulWidget {
  @override
  _AdminLoginViewTabletDesktopState createState() =>
      _AdminLoginViewTabletDesktopState();
}

class _AdminLoginViewTabletDesktopState
    extends State<AdminLoginViewTabletDesktop> {
  ScrollController _slidingPage;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String username, password;
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo/logo.png",
                width: MediaQuery.of(context).size.width / 4,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF2980b9),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20),
                    ]),
                child: Form(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Bahij',
                          ),
                          onChanged: (val) {
                            username = val;
                          },
                          cursorColor: Colors.white,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            hintText: "أسم المستخدم",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Bahij',
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Bahij',
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          onChanged: (val) {
                            password = val;
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: "كلمة السر",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Bahij',
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextButton(
                          onPressed: () async {
                            if (username == '' ||
                                password == '' ||
                                username == null ||
                                password == null) {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => PanelHome()));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                'برجاء ادخال المعلومات بشكل صحيح',
                                textAlign: TextAlign.right,
                              )));
                            } else {
                              String username2, password2;
                              await _firestore
                                  .collection('info')
                                  .doc('Admin Info')
                                  .get()
                                  .then((DocumentSnapshot documentSnapshot) => {
                                        username2 =
                                            documentSnapshot.data()['Username'],
                                        password2 =
                                            documentSnapshot.data()['Password']
                                      });
                              if (username == username2 &&
                                  password == password2) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PanelHome()));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  'برجاء ادخال المعلومات بشكل صحيح!',
                                  textAlign: TextAlign.right,
                                )));
                              }
                            }
                          },
                          child: Text(
                            "تسجيل دخول",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
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
