import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:nazarih/widgets/unorderedlist/unorderedList.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sizer/sizer.dart';

class TermsViewMobile extends StatefulWidget {
  @override
  _TermsViewMobileState createState() => _TermsViewMobileState();
}

class _TermsViewMobileState extends State<TermsViewMobile> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<DocumentSnapshot> loadAppInfo() {
    return _firestore.collection('info').doc('app').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CenteredView(child: NavigationBar(currentRoute: 'Terms')),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
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
                  child: Image.asset("assets/images/vectors/terms.png"),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width / 2) - 40,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "اتفاقية استخدام الموقع والمعلومات",
                          style: TextStyle(
                              fontFamily: 'Bahij',
                              fontSize: 18.sp,
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
                  "مقدمة",
                  style: TextStyle(
                      fontFamily: 'Bahij',
                      fontSize: 18.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "تم إنشاء الاتفاقية بناء على نظام التعاملات الإلكترونية تخضع البنود والشروط والأحكام والمنازعات القانونية للقوانين والتشريعات والأنظمة المعمول بها في المملكة العربية السعودية",
                  style: TextStyle(
                    fontFamily: 'Bahij',
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "هام! هذه اتفاقية قانونية ملزمة يُرجى قراءة شروط وأحكام الاستخدام بعناية قبل استخدام هذا الموقع والموافقة عليها",
                  style: TextStyle(
                    fontFamily: 'Bahij',
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: UnorderedListMobile([
                    "مؤسسة موقع نظره للخدمات التسويقية منصة الكترونية سعودية 100% تمكن البائع من فتح حساب وعرض خدماته للمستهلك تحت مسؤوليته مقابل عمولة وقدرها: 0,5% من قيمة الإعلان ما بعد البيع تحول الى حسابات المؤسسة الموجودة في صفحة حساب العمولة او صفحة العضوية",
                    "الاشتراك في العضوية السنوية وقدرها: 850 ريال سعودي تحول الى حساب المؤسسة في صفحة حساب العمولة او صفحة العضوية وبموجب هذه العضوية يمكن للمعلن استخدام الموقع لمدة سنه ويمكنه الإعلان من غير دفع أي عمولة خلال مدة الاشتراك"
                  ]),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "شروط الاستخدام",
                  style: TextStyle(
                      fontFamily: 'Bahij',
                      fontSize: 18.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: UnorderedListMobile([
                    "عدم الإعلان لجميع السلع والخدمات الممنوعة بحسب قوانين المملكة العربية السعودية",
                    "عدم الإعلان عن منتجات التبغ والدخان ومشتقاتها",
                    "عدم التعرض لاي معلن بالإساءة في التعليقات او التعليق في غير موضوع الإعلان او الازعاج او السب والشتم او العنصرية",
                    "عدم الإعلان عن الفوركس والأسهم والتسويق الشبكي والتقسيط والمنتجات البنكية وإدارة المحافظ",
                    "عدم الإعلان عن المنتجات الطبية والصحية والأدوية والاعشاب الغير مرخصة ويجب ان تكون مرخصة من الجهات المختصة",
                    "عدم الإعلان عن المنتجات الجنسية بكافة أنواعها",
                    "عدم الإعلان عن الأسلحة بجميع أنواعها وأجهزة الليزر والتنصت والتجسس",
                    "المصداقية في الإعلان وصحة جميع المعلومات المذكورة للسلعة وشرحها بالكامل في الإعلان",
                    "الإعلان يجب ان يكون في القسم الصحيح",
                    "عدم الإعلان عن بيع الاقامات والاتجار بالبشر",
                    "يجب عند التسجيل ان يكون الاسم لائق وعدم استخدام الأسماء الغير لائقة",
                    "يحق لنظره حذف الإعلانات المسيئة والغير لائقة او غير مكتملة المعلومات",
                    "الإعلانات والتعليقات تخص من كتبها ونشرها في نظره ويكون مسؤول عنها المسؤولية الكاملة",
                    "العمليات التجارية والتعاملات المالية تخص الطرفين البائع والمشتري وهم المسؤولين عنها",
                    "يجب من التأكد بين البائع والمشتري ان يكون التعامل وجها لوجه وان لا يتم تحويل أي مبلغ مالي الا بعد التأكد",
                    "يحق لنظره تغيير اتفاقية الاستخدام متى رأت ذلك",
                    "يجب على العضو الحفاظ على حسابه وعضويته وعدم افشاء اي معلومات شخصية",
                    "أي إساءة ستتعرض للمساءلة القانونية امام الجهات المختصة في المملكة العربية السعودية"
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
}
