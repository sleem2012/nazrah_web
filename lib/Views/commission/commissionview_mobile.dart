import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:clipboard/clipboard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sizer/sizer.dart';

class CommissionViewMobile extends StatefulWidget {
  @override
  _CommissionViewMobileState createState() => _CommissionViewMobileState();
}

class _CommissionViewMobileState extends State<CommissionViewMobile> {
  bool tap1 = false;
  bool tap2 = false;
  bool writing = false;
  double commission = 0;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<DocumentSnapshot> loadAppInfo() {
    return _firestore.collection('info').doc('app').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CenteredView(child: NavigationBar(currentRoute: 'Commission')),
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
                  child: Image.asset(
                    "assets/images/vectors/commission.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width / 2) - 40,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "بيع منتجك بعمولة 0.5% فقط في نظره",
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
                          "العمولة أمانة في ذمة المعلن سواء تمت المبايعة عن طريق الموقع أو بسببه، وموضحة قيمتها بما يلي حساب العمولة",
                          style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 12.sp,
                              color: Colors.grey,
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
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 450,
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
                                    AssetImage('assets/images/icons/box.png'))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "عمولة السلع و الخدمات الأخرى",
                        style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: RichText(
                                text: TextSpan(
                                  text: '• ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontFamily: 'Bahij'),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'بيع سلعة: 0.5% من قيمة السلعة المباعة',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Bahij',
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: RichText(
                                text: TextSpan(
                                  text: '• ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontFamily: 'Bahij'),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'تأجير سلع(معدات وغيرها): 0.5% من قيمة مبلغ الإيجار',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Bahij',
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: RichText(
                                text: TextSpan(
                                  text: '• ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontFamily: 'Bahij'),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'تقديم خدمات: 0.5% من قيمة الخدمة المقدمة',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Bahij',
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: RichText(
                                text: TextSpan(
                                  text: '• ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontFamily: 'Bahij'),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'طلب سلعة أو خدمة: 0.5% من قيمة المبايعة',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Bahij',
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 450,
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
                                    'assets/images/icons/apartment_.png'))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "عمولة العقارات",
                        style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: RichText(
                                text: TextSpan(
                                  text: '• ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontFamily: 'Bahij'),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'بيع عقار عن طريق المالك: 0.5% من قيمة العقار',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Bahij',
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: RichText(
                                text: TextSpan(
                                  text: '• ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontFamily: 'Bahij'),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'بيع عقار عن طريق وسيط: يعتبر الموقع شريك في الوساطة',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Bahij',
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: RichText(
                                text: TextSpan(
                                  text: '• ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontFamily: 'Bahij'),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'تأجير عقارات: 0.5% من قيمة عقد الإيجار الجديد فقط',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Bahij',
                                            color: Colors.white)),
                                  ],
                                ),
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
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 450,
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
                                    'assets/images/icons/car_.png'))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "عمولة السيارات",
                        style: TextStyle(
                            fontFamily: 'Bahij',
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: RichText(
                                text: TextSpan(
                                  text: '• ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontFamily: 'Bahij'),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'بيع السيارات: 0.5% من قيمة السيارة',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Bahij',
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: RichText(
                                text: TextSpan(
                                  text: '• ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontFamily: 'Bahij'),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'سيارات للتنازل: 0.5% من قيمة التنازل إذا كان التنازل بمقابل',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Bahij',
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: RichText(
                                text: TextSpan(
                                  text: '• ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontFamily: 'Bahij'),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'تبادل السيارات: 0.5% من قيمة المبادلة إذا كان هناك مقابل للمبادلة',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: 'Bahij',
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
                            image: AssetImage(
                                'assets/images/icons/calculator.png'))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "حساب العمولة",
                    style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
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
                          String result = ConvertDigitsToLatin(val.toString());
                          print(result);
                          setState(() {
                            commission = double.parse(result) * 0.005;
                          });
                        },
                        textAlign: (writing == false)
                            ? TextAlign.right
                            : TextAlign.left,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontFamily: "Bahij",
                          fontSize: 12.sp,
                        ),
                        decoration: InputDecoration(
                            hintText: 'ادخل سعر البيع',
                            fillColor: Colors.blueGrey[50],
                            filled: true,
                            labelStyle: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Bahij',
                            ),
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Bahij',
                            ),
                            contentPadding:
                                EdgeInsets.only(right: 30, left: 30),
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
                    height: 15,
                  ),
                  Text(
                    "العمولة المستحقة : $commission ريال",
                    style: TextStyle(
                        fontFamily: 'Bahij',
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
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

String replaceFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  String _final;
  for (int i = 0; i < farsi.length; i++) {
    _final = input.replaceAll(farsi[i], english[i]);
  }

  return _final;
}

String ConvertDigitsToLatin(String s) {
  var sb = new StringBuffer();
  for (int i = 0; i < s.length; i++) {
    switch (s[i]) {
      //Persian digits
      case '\u06f0':
        sb.write('0');
        break;
      case '\u06f1':
        sb.write('1');
        break;
      case '\u06f2':
        sb.write('2');
        break;
      case '\u06f3':
        sb.write('3');
        break;
      case '\u06f4':
        sb.write('4');
        break;
      case '\u06f5':
        sb.write('5');
        break;
      case '\u06f6':
        sb.write('6');
        break;
      case '\u06f7':
        sb.write('7');
        break;
      case '\u06f8':
        sb.write('8');
        break;
      case '\u06f9':
        sb.write('9');
        break;

      //Arabic digits
      case '\u0660':
        sb.write('0');
        break;
      case '\u0661':
        sb.write('1');
        break;
      case '\u0662':
        sb.write('2');
        break;
      case '\u0663':
        sb.write('3');
        break;
      case '\u0664':
        sb.write('4');
        break;
      case '\u0665':
        sb.write('5');
        break;
      case '\u0666':
        sb.write('6');
        break;
      case '\u0667':
        sb.write('7');
        break;
      case '\u0668':
        sb.write('8');
        break;
      case '\u0669':
        sb.write('9');
        break;
      default:
        sb.write(s[i]);
        break;
    }
  }
  return sb.toString();
}
