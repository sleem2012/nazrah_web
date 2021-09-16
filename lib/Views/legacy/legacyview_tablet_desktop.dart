import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:nazarih/widgets/unorderedlist/unorderedList.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'package:nazarih/extensions/hover_extension.dart';

class LegacyViewTabletDesktop extends StatefulWidget {
  @override
  _LegacyViewTabletDesktopState createState() =>
      _LegacyViewTabletDesktopState();
}

class _LegacyViewTabletDesktopState extends State<LegacyViewTabletDesktop> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<DocumentSnapshot> loadAppInfo() {
    return _firestore.collection('info').doc('app').snapshots();
  }

  ScrollController _slidingPage = ScrollController();
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
            CenteredView(child: NavigationBar(currentRoute: 'Legacy')),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF2980b9),
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 40,
                    child: Image.asset("assets/images/vectors/legacy.png"),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 40,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "السلع والإعلانات الممنوعة",
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
                    "السلع الممنوعة",
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
                    "السلعة الموضحة هي السلع الممنوعة في الموقع. هذه السلع ممنوع الاعلان عنها في الموقع و ممنوع ايضا شرائها عبر الموقع. نحن نقوم بحظر المعلن الذي يقوم بالاعلان عن هذه السلع و نقوم بحظر من يتجاوب معه عبر الرسائل الخاصة أو عبر الردود. نرجو ملاحظة ان ليس هناك تنبيه قبل الحظر وان الحظر نهائي لانقاش فيه",
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
                    ":السلع الممنوعة هي",
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
                      "جميع السلع الممنوعة حسب قوانين المملكة العربية السعودية",
                      "التقسيط و المنتجات البنكية. هذه السلع ممنوعه حتى لوكانت تعتبر شرعية",
                      "الأدوية والمنتجات الطبية والصحية‫.‬ هذه السلع ممنوعه حتى لو كان مسموح بها في قوانين وزارة الصحة وحتى لو كانت سلع موصى بها من الوازرة",
                      "التسويق الشبكي‫.‬ يمنع نهائيا اي نوع من التسويق الشبكي مهما كان نوعه او صفته أو طريقته",
                      "الأسلحة بمافيها الصواعق والمسدسات و الرشاشات واسلحة الحماية الشخصية و مستلزماتها حتى لو كانت مرخصة",
                      "المنتجات الجنسية بكافة أشكالها وأنواعها",
                      "الأسهم و إدارة المحافظ والعملات وتسويقها وجميع مايتعلق بذلك",
                      "أجهزة الليزر وأجهزة التجسس و التنصت",
                      "المواقع والمنتديات والخدمات الإلكترونية والإيميلات وبيع العضويات والبرامج",
                      "بيع أي سلعه مجانية. مثال على ذلك الإيميلات وحسابات تويتر وانستقرام وغيرها",
                      "السلع التي فيها إعتداء على حقوق الملكية الفكرية مثلا البرامج المنسوخة والأفلام المنسوخة",
                      "منتجات التبغ",
                      "الإعلان عن منتجات أو خدمات تتطلب ترخيص من دون الحصول على الترخيص من الجهة المنظمة",
                      "الأجهزة الممنوعة مثل: أجهزة التشويش أو التشفير أو تقوية إشارة الجوال",
                      "الأجهزة ذات المخاطر الأمنية",
                      "الإعلان عن شرائح اتصال او خدمات اتصالات من دون الحصول على التراخيص اللازمة و من دون رفعها لنظام التراخيص بالموقع"
                    ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "الإعلانات الممنوعه",
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
                    ":القائمة التالية تحتوي على أغلب أساليب وطرق الإعلانات الممنوعه في الموقع",
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
                      "جميع الإعلانات التي لاتتعلق بالبيع والشراء",
                      "طرح مواضيع في الموقع",
                      "الإعلان لأجل إضافة إقتراح او مناقشة مشكلة مع الإدارة في الموقع‫.‬ الإعلانات مخصصة للبيع والشراء فقط‫.‬ إضافة إعلانات عن إقتراحات لتطوير الموقع في المعروضات يلحق الضرر بإعلانات المعلنين في الموقع‫.‬ أفضل طريقة للإقتراح أو الشكوى هي الإتصال بنا عبر نموذج اتصل بنا",
                      "الإعلان غير مكتمل التفاصيل",
                      "إعلان ضعيف الجودة",
                      "ضعف تواصل المعلن مع الاعضاء المهتمين بالسلعه المعروضة‫.‬ مثلا معلن يعلن بيع سياره ثم لايقوم بالرد على الاتصالات او الرد على الرسائل الخاصة",
                      "الإعلان في قسم خطأ‫.‬ مثلا الإعلان عن طلب سياره في المعروضات‫.‬ أو مثلا إعلان عن بيع أثاث في قسم حراج السيارات‫.‬ او مثلا الإعلان عن جيب شيروكي للبيع في قسم فورد",
                      "إضافة إعلان ولديك عضوية أخرى محظورة. يجب أولا مناقشة الحظر معنا قبل إضافة إي اعلان جديد",
                      "إضافة صورة ليست لنفس السلعه إذا كانت السلعة سيارة حتى لو كان لغرض التوضيح",
                      "إضافة صور لسلعة أخرى غير المعروضة. مثلا معلن يعلن عن بيع جوال مستعمل ثم يعرض صورة لجوال مستعمل اخر من نفس النوع",
                      "إي إعلان يحتوي على إشارة لأي أمر عنصري بكافة أشكاله",
                      "إي إعلان يحتوي على معلومات خطأ سواء كان الخطأ مقصود أو غير مقصود‫.‬ مثلا معلن يعلن عن سياره ويذكر انها لم تتعرض لحادث ثم بعد ذلك يثبت أن السياره قد تعرضت لحادث‫.‬ يجب على المعلن عدم إضافة أي معلومة عن السلعه إلا التي هو متأكد منها",
                      "إضافة إعلان بغرض التشهير. إذا كانت لديك شكوى ضد معلن لدينا نرجو مراسلتنا وتوضيح المشكلة. إذا كانت لديك مشكلة مع جهة لاعلاقه لنا بها نرجو الشكوى لدى الجهة المسؤولة عن ذلك",
                      "إضافة عنوان إعلان مخالف لمحتوى الإعلان‫.‬ مثلا معلن يكتب في العنوان‫:‬ كامري 2011 ثم في الإعلان يعلن عن طلب كامري 2011‫.‬ الزائر عندما يرى العنوان سيعتقد ان هناك عرض عن كامري 2011",
                      "نسخ إعلان لمعلن آخر او جزء منه",
                      "الإعلانات العامة التي لايتم تحديد السلعه بعينها مثل‫:‬ الإعلان بعنوان ‫(‬يوجد لدينا اراضي للبيع‫)‬ او مثلا الإعلان بعنوان يوجد في معرضنا سيارات للبيع‫.‬ الصحيح هو الإعلان عن السلعه ذاتها مثلا يوجد لدينا ارض للبيع مساحة كذا وكذا في حي كذا وكذا بمدينة الرياض مثلا‫.‬ او يوجد لدينا سياره موديل كذا وكذا",
                      "إعلانات التبرع وطلب المساعدة. نظام الدوله يمنع التبرع والعمل الخيري خارج النطاق القانوني المحدد المخصص لذلك",
                      "الإعلانات عن مساهمات وإشتراكات",
                      "التوسل ومساعدة المتسولين . نحن نقوم بحظر العضو الذي يقوم مساعدة المتسولين في الموقع",
                      "طلب الواسطة والمساعدات سواء كانت مشروعه أو غير مشروعه. الموقع للسلع فقط",
                      "الإعلانات التي تحتوي على سوء إستغلال سلطة",
                      "الإعلان في الردود"
                    ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "الردود الممنوعة",
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
                    ":القائمة التالية تحتوي على أغلب الردود الممنوعة",
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
                      "الإعلان في الردود",
                      "البخس",
                      "السب و الشتم سواء كان هناك مبرر ام يكن هناك مبرر",
                      "عدم الجدية و عدم الرغبة في الشراء",
                      "التعليق لاجل اضافة نكته او سالفة او خبر. الموقع للبيع والشراء فقط",
                      "الاستهزاء بالسلعة او المعلن"
                    ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "الرسائل الخاصة الممنوعة",
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
                    ":القائمة التالية تحتوي على أغلب الرسائل الخاصة الممنوعة",
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
                      "الإعلان في الرسائل الخاصة",
                      "السب و الشتم سواء كان هناك مبرر ام يكن هناك مبرر",
                    ]),
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
}
