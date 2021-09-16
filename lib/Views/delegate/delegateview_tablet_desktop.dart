import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/services/firebase_storage.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:nazarih/widgets/unorderedlist/unorderedList.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'package:nazarih/extensions/hover_extension.dart';

class DelegateViewTabletDesktop extends StatefulWidget {
  @override
  _DelegateViewTabletDesktopState createState() =>
      _DelegateViewTabletDesktopState();
}

class _DelegateViewTabletDesktopState extends State<DelegateViewTabletDesktop> {
  ScrollController _slidingPage = ScrollController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final dateTime = DateTime.now();
  bool wait = false;
  String photoBool = 'false';
  bool writing = false;
  bool writing2 = false;
  bool error1 = false;
  bool done = false;
  ScrollController list3 = ScrollController();

  String name, id, country, phoneNo, email;

  Stream<DocumentSnapshot> loadImages(DateTime dateTime) {
    return _firestore
        .collection('delegate_temp')
        .doc(dateTime.toString())
        .snapshots();
  }

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
        child: Column(
          children: [
            CenteredView(child: NavigationBar(currentRoute: 'Delegate')),
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
                    child: Image.asset("assets/images/vectors/delegate.png"),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 40,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "تسجيل مندوب",
                            style: TextStyle(
                                fontFamily: 'Bahij',
                                fontSize: 100,
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
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "سلام عليكم ورحمة الله وبركاته",
                    style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 50,
                        color: Color(0xFF2980b9),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "حياكم الله في موقع وتطبيق نظره 👁للتسويق، الموقع والتطبيق عبارة عن أقسام لأشياء كثيرة تخص المعلن والمستهلك أو البائع والمشتري عند تحميلكم التطبيق والتسجيل فيه ستتعرفون على ما يحتويه التطبيق، التطبيق عبارة عن أقسام يستطيع صاحب السلعة الإعلان فيه من معارض السيارات والعقارات والأسر المنتجة وبائعي العسل والتمور والمطاعم والكافيهات  وأنواع الأجهزة والجوالات وأصحاب المواشي وغيرها ويوجد في التطبيق أقسام أخرى كثيرة لاحتياجات كثيرة",
                    style: TextStyle(
                      fontFamily: 'Bahij',
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "ويوجد لدينا في التطبيق اشتراك لمدة سنة(العضويات) وقيمة العضوية:(850ريال) بحيث يستطيع المعلن أو صاحب السلعة من الإعلان لمدة سنة من غير دفع أي عمولة يكفيه فقط الإشتراك وأيضاً عند الإشتراك يحصل على علامة توثيق لحسابه تظهر عند اسمه كعلامة توثيق وتميز",
                    style: TextStyle(
                      fontFamily: 'Bahij',
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "نأتي الآن للنقطة المهمة التي جمعناكم من أجلها، مهمتكم أيها الأبطال في التسويق للإشتراك في التطبيق، كل مندوب منكم عليه تسويق التطبيق لجميع الاقسام الموجودة في التطبيق عقار سيارات أو غيرها وكل مندوب يأتي بمشترك عن طريقه سوف يحصل على عمولة:(50 ريال)",
                          style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 30,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Text(
                        "🔴🔴",
                        style: TextStyle(
                          fontFamily: 'Bahij',
                          fontSize: 30,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "مثال:🤔أحمد ذهب إلى معرض سيارات أو عقار أو غيرها وعرض التطبيق والموقع وشرح لهم عن التطبيق والموقع واقتنع صاحب المعرض أو العقار أو غيره ويريد الاشتراك السنوي",
                    style: TextStyle(
                      fontFamily: 'Bahij',
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: UnorderedList([
                      "<يدفع:(850ريال) تحول للحسابات الموجود في التطبيق <في صفحة طرق تحويل العمولة ورسوم الاشتراك",
                      "يتم توثيق حسابه بعلامة التوثيق خلال 24 الى 48 ساعة ان شاء الله",
                      "أحمد يأخذ صورة الحوالة واسم صاحب الإشتراك في الموقع أو التطبيق لكي يتم توثيق حسابه في الموقع والتطبيق",
                      "يرسلها على الخاص في الواتس اب الموجود في صفحة المناديب (ويحصل على عمولة:50 ريال تحول لحسابه)",
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "ملاحظة) المندوب لا يستلم اي مبلغ كاش فقط التحويل على الحسابات الموجودة في التطبيق والموقع)",
                    style: TextStyle(
                      fontFamily: 'Bahij',
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "احمد في نفس اليوم اشترك عن طريق تسويقه (5 عملاء:250 ريال عمولة)او (10 عملاء:500 ريال عمولة)او (20 عميل 1000 ريال عمولة) أو أي عدد يحصل على كل اشتراك:50 ريال وهكذا كل مسوق وطريقته في التسويق وطريقة اقناع المشتركين",
                          style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 30,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Text(
                        "🔴🔴",
                        style: TextStyle(
                          fontFamily: 'Bahij',
                          fontSize: 30,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "لأي استفسار يمكنكم المراسلة عن طريق الواتس اب",
                    style: TextStyle(
                      fontFamily: 'Bahij',
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "🤗🤗 ،،،، وشكراً لكم ",
                    style: TextStyle(
                      fontFamily: 'Bahij',
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "تسجيل مندوب",
                  style: TextStyle(
                    fontFamily: 'Bahij',
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: ((MediaQuery.of(context).size.width / 2) - 40) / 2,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      onChanged: (val) {
                        name = val;
                      },
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'الاسم',
                          fillColor: Colors.blueGrey[50],
                          filled: true,
                          // icon: Icon(Icons.phone_android),
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Bahij',
                          ),
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Bahij',
                          ),
                          contentPadding: EdgeInsets.only(right: 30, left: 30),
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
                  width: ((MediaQuery.of(context).size.width / 2) - 40) / 2,
                  child: Directionality(
                    textDirection: (writing == false)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: TextField(
                      onChanged: (val) {
                        if (val != '') {
                          setState(() {
                            writing = true;
                          });
                        } else {
                          setState(() {
                            writing = false;
                          });
                        }
                        id = val;
                      },
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'رقم الهوية - الاقامة',
                          fillColor: Colors.blueGrey[50],
                          filled: true,
                          // icon: Icon(Icons.phone_android),
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Bahij',
                          ),
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Bahij',
                          ),
                          contentPadding: EdgeInsets.only(right: 30, left: 30),
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
                  width: ((MediaQuery.of(context).size.width / 2) - 40) / 2,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      onChanged: (val) {
                        country = val;
                      },
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'المدينة',
                          fillColor: Colors.blueGrey[50],
                          filled: true,
                          // icon: Icon(Icons.phone_android),
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Bahij',
                          ),
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Bahij',
                          ),
                          contentPadding: EdgeInsets.only(right: 30, left: 30),
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
                  width: ((MediaQuery.of(context).size.width / 2) - 40) / 2,
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
                        phoneNo = val;
                      },
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'رقم الجوال',
                          fillColor: Colors.blueGrey[50],
                          filled: true,
                          // icon: Icon(Icons.phone_android),
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Bahij',
                          ),
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Bahij',
                          ),
                          contentPadding: EdgeInsets.only(right: 30, left: 30),
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
                  width: ((MediaQuery.of(context).size.width / 2) - 40) / 2,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      onChanged: (val) {
                        email = val;
                      },
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'البريد الالكتروني (اختياري)',
                          fillColor: Colors.blueGrey[50],
                          filled: true,
                          // icon: Icon(Icons.phone_android),
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Bahij',
                          ),
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Bahij',
                          ),
                          contentPadding: EdgeInsets.only(right: 30, left: 30),
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
                  width: ((MediaQuery.of(context).size.width / 2) - 40) / 2,
                  height: 300,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Color(0xFF2980b9)),
                      borderRadius: BorderRadius.circular(5)),
                  child: (wait)
                      ? StreamBuilder<DocumentSnapshot>(
                          stream: loadImages(dateTime),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data.data() != null) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              int photoLimit =
                                  snapshot.data.data()['photo_limit'];

                              photoBool = "true";

                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () async {
                                    await _firestore
                                        .collection('delegate_temp')
                                        .doc(dateTime.toString())
                                        .delete();
                                    uploadDelegateImages(dateTime);
                                  },
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
                                    child: Tooltip(
                                      message:
                                          'ان كنت تريد استبدال الصور المرفوعة عاود الضغط مره اخري',
                                      child: GridView.builder(
                                        controller: list3,
                                        itemCount: photoLimit,
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 200,
                                                mainAxisExtent: 290,
                                                childAspectRatio: 3 / 2,
                                                crossAxisSpacing: 20,
                                                mainAxisSpacing: 20),
                                        itemBuilder: (context, index) {
                                          return StreamBuilder<Uri>(
                                            stream: downloadUrl(snapshot.data
                                                    .data()['photo_url $index'])
                                                .asStream(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting)
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
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
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              wait = true;
                            });
                            uploadDelegateImages(dateTime);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 50,
                              ),
                              Text(
                                'نرجو ارفاق كافة المستندات المطلوب ارفاقها والمتمثلة بما يلي',
                                style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ارفاق صورة الهوية - الاقامة',
                                style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ارفاق صورة الحساب البنكي الايبان',
                                style: TextStyle(
                                    fontFamily: 'Bahij',
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ).showCursorOnHover,
                        ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: ((MediaQuery.of(context).size.width / 2) - 40) / 2,
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
                        "أرسال",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Bahij',
                        ),
                      )),
                    ),
                    onPressed: () async {
                      if (photoBool == 'true' &&
                          phoneNo != null &&
                          id != null &&
                          name != null) {
                        List imagePaths = [];
                        int imageCount;
                        await _firestore
                            .collection('delegate_temp')
                            .doc(dateTime.toString())
                            .get()
                            .then((DocumentSnapshot documentSnapshot) => {
                                  imageCount =
                                      documentSnapshot.data()['photo_limit'],
                                  for (var i = 0; i < imageCount; i++)
                                    {
                                      imagePaths.add(documentSnapshot
                                          .data()['photo_url $i'])
                                    }
                                });
                        _firestore
                            .collection('delegate')
                            .doc(dateTime.toString())
                            .set({
                          'name': name,
                          'phone number': phoneNo,
                          'id': id,
                          'imageCount': imageCount,
                          'email': email,
                          'country': country,
                          'datetime': dateTime
                        });
                        for (var i = 0; i < imagePaths.length; i++) {
                          await _firestore
                              .collection('delegate')
                              .doc(dateTime.toString())
                              .update({'photo_url $i': imagePaths[i]});
                        }
                        await _firestore
                            .collection('delegate_temp')
                            .doc(dateTime.toString())
                            .delete();
                        setState(() {
                          error1 = false;
                          done = true;
                        });
                      } else {
                        setState(() {
                          error1 = true;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF2980b9),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ).mouseUpOnHover,
                (error1)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          "!برجاء ادخال جميع المعلومات المطلوبة",
                          style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 30,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      )
                    : (done)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              "!لقد تلقينا طلبك",
                              style: TextStyle(
                                  fontFamily: 'Bahij',
                                  fontSize: 30,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                          )
                        : Container(),
              ],
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
