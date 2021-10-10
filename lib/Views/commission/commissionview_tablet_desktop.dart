import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:clipboard/clipboard.dart';
import 'package:nazarih/widgets/unorderedlist/unorderedList.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'package:sizer/sizer.dart';

class CommissionViewTabletDesktop extends StatefulWidget {
  @override
  _CommissionViewTabletDesktopState createState() =>
      _CommissionViewTabletDesktopState();
}

class _CommissionViewTabletDesktopState
    extends State<CommissionViewTabletDesktop> {
  bool tap1 = false;
  bool tap2 = false;
  bool writing = false;

  double commission = 0;

  ScrollController _slidingPage = ScrollController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
        controller: _slidingPage,
        child: Column(
          children: [
            CenteredView(child: NavigationBar(currentRoute: 'Commission')),
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
                    child: Image.asset("assets/images/vectors/commission.png"),
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
                                fontSize: 50,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "العمولة أمانة في ذمة المعلن سواء تمت المبايعة عن طريق الموقع أو بسببه، وموضحة قيمتها بما يلي حساب العمولة",
                            style: TextStyle(
                                fontFamily: 'Bahij',
                                fontSize: 40,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 3) - 40,
                    height: 32.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF2980b9),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 30.w,
                          height: 10.h,
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
                                      'assets/images/icons/box.png'))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "عمولة السلع و الخدمات الأخرى",
                          style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
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
                                        fontSize: 10.sp,
                                        fontFamily: 'Bahij'),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'بيع سلعة: 0.5% من قيمة السلعة المباعة',
                                          style: TextStyle(
                                              fontSize: 10.sp,
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
                                        fontSize: 10.sp,
                                        fontFamily: 'Bahij'),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'تأجير سلع(معدات وغيرها): 0.5% من قيمة مبلغ الإيجار',
                                          style: TextStyle(
                                              fontSize: 10.sp,
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
                                        fontSize: 10.sp,
                                        fontFamily: 'Bahij'),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'تقديم خدمات: 0.5% من قيمة الخدمة المقدمة',
                                          style: TextStyle(
                                              fontSize: 10.sp,
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
                                        fontSize: 10.sp,
                                        fontFamily: 'Bahij'),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'طلب سلعة أو خدمة: 0.5% من قيمة المبايعة',
                                          style: TextStyle(
                                              fontSize: 10.sp,
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
                  Container(
                    width: (MediaQuery.of(context).size.width / 3) - 40,
                    height: 32.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF2980b9),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 30.w,
                          height: 10.h,
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
                              fontSize: 14.sp,
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
                                        fontSize: 10.sp,
                                        fontFamily: 'Bahij'),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'بيع عقار عن طريق المالك: 0.5% من قيمة العقار',
                                          style: TextStyle(
                                              fontSize: 10.sp,
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
                                        fontSize: 10.sp,
                                        fontFamily: 'Bahij'),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'بيع عقار عن طريق وسيط: يعتبر الموقع شريك في الوساطة',
                                          style: TextStyle(
                                              fontSize: 10.sp,
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
                                        fontSize: 10.sp,
                                        fontFamily: 'Bahij'),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'تأجير عقارات: 0.5% من قيمة عقد الإيجار الجديد فقط',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              fontFamily: 'Bahij',
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        // Text(
                        //   "بيع عقار عن طريق المالك: 0.5% من قيمة العقار • ",
                        //   style: TextStyle(
                        //     fontFamily: 'Bahij',
                        //     fontSize: 30,
                        //     color: Colors.white,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                        // Text(
                        //   "بيع عقار عن طريق وسيط: يعتبر الموقع شريك في الوساطة • ",
                        //   style: TextStyle(
                        //     fontFamily: 'Bahij',
                        //     fontSize: 30,
                        //     color: Colors.white,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                        // Text(
                        //   "تأجير عقارات: 0.5% من قيمة عقد الإيجار الجديد فقط • ",
                        //   style: TextStyle(
                        //     fontFamily: 'Bahij',
                        //     fontSize: 30,
                        //     color: Colors.white,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                        // Text(
                        //   "",
                        //   style: TextStyle(
                        //     fontFamily: 'Bahij',
                        //     fontSize: 30,
                        //     color: Colors.white,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 3) - 40,
                    height: 32.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF2980b9),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 30.w,
                          height: 10.h,
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
                              fontSize: 14.sp,
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
                                        fontSize: 10.sp,
                                        fontFamily: 'Bahij'),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'بيع السيارات: 0.5% من قيمة السيارة',
                                          style: TextStyle(
                                              fontSize: 10.sp,
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
                                        fontSize: 10.sp,
                                        fontFamily: 'Bahij'),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'سيارات للتنازل: 0.5% من قيمة التنازل إذا كان التنازل بمقابل',
                                          style: TextStyle(
                                              fontSize: 10.sp,
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
                                        fontSize: 10.sp,
                                        fontFamily: 'Bahij'),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'تبادل السيارات: 0.5% من قيمة المبادلة إذا كان هناك مقابل للمبادلة',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              fontFamily: 'Bahij',
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        // Text(
                        //   "بيع السيارات:0.5% من قيمة السيارة • ",
                        //   style: TextStyle(
                        //     fontFamily: 'Bahij',
                        //     fontSize: 30,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // Text(
                        //   "سيارات للتنازل:0.5% من قيمة التنازل إذا كان التنازل بمقابل • ",
                        //   style: TextStyle(
                        //     fontFamily: 'Bahij',
                        //     fontSize: 30,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // Text(
                        //   "تبادل السيارات:0.5% من قيمة المبادلة إذا كان هناك مقابل للمبادلة • ",
                        //   style: TextStyle(
                        //     fontFamily: 'Bahij',
                        //     fontSize: 30,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // Text(
                        //   "",
                        //   style: TextStyle(
                        //     fontFamily: 'Bahij',
                        //     fontSize: 30,
                        //     color: Colors.white,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
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
                height: 600,
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
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
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
                            setState(() {
                              commission = double.parse(val) * 0.005;
                            });
                          },
                          textAlign: (writing == false)
                              ? TextAlign.right
                              : TextAlign.left,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontFamily: "Bahij",
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                              hintText: 'ادخل سعر البيع',
                              fillColor: Colors.blueGrey[50],
                              filled: true,
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Bahij',
                              ),
                              hintStyle: TextStyle(
                                fontSize: 20,
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
                      height: 20,
                    ),
                    Text(
                      "العمولة المستحقة : $commission ريال",
                      style: TextStyle(
                          fontFamily: 'Bahij',
                          fontSize: 30,
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
                height: 650,
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
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
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
                            width: 500,
                            height: 350,
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
                                          fontSize: 50,
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
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "مؤسسة موقع نظره للخدمات التسويقية",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "رقم الحساب",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "471000010006086055873",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Color(0xFF2980b9),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "رقم الايبان",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "SA4980000471608016055873",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Color(0xFF2980b9),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                          ).showCursorOnHover.mouseUpOnHover,
                        ),
                        SizedBox(
                          width: 50,
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
                            width: 500,
                            height: 350,
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
                                          fontSize: 50,
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
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "مؤسسة موقع نظره للخدمات التسويقية",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "رقم الحساب",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "18700000322007",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Color(0xFF2980b9),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "رقم الايبان",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Text(
                                          "SA10000018700000322007",
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 30,
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
      ),
    );
  }
}
