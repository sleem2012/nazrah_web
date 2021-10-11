import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarih/services/Shareddata.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'package:nazarih/locator.dart';
import 'package:nazarih/model/ad.dart';
import 'package:nazarih/routing/route_names.dart';
import 'package:nazarih/services/firebase_storage.dart';
import 'package:nazarih/widgets/Categories/Categories.dart';
import 'package:nazarih/widgets/centered_view/centered_view.dart';
import 'package:nazarih/widgets/dropdown/ExpandedListAnimationWidget.dart';
import 'package:nazarih/widgets/dropdown/Scrollbar.dart';
import 'package:nazarih/widgets/navigation_bar/navigation_bar.dart';
import 'package:nazarih/extensions/hover_extension.dart';
import 'package:nazarih/widgets/search_widget/SearchWidget.dart';
import 'package:nazarih/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/Categories/Categories.dart';

class HomeViewTabletDesktop extends StatefulWidget {
  @override
  _HomeViewTabletDesktopState createState() => _HomeViewTabletDesktopState();
}

class _HomeViewTabletDesktopState extends State<HomeViewTabletDesktop> {

  String query = '';
  String selectedCategory = 'all';
  String subCategory = 'null';
  String subSubCategory = 'null';
  String country = 'كل المناطق';
  String subCountry = 'الكل';
  String photoBool = 'all';
  String model = 'null';
  String phoneNo;

  ScrollController list1 = ScrollController();
  ScrollController list2 = ScrollController();
  ScrollController list3 = ScrollController();
  ScrollController _slidingPage;

  bool ariaOpened=false;
  bool subAriaOpened=false;

  List<String> _list = [
    'كل المناطق',
    'الرياض',
    "الشرقيه",
    "جده",
    'مكه',
    'ينبع',
    'حفر الباطن',
    'المدينة',
    'الطايف',
    'تبوك',
    'القصيم',
    'حائل',
    'أبها',
    'عسير',
    'الباحة',
    'جيزان',
    'نجران',
    'الجوف',
    'عرعر'
  ];

  List<String> _modellist = [
    'كل الموديلات',
    '2022',
    "2021",
    "2020",
    '2019',
    '2018',
    '2017',
    '2016',
    '2015',
    '2014',
    '2013',
    '2012',
    '2011',
    '2010',
    '2009',
    '2008',
    '2007',
    '2006',
    '2005',
    '2004',
    '2003',
    '2002',
    '2001',
    '2000',
    '1999',
    '1998',
    '1997',
    '1996',
    '1995',
    '1994',
    '1993',
    '1992',
    '1991',
    '1990',
    'اقل من 1990',
  ];

  List<String> _riyadhList = [
    'الكل',
    'الرياض',
    'الخرج',
    'الدرعية',
    'الدلم',
    'الدوادمي',
    'الحريق',
    'الزلفي',
    'السليل',
    'الغاط',
    'القويعية',
    'المجمعة',
    'المزاحمية',
    'الهياثم',
    'ثادق',
    'حوطة بني تميم',
    'رماح',
    'شقراء',
    'عفيف'
  ];

  bool isStrechedDropDownRiyadh = false;
  int groupValueRiyadh = 0;
  String titleRiyadh = 'الكل';

  List<String> _shurqiaList = [
    'الكل',
    'الدمام',
    'الخبر',
    'الظهران',
    'الجبيل',
    'حفر الباطن',
    'الهفوف',
    'تاروت',
    'المبرز',
    'العيون',
    'النعيرية',
    'بقيق',
    'راس تنورة',
    'الخفجي',
    'القطيف',
  ];
  bool isStrechedDropDownShurqia = false;
  int groupValueShurqia = 0;
  String titleShurqia = 'الكل';

  List<String> _mekkahList = [
    'الكل',
    'جده',
    'مكه',
    'الطايف',
    'القنفذة',
    'الكامل',
    'الليث',
    'تربة مكة',
    'ثول',
    'الجموم',
    'رابغ',
    'رنية',
    'مدينة الملك عبدالله الاقتصادية',
    'الخرمة',
  ];
  bool isStrechedDropDownMekkah = false;
  int groupValueMekkah = 0;
  String titleMekkah = 'الكل';

  List<String> _meddinahList = [
    'الكل',
    'العلا',
    'الحناكية',
    'بدر',
    'خيبر',
    'مهد الذهب',
    'ينبع',
  ];
  bool isStrechedDropDownMeddinah = false;
  int groupValueMeddinah = 0;
  String titleMeddinah = 'الكل';

  List<String> _tabukList = [
    'الكل',
    'املج',
    'الوجه',
    'نيماء',
    'ضبا',
  ];
  bool isStrechedDropDownTabuk = false;
  int groupValueTabuk = 0;
  String titleTabuk = 'الكل';

  List<String> _qassimList = [
    'الكل',
    'بريدة',
    'عنيزة',
    'الرس',
    'الشماسية',
    'المذنب',
    'النبهانية',
    'البدائع',
    'رياض الخبراء',
    'البكيرية',
  ];
  bool isStrechedDropDownQassim = false;
  int groupValueQassim = 0;
  String titleQassim = 'الكل';

  List<String> _hailList = [
    'الكل',
    'حائل',
    'الغزالة',
    'بقعاء',
    'الشنان',
    'تربة حائل',
  ];
  bool isStrechedDropDownHail = false;
  int groupValueHail = 0;
  String titleHail = 'الكل';

  List<String> _aseerList = [
    'الكل',
    'أبها',
    'خميس مشيط',
    'المجاردة',
    'بللسمر',
    'بيشة',
    'تثليث',
    'احد رفيده',
    'محايل عسير',
  ];
  bool isStrechedDropDownAseer = false;
  int groupValueAseer = 0;
  String titleAseer = 'الكل';

  List<String> _najranList = [
    'الكل',
    'شرورة',
    'الوديعة',
  ];
  bool isStrechedDropDownNajran = false;
  int groupValueNajran = 0;
  String titleNajran = 'الكل';

  List<String> _jowfList = [
    'الكل',
    'القريات',
    'دومة الجندل',
    'سكاكا',
  ];
  bool isStrechedDropDownJowf = false;
  int groupValueJowf = 0;
  String titleJowf = 'الكل';

  List<String> _ararList = [
    'الكل',
    'رفحاء',
    'طريف',
    'عرعر',
  ];
  bool isStrechedDropDownArar = false;
  int groupValueArar = 0;
  String titleArar = 'الكل';

  bool isStrechedDropDownModel = false;
  int groupValueModel = 0;
  String titleModel = 'كل الموديلات';
  bool isStrechedDropDown = false;
  int groupValue = 0;
  String title = 'كل المناطق';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> loadAds() {
    return _firestore
        .collection('ads')
        .orderBy('date', descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot> loadBanners() {
    return _firestore.collection('info').doc('banners').snapshots();
  }

  Stream<DocumentSnapshot> loadAppInfo() {
    return _firestore.collection('info').doc('app').snapshots();
  }

  @override
  void initState() {
    getData();

    super.initState();
    _slidingPage = ScrollController();
    Timer(
        Duration(seconds: 5),
            () =>
            _slidingPage.animateTo(_slidingPage.offset + 0.1,
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn));
  }

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;

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
            CenteredView(child: NavigationBar(currentRoute: 'Home')),
            Container(
              height: 10,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Color(0xFF2980b9),
            ),
            SizedBox(
              height: 50,
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: loadBanners(),
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  String banner1 = snapshot.data.data()['ads 1'];
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
            Container(
              //height: 500,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                if (phoneNo == null) {
                                  locator<NavigationService>()
                                      .navigateTo(LoginRoute);
                                } else {
                                  locator<NavigationService>()
                                      .navigateTo(AddAdRoute);
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFFe74c3c),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "أضف اعلانك",
                                      style: TextStyle(
                                          fontFamily: 'Bahij',
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.add, color: Colors.white),
                                  ],
                                ),
                              )).mouseUpOnHover,
                          Container(
                            width:width*0.4 ,
                            child: SearchWidget(
                                text: query,
                                hintText: 'أبحث عن سلعة..',
                                onChanged: (value) {
                                  setState(() {
                                    query = value;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 100,
                      child: Stack(
                        children: [
                          ListView(
                            controller: list1,
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textPhotoCategories(
                                  "نظره سيارات", 'assets/images/icons/car.png',
                                      () {
                                    if (selectedCategory != 'cars') {
                                      setState(() {
                                        selectedCategory = 'cars';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'cars')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره العقارات",
                                  'assets/images/icons/house.png', () {
                                    if (selectedCategory != 'property') {
                                      setState(() {
                                        selectedCategory = 'property';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'property')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره الاجهزه",
                                  'assets/images/icons/device.png', () {
                                    if (selectedCategory != 'devices') {
                                      setState(() {
                                        selectedCategory = 'devices';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'devices')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره خدمات الايجار",
                                  'assets/images/icons/rent.png', () {
                                    if (selectedCategory != 'rent') {
                                      setState(() {
                                        selectedCategory = 'rent';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'rent')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره الازياء والموضة",
                                  'assets/images/icons/shopping-basket.png',
                                      () {
                                    if (selectedCategory != 'clothes') {
                                      setState(() {
                                        selectedCategory = 'clothes';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'clothes')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره الصحة والجمال",
                                  'assets/images/icons/heartbeat.png', () {
                                    if (selectedCategory != 'health') {
                                      setState(() {
                                        selectedCategory = 'health';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'health')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره الأسر المنتجة",
                                  'assets/images/icons/paper-crafts.png', () {
                                    if (selectedCategory != 'handmade') {
                                      setState(() {
                                        selectedCategory = 'handmade';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'handmade')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره العسل والتمر والزيوت",
                                  'assets/images/icons/honey.png', () {
                                    if (selectedCategory != 'honey') {
                                      setState(() {
                                        selectedCategory = 'honey';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'honey')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره اثاث وديكور",
                                  'assets/images/icons/decor.png', () {
                                    if (selectedCategory != 'decor') {
                                      setState(() {
                                        selectedCategory = 'decor';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'decor')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره مواشي وحيوانات وطيور",
                                  'assets/images/icons/pawprint.png', () {
                                    if (selectedCategory != 'animals') {
                                      setState(() {
                                        selectedCategory = 'animals';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'animals')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره ورش وصيانة",
                                  'assets/images/icons/garage.png', () {
                                    if (selectedCategory != 'maintenance') {
                                      setState(() {
                                        selectedCategory = 'maintenance';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'maintenance')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره قطع سيارات وملاحقتها",
                                  'assets/images/icons/car-engine.png', () {
                                    if (selectedCategory != 'car_parts') {
                                      setState(() {
                                        selectedCategory = 'car_parts';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'car_parts')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره المطاعم والكافيهات",
                                  'assets/images/icons/cafe.png', () {
                                    if (selectedCategory != 'cafe') {
                                      setState(() {
                                        selectedCategory = 'cafe';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'cafe')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories(
                                  "نظره المواد الغذائية والمشروبات",
                                  'assets/images/icons/diet.png', () {
                                if (selectedCategory != 'food') {
                                  setState(() {
                                    selectedCategory = 'food';
                                    subCategory = 'null';
                                    subSubCategory = 'null';
                                    model = 'null';
                                  });
                                } else {
                                  setState(() {
                                    selectedCategory = 'all';
                                    subCategory = 'null';
                                    subSubCategory = 'null';
                                    model = 'null';
                                  });
                                }
                              },
                                  (selectedCategory == 'food')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره الخدمات الرقمية",
                                  'assets/images/icons/telecommunication.png',
                                      () {
                                    if (selectedCategory != 'digital') {
                                      setState(() {
                                        selectedCategory = 'digital';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'digital')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره السياحة والفنادق",
                                  'assets/images/icons/hotel.png', () {
                                    if (selectedCategory != 'hotels') {
                                      setState(() {
                                        selectedCategory = 'hotels';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'hotels')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره المقاولات",
                                  'assets/images/icons/construction.png', () {
                                    if (selectedCategory != 'construction') {
                                      setState(() {
                                        selectedCategory = 'construction';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'construction')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره الاستقدام",
                                  'assets/images/icons/headhunting.png', () {
                                    if (selectedCategory != 'work') {
                                      setState(() {
                                        selectedCategory = 'work';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCategory = 'all';
                                        subCategory = 'null';
                                        subSubCategory = 'null';
                                        model = 'null';
                                      });
                                    }
                                  },
                                  (selectedCategory == 'work')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories("نظره خدمات أخري",
                                  'assets/images/icons/magnifying-glass.png',
                                      () {
                                    setState(() {
                                      selectedCategory = 'all';
                                      subCategory = 'null';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (selectedCategory == 'all')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                              ),
                              child: TextButton(
                                onLongPress: () {
                                  list1.animateTo(
                                      list1.position.maxScrollExtent,
                                      duration: Duration(milliseconds: 10000),
                                      curve: Curves.ease);
                                },
                                onPressed: () {
                                  list1.animateTo(list1.offset + 100,
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.ease);
                                },
                                style: TextButton.styleFrom(
                                    shape: CircleBorder(),
                                    primary: Colors.black,
                                    padding: EdgeInsets.all(10),
                                    backgroundColor: Colors.transparent),
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 35,
                                  color: Color(0xFFe74c3c),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                              ),
                              child: TextButton(
                                onLongPress: () {
                                  list1.animateTo(
                                      list1.position.minScrollExtent,
                                      duration: Duration(milliseconds: 10000),
                                      curve: Curves.ease);
                                },
                                onPressed: () {
                                  list1.animateTo(list1.offset - 100,
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.ease);
                                },
                                style: TextButton.styleFrom(
                                    shape: CircleBorder(),
                                    primary: Colors.black,
                                    padding: EdgeInsets.all(10),
                                    backgroundColor: Colors.transparent),
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 35,
                                  color: Color(0xFFe74c3c),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    (selectedCategory == 'cars')
                        ? Container(
                      height: 100,
                      child: Stack(
                        children: [
                          ListView(
                            controller: list2,
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              photoCategories(
                                  'assets/images/car_brands/toyota-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'toyota';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'toyota')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/chevrolet-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'chevrolet';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'chevrolet')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/nissan-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'nissan';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'nissan')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/honda-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'honda';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'honda')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/hyundai-icon.png',
                                      () {
                                    setState(() {
                                      subCategory = 'hyundai';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'hyundai')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/kia-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'kia';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'kia')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/bmw-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'bmw';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'bmw')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/mercedes-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'mercedes';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'mercedes')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/gmc-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'gmc';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'gmc')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/astonmartin-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'astonmartin';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'astonmartin')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/audi-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'audi';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'audi')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/buick-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'buick';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'buick')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/cadillac-logo-alt.png',
                                      () {
                                    setState(() {
                                      subCategory = 'cadillac';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'cadillac')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/changan-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'changan';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'changan')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/cherry-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'cherry';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'cherry')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/chrysler-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'chrysler';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'chrysler')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/citroen-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'citroen';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'citroen')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/daewoo-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'daewoo';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'daewoo')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/daihatsu-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'daihatsu';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'daihatsu')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/dodge-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'dodge';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'dodge')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/faw-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'faw';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'faw')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/ferrari-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'ferrari';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'ferrari')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/fiat-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'fiat';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'fiat')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/ford-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'ford';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'ford')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/GAC-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'GAC';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'GAC')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/geely-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'geely';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'geely')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/greatwall-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'greatwall';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'greatwall')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/haval-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'haval';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'haval')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/hummer-icon.png',
                                      () {
                                    setState(() {
                                      subCategory = 'hummer';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'hummer')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/infinity-icon.png',
                                      () {
                                    setState(() {
                                      subCategory = 'infinity';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'infinity')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/ISUZU-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'ISUZU';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'ISUZU')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/jaguar-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'jaguar';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'jaguar')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/jeep-icon.png',
                                      () {
                                    setState(() {
                                      subCategory = 'jeep';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'jeep')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/lamborghini-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'lamborghini';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'lamborghini')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/land-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'land';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'land')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/lexus-icon.png',
                                      () {
                                    setState(() {
                                      subCategory = 'lexus';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'lexus')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/mazda-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'mazda';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'mazda')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/mercury-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'mercury';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'mercury')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/meserati-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'meserati';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'meserati')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/MG-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'MG';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'MG')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/mitsubishi-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'mitsubishi';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'mitsubishi')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/opal-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'opal';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'opal')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/peugeot-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'peugeot';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'peugeot')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/porsche-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'porsche';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'porsche')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/proton-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'proton';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'proton')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/renault-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'renault';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'renault')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/rollsroyce-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'rollsroyce';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'rollsroyce')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/saab-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'saab';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'saab')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/seat-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'seat';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'seat')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/skoda-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'skoda';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'skoda')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/ssanyong-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'ssanyong';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'ssanyong')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/subaru-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'subaru';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'subaru')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/suzuki-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'suzuki';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'suzuki')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/volkswagen-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'volkswagen';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'volkswagen')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/volvo-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'volvo';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'volvo')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/car_brands/ZXauto-logo.png',
                                      () {
                                    setState(() {
                                      subCategory = 'ZXauto';
                                      subSubCategory = 'null';
                                      model = 'null';
                                    });
                                  },
                                  (subCategory == 'ZXauto')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color:
                                      Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                              ),
                              child: TextButton(
                                onLongPress: () {
                                  list2.animateTo(
                                      list2.position.maxScrollExtent,
                                      duration:
                                      Duration(milliseconds: 50000),
                                      curve: Curves.ease);
                                },
                                onPressed: () {
                                  list2.animateTo(list2.offset + 100,
                                      duration:
                                      Duration(milliseconds: 1000),
                                      curve: Curves.ease);
                                },
                                style: TextButton.styleFrom(
                                    shape: CircleBorder(),
                                    primary: Colors.black,
                                    padding: EdgeInsets.all(10),
                                    backgroundColor: Colors.transparent),
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 35,
                                  color: Color(0xFFe74c3c),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color:
                                      Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                              ),
                              child: TextButton(
                                onLongPress: () {
                                  list2.animateTo(
                                      list2.position.minScrollExtent,
                                      duration:
                                      Duration(milliseconds: 50000),
                                      curve: Curves.ease);
                                },
                                onPressed: () {
                                  list2.animateTo(list2.offset - 100,
                                      duration:
                                      Duration(milliseconds: 1000),
                                      curve: Curves.ease);
                                },
                                style: TextButton.styleFrom(
                                    shape: CircleBorder(),
                                    primary: Colors.black,
                                    padding: EdgeInsets.all(10),
                                    backgroundColor: Colors.transparent),
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 35,
                                  color: Color(0xFFe74c3c),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : (selectedCategory == 'car_parts')
                        ? Container(
                      height: 100,
                      child: ListView(
                        controller: list2,
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        children: [
                          textPhotoCategories('قطع غيار',
                              'assets/images/icons/brake.png', () {
                                setState(() {
                                  subCategory = 'spare_parts';
                                });
                              },
                              (subCategory == 'spare_parts')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'جنوط', 'assets/images/icons/wheel.png',
                                  () {
                                setState(() {
                                  subCategory = 'rims';
                                });
                              },
                              (subCategory == 'rims')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories('لوحة مميزه',
                              'assets/images/icons/license-plate.png',
                                  () {
                                setState(() {
                                  subCategory = 'license_plate';
                                });
                              },
                              (subCategory == 'license_plate')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories('خدمات فحص السيارات',
                              'assets/images/icons/inspection.png',
                                  () {
                                setState(() {
                                  subCategory = 'inspection';
                                });
                              },
                              (subCategory == 'inspection')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories('شاشه',
                              'assets/images/icons/screen.png', () {
                                setState(() {
                                  subCategory = 'screen';
                                });
                              },
                              (subCategory == 'screen')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories('مسجل',
                              'assets/images/icons/car-radio.png',
                                  () {
                                setState(() {
                                  subCategory = 'car_radio';
                                });
                              },
                              (subCategory == 'car_radio')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    )
                        : (selectedCategory == 'property')
                        ? Container(
                      height: 100,
                      child: ListView(
                        controller: list2,
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        children: [
                          textPhotoCategories('اراضي للبيع',
                              'assets/images/icons/land.png', () {
                                setState(() {
                                  subCategory = 'land';
                                });
                              },
                              (subCategory == 'land')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories('فلل للبيع',
                              'assets/images/icons/villa.png',
                                  () {
                                setState(() {
                                  subCategory = 'villa';
                                });
                              },
                              (subCategory == 'villa')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories('شقق للبيع',
                              'assets/images/icons/building.png',
                                  () {
                                setState(() {
                                  subCategory = 'flat';
                                });
                              },
                              (subCategory == 'flat')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'اراضي تجارية للبيع',
                              'assets/images/icons/architect.png',
                                  () {
                                setState(() {
                                  subCategory = 'commerical_lands';
                                });
                              },
                              (subCategory == 'commerical_lands')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories('عماره للبيع',
                              'assets/images/icons/building (1).png',
                                  () {
                                setState(() {
                                  subCategory = 'building';
                                });
                              },
                              (subCategory == 'building')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories('محلات للتقبيل',
                              'assets/images/icons/shop.png', () {
                                setState(() {
                                  subCategory = 'shop';
                                });
                              },
                              (subCategory == 'shop')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories('استراحات للبيع',
                              'assets/images/icons/land (1).png',
                                  () {
                                setState(() {
                                  subCategory = 'free_land';
                                });
                              },
                              (subCategory == 'free_land')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories('مزارع للبيع',
                              'assets/images/icons/farm.png', () {
                                setState(() {
                                  subCategory = 'farms';
                                });
                              },
                              (subCategory == 'farms')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    )
                        : (selectedCategory == 'animals')
                        ? Container(
                      height: 100,
                      child: Stack(
                        children: [
                          ListView(
                            controller: list2,
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textPhotoCategories('غنم',
                                  'assets/images/icons/sheep.png',
                                      () {
                                    setState(() {
                                      subCategory = 'sheep';
                                    });
                                  },
                                  (subCategory == 'sheep')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('ببغاء',
                                  'assets/images/icons/parrot.png',
                                      () {
                                    setState(() {
                                      subCategory = 'parrot';
                                    });
                                  },
                                  (subCategory == 'parrot')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('حمام',
                                  'assets/images/icons/pigeon.png',
                                      () {
                                    setState(() {
                                      subCategory = 'pigeon';
                                    });
                                  },
                                  (subCategory == 'pigeon')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('قطط',
                                  'assets/images/icons/cat.png',
                                      () {
                                    setState(() {
                                      subCategory = 'cat';
                                    });
                                  },
                                  (subCategory == 'cat')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('دجاج',
                                  'assets/images/icons/hen.png',
                                      () {
                                    setState(() {
                                      subCategory = 'hen';
                                    });
                                  },
                                  (subCategory == 'hen')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('ماعز',
                                  'assets/images/icons/goat.png',
                                      () {
                                    setState(() {
                                      subCategory = 'goat';
                                    });
                                  },
                                  (subCategory == 'goat')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('أبل',
                                  'assets/images/icons/camel.png',
                                      () {
                                    setState(() {
                                      subCategory = 'camel';
                                    });
                                  },
                                  (subCategory == 'camel')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('خيل',
                                  'assets/images/icons/horse.png',
                                      () {
                                    setState(() {
                                      subCategory = 'horse';
                                    });
                                  },
                                  (subCategory == 'horse')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('كلاب',
                                  'assets/images/icons/dog.png',
                                      () {
                                    setState(() {
                                      subCategory = 'dog';
                                    });
                                  },
                                  (subCategory == 'dog')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('بقر',
                                  'assets/images/icons/cow.png',
                                      () {
                                    setState(() {
                                      subCategory = 'cow';
                                    });
                                  },
                                  (subCategory == 'cow')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('أسماك',
                                  'assets/images/icons/fish.png',
                                      () {
                                    setState(() {
                                      subCategory = 'fish';
                                    });
                                  },
                                  (subCategory == 'fish')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('سلاحف',
                                  'assets/images/icons/tortoise.png',
                                      () {
                                    setState(() {
                                      subCategory = 'tortoise';
                                    });
                                  },
                                  (subCategory == 'tortoise')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('ارانب',
                                  'assets/images/icons/rabbit.png',
                                      () {
                                    setState(() {
                                      subCategory = 'rabbit';
                                    });
                                  },
                                  (subCategory == 'rabbit')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('بط',
                                  'assets/images/icons/duck.png',
                                      () {
                                    setState(() {
                                      subCategory = 'duck';
                                    });
                                  },
                                  (subCategory == 'duck')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('سناجب',
                                  'assets/images/icons/chipmunk.png',
                                      () {
                                    setState(() {
                                      subCategory = 'chipmunk';
                                    });
                                  },
                                  (subCategory == 'chipmunk')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('هامستر',
                                  'assets/images/icons/hamster.png',
                                      () {
                                    setState(() {
                                      subCategory = 'hamster';
                                    });
                                  },
                                  (subCategory == 'hamster')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textPhotoCategories('وبر',
                                  'assets/images/icons/fur.png',
                                      () {
                                    setState(() {
                                      subCategory = 'fur';
                                    });
                                  },
                                  (subCategory == 'fur')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black
                                          .withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                              ),
                              child: TextButton(
                                onLongPress: () {
                                  list2.animateTo(
                                      list2.position
                                          .maxScrollExtent,
                                      duration: Duration(
                                          milliseconds:
                                          10000),
                                      curve: Curves.ease);
                                },
                                onPressed: () {
                                  list2.animateTo(
                                      list2.offset + 100,
                                      duration: Duration(
                                          milliseconds: 1000),
                                      curve: Curves.ease);
                                },
                                style: TextButton.styleFrom(
                                    shape: CircleBorder(),
                                    primary: Colors.black,
                                    padding:
                                    EdgeInsets.all(10),
                                    backgroundColor:
                                    Colors.transparent),
                                child: Icon(
                                  Icons
                                      .arrow_back_ios_rounded,
                                  size: 35,
                                  color: Color(0xFFe74c3c),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black
                                          .withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                              ),
                              child: TextButton(
                                onLongPress: () {
                                  list2.animateTo(
                                      list2.position
                                          .minScrollExtent,
                                      duration: Duration(
                                          milliseconds:
                                          10000),
                                      curve: Curves.ease);
                                },
                                onPressed: () {
                                  list2.animateTo(
                                      list2.offset - 100,
                                      duration: Duration(
                                          milliseconds: 1000),
                                      curve: Curves.ease);
                                },
                                style: TextButton.styleFrom(
                                    shape: CircleBorder(),
                                    primary: Colors.black,
                                    padding:
                                    EdgeInsets.all(10),
                                    backgroundColor:
                                    Colors.transparent),
                                child: Icon(
                                  Icons
                                      .arrow_forward_ios_rounded,
                                  size: 35,
                                  color: Color(0xFFe74c3c),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : (selectedCategory == 'decor')
                        ? Container(
                      height: 100,
                      child: ListView(
                        controller: list2,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          textPhotoCategories(
                              'أثاث خارجي',
                              'assets/images/icons/terrace.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'outdoor_decor';
                                });
                              },
                              (subCategory ==
                                  'outdoor_decor')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'أثاث مكتبي',
                              'assets/images/icons/workspace.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'office_decor';
                                });
                              },
                              (subCategory ==
                                  'office_decor')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'أدوات منزلية',
                              'assets/images/icons/floor-polisher.png',
                                  () {
                                setState(() {
                                  subCategory = 'home_tools';
                                });
                              },
                              (subCategory ==
                                  'home_tools')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'أسرة ومراتب',
                              'assets/images/icons/bed.png',
                                  () {
                                setState(() {
                                  subCategory = 'beds';
                                });
                              },
                              (subCategory == 'beds')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'تحف وديكور',
                              'assets/images/icons/antique.png',
                                  () {
                                setState(() {
                                  subCategory = 'antique';
                                });
                              },
                              (subCategory == 'antique')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'خزائن ودواليب',
                              'assets/images/icons/cupboard.png',
                                  () {
                                setState(() {
                                  subCategory = 'cupboard';
                                });
                              },
                              (subCategory == 'cupboard')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'طاولات وكراسي',
                              'assets/images/icons/chair.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'chairs_tables';
                                });
                              },
                              (subCategory ==
                                  'chairs_tables')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'مجالس ومفروشات',
                              'assets/images/icons/couch.png',
                                  () {
                                setState(() {
                                  subCategory = 'couch';
                                });
                              },
                              (subCategory == 'couch')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'سجاد وموكيت',
                              'assets/images/icons/mat.png',
                                  () {
                                setState(() {
                                  subCategory = 'carpets';
                                });
                              },
                              (subCategory == 'carpets')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    )
                        : (selectedCategory == 'clothes')
                        ? Container(
                      height: 100,
                      child: ListView(
                        controller: list2,
                        reverse: true,
                        scrollDirection:
                        Axis.horizontal,
                        children: [
                          textPhotoCategories('ساعات',
                              'assets/images/icons/wristwatch.png',
                                  () {
                                setState(() {
                                  subCategory = 'watches';
                                });
                              },
                              (subCategory ==
                                  'watches')
                                  ? Color(0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'عطورات',
                              'assets/images/icons/fragrance.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'fragrance';
                                });
                              },
                              (subCategory ==
                                  'fragrance')
                                  ? Color(0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'مستلزمات شخصية',
                              'assets/images/icons/medical.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'personal_tools';
                                });
                              },
                              (subCategory ==
                                  'personal_tools')
                                  ? Color(0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'نظارات',
                              'assets/images/icons/eye-glasses.png',
                                  () {
                                setState(() {
                                  subCategory = 'glasses';
                                });
                              },
                              (subCategory ==
                                  'glasses')
                                  ? Color(0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'ملابس رجالية',
                              'assets/images/icons/male-clothes.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'male_clothes';
                                });
                              },
                              (subCategory ==
                                  'male_clothes')
                                  ? Color(0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'ملابس نسائية',
                              'assets/images/icons/woman-clothes.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'woman_clothes';
                                });
                              },
                              (subCategory ==
                                  'woman_clothes')
                                  ? Color(0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'ملابس أطفال',
                              'assets/images/icons/baby-clothing.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'kids_clothes';
                                });
                              },
                              (subCategory ==
                                  'kids_clothes')
                                  ? Color(0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    )
                        : (selectedCategory == 'honey')
                        ? Container(
                      height: 100,
                      child: ListView(
                        controller: list2,
                        scrollDirection:
                        Axis.horizontal,
                        reverse: true,
                        children: [
                          textPhotoCategories(
                              'عسل',
                              'assets/images/icons/honey2.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'honey';
                                });
                              },
                              (subCategory ==
                                  'honey')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'زيت الزيتون',
                              'assets/images/icons/olive-oil.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'olive_oil';
                                });
                              },
                              (subCategory ==
                                  'olive_oil')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'زيت السمسم',
                              'assets/images/icons/oil.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'sesame_oil';
                                });
                              },
                              (subCategory ==
                                  'sesame_oil')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'سمن',
                              'assets/images/icons/sooji-halwa.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'ghee';
                                });
                              },
                              (subCategory ==
                                  'ghee')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'تمر',
                              'assets/images/icons/dates.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'dates';
                                });
                              },
                              (subCategory ==
                                  'dates')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    )
                        : (selectedCategory ==
                        'digital')
                        ? Container(
                      height: 100,
                      child: ListView(
                        controller: list2,
                        scrollDirection:
                        Axis.horizontal,
                        reverse: true,
                        children: [
                          textPhotoCategories(
                              'التصاميم والجرافيك',
                              'assets/images/icons/illustration.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'graphic';
                                });
                              },
                              (subCategory ==
                                  'graphic')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'التسويق الرقمي',
                              'assets/images/icons/social-media.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'digital_marketing';
                                });
                              },
                              (subCategory ==
                                  'digital_marketing')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'الكتابة والترجمة',
                              'assets/images/icons/notes.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'writing';
                                });
                              },
                              (subCategory ==
                                  'writing')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'الفيديو والرسوم المتحركة',
                              'assets/images/icons/animation.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'animation';
                                });
                              },
                              (subCategory ==
                                  'animation')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'البرمجة والتقنية',
                              'assets/images/icons/programming.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'programming';
                                });
                              },
                              (subCategory ==
                                  'programming')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'البيانات',
                              'assets/images/icons/statistics.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'data';
                                });
                              },
                              (subCategory ==
                                  'data')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'اعمال تجارية',
                              'assets/images/icons/analytics.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'business';
                                });
                              },
                              (subCategory ==
                                  'business')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'نمط الحياه',
                              'assets/images/icons/healthy.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'lifestyle';
                                });
                              },
                              (subCategory ==
                                  'lifestyle')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    )
                        : (selectedCategory ==
                        'rent')
                        ? Container(
                      height: 100,
                      child: ListView(
                        controller: list2,
                        scrollDirection:
                        Axis.horizontal,
                        reverse: true,
                        children: [
                          textPhotoCategories(
                              'شقق للايجار',
                              'assets/images/icons/real-estate (1).png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'flat';
                                });
                              },
                              (subCategory ==
                                  'flat')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'استراحات للايجار',
                              'assets/images/icons/tuscany.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'free_land';
                                });
                              },
                              (subCategory ==
                                  'free_land')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'محلات للايجار',
                              'assets/images/icons/rent 2.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'shops';
                                });
                              },
                              (subCategory ==
                                  'shops')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'عماره للايجار',
                              'assets/images/icons/apartment 2.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'building';
                                });
                              },
                              (subCategory ==
                                  'building')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'فلل للايجار',
                              'assets/images/icons/house (2).png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'villa';
                                });
                              },
                              (subCategory ==
                                  'villa')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'ادوار للايجار',
                              'assets/images/icons/apartment 3.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'apartment';
                                });
                              },
                              (subCategory ==
                                  'apartment')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'بيوت للايجار',
                              'assets/images/icons/sale.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'houses';
                                });
                              },
                              (subCategory ==
                                  'houses')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'قاعات وقصور الأفراح للايجار',
                              'assets/images/icons/palace.png',
                                  () {
                                setState(() {
                                  subCategory =
                                  'wedding';
                                });
                              },
                              (subCategory ==
                                  'wedding')
                                  ? Color(
                                  0xFF2980b9)
                                  : Colors
                                  .transparent),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    )
                        : (selectedCategory ==
                        'cafe')
                        ? Container(
                      height: 100,
                      child: ListView(
                        controller:
                        list2,
                        scrollDirection:
                        Axis.horizontal,
                        reverse: true,
                        children: [
                          textPhotoCategories(
                              'مطاعم',
                              'assets/images/icons/restaurant.png',
                                  () {
                                setState(
                                        () {
                                      subCategory =
                                      'resturants';
                                    });
                              },
                              (subCategory ==
                                  'resturants')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                          textPhotoCategories(
                              'كافيهات',
                              'assets/images/icons/cafe (1).png',
                                  () {
                                setState(
                                        () {
                                      subCategory =
                                      'cafe';
                                    });
                              },
                              (subCategory ==
                                  'cafe')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    )
                        : (selectedCategory ==
                        'food')
                        ? Container(
                      height: 100,
                      child:
                      ListView(
                        controller:
                        list2,
                        scrollDirection:
                        Axis.horizontal,
                        reverse:
                        true,
                        children: [
                          textPhotoCategories(
                              'مواد غذائية',
                              'assets/images/icons/fruits.png',
                                  () {
                                setState(
                                        () {
                                      subCategory =
                                      'food';
                                    });
                              },
                              (subCategory == 'food')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width:
                            15,
                          ),
                          textPhotoCategories(
                              'مشروبات',
                              'assets/images/icons/soft-drink.png',
                                  () {
                                setState(
                                        () {
                                      subCategory =
                                      'drink';
                                    });
                              },
                              (subCategory == 'drink')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                          SizedBox(
                            width:
                            15,
                          ),
                        ],
                      ),
                    )
                        : (selectedCategory ==
                        'devices')
                        ? Container(
                      height:
                      100,
                      child:
                      Stack(
                        children: [
                          ListView(
                            controller: list2,
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              photoCategories(
                                  'assets/images/devices_brands/Apple.png', () {
                                setState(() {
                                  subCategory = 'apple';
                                });
                              }, (subCategory == 'apple')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/samsung.png', () {
                                setState(() {
                                  subCategory = 'samsung';
                                });
                              }, (subCategory == 'samsung')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/huawei.png', () {
                                setState(() {
                                  subCategory = 'huawei';
                                });
                              }, (subCategory == 'huawei')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/xiaomi.png', () {
                                setState(() {
                                  subCategory = 'xiaomi';
                                });
                              }, (subCategory == 'xiaomi')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/lg.png', () {
                                setState(() {
                                  subCategory = 'lg';
                                });
                              }, (subCategory == 'lg')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/sony.png', () {
                                setState(() {
                                  subCategory = 'sony';
                                });
                              }, (subCategory == 'sony')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/Microsoft.png', () {
                                setState(() {
                                  subCategory = 'microsoft';
                                });
                              }, (subCategory == 'microsoft') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/blackberry.png', () {
                                setState(() {
                                  subCategory = 'blackberry';
                                });
                              }, (subCategory == 'blackberry') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/nokia.png', () {
                                setState(() {
                                  subCategory = 'nokia';
                                });
                              }, (subCategory == 'nokia')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/Acer.png', () {
                                setState(() {
                                  subCategory = 'acer';
                                });
                              }, (subCategory == 'acer')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/asus.png', () {
                                setState(() {
                                  subCategory = 'asus';
                                });
                              }, (subCategory == 'asus')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/canon.png', () {
                                setState(() {
                                  subCategory = 'canon';
                                });
                              }, (subCategory == 'canon')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/Dell.png', () {
                                setState(() {
                                  subCategory = 'dell';
                                });
                              }, (subCategory == 'dell')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/fujifilm.png', () {
                                setState(() {
                                  subCategory = 'fujifilm';
                                });
                              }, (subCategory == 'fujifilm')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/Hitachi.png', () {
                                setState(() {
                                  subCategory = 'hitachi';
                                });
                              }, (subCategory == 'hitachi')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/nikon.png', () {
                                setState(() {
                                  subCategory = 'nikon';
                                });
                              }, (subCategory == 'nikon')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/Panasonic.png', () {
                                setState(() {
                                  subCategory = 'panasonic';
                                });
                              }, (subCategory == 'panasonic') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/toshiba.png', () {
                                setState(() {
                                  subCategory = 'toshiba';
                                });
                              }, (subCategory == 'toshiba')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              photoCategories(
                                  'assets/images/devices_brands/Olympus.png', () {
                                setState(() {
                                  subCategory = 'olympus';
                                });
                              }, (subCategory == 'olympus')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                              ),
                              child: TextButton(
                                onLongPress: () {
                                  list2.animateTo(
                                      list2.position.maxScrollExtent,
                                      duration: Duration(milliseconds: 10000),
                                      curve: Curves.ease);
                                },
                                onPressed: () {
                                  list2.animateTo(list2.offset + 100,
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.ease);
                                },
                                style: TextButton.styleFrom(
                                    shape: CircleBorder(),
                                    primary: Colors.black,
                                    padding: EdgeInsets.all(10),
                                    backgroundColor: Colors.transparent),
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 35,
                                  color: Color(0xFFe74c3c),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                              ),
                              child: TextButton(
                                onLongPress: () {
                                  list2.animateTo(
                                      list2.position.minScrollExtent,
                                      duration: Duration(milliseconds: 10000),
                                      curve: Curves.ease);
                                },
                                onPressed: () {
                                  list2.animateTo(list2.offset - 100,
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.ease);
                                },
                                style: TextButton.styleFrom(
                                    shape: CircleBorder(),
                                    primary: Colors.black,
                                    padding: EdgeInsets.all(10),
                                    backgroundColor: Colors.transparent),
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 35,
                                  color: Color(0xFFe74c3c),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : Container(),
                    (subCategory == 'toyota')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        height: 50,
                        child: Stack(
                          children: [
                            ListView(
                              controller: list3,
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              children: [
                                textCategories('لاند كروزر', () {
                                  setState(() {
                                    subSubCategory = 'لاند كروزر';
                                  });
                                },
                                    (subSubCategory == 'لاند كروزر')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('كامري', () {
                                  setState(() {
                                    subSubCategory = 'كامري';
                                  });
                                },
                                    (subSubCategory == 'كامري')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('افالون', () {
                                  setState(() {
                                    subSubCategory = 'افالون';
                                  });
                                },
                                    (subSubCategory == 'افالون')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('هايلوكس', () {
                                  setState(() {
                                    subSubCategory = 'هايلوكس';
                                  });
                                },
                                    (subSubCategory == 'هايلوكس')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('كورولا', () {
                                  setState(() {
                                    subSubCategory = 'كورولا';
                                  });
                                },
                                    (subSubCategory == 'كورولا')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('اف جي', () {
                                  setState(() {
                                    subSubCategory = 'اف جي';
                                  });
                                },
                                    (subSubCategory == 'اف جي')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('ربع', () {
                                  setState(() {
                                    subSubCategory = 'ربع';
                                  });
                                },
                                    (subSubCategory == 'ربع')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('شاص', () {
                                  setState(() {
                                    subSubCategory = 'شاص';
                                  });
                                },
                                    (subSubCategory == 'شاص')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('يارس', () {
                                  setState(() {
                                    subSubCategory = 'يارس';
                                  });
                                },
                                    (subSubCategory == 'يارس')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('برادو', () {
                                  setState(() {
                                    subSubCategory = 'برادو';
                                  });
                                },
                                    (subSubCategory == 'برادو')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('فورتشنر', () {
                                  setState(() {
                                    subSubCategory = 'فورتشنر';
                                  });
                                },
                                    (subSubCategory == 'فورتشنر')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('اوريون', () {
                                  setState(() {
                                    subSubCategory = 'اوريون';
                                  });
                                },
                                    (subSubCategory == 'اوريون')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('كرسيدا', () {
                                  setState(() {
                                    subSubCategory = 'كرسيدا';
                                  });
                                },
                                    (subSubCategory == 'كرسيدا')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('سيكويا', () {
                                  setState(() {
                                    subSubCategory = 'سيكويا';
                                  });
                                },
                                    (subSubCategory == 'سيكويا')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('باص', () {
                                  setState(() {
                                    subSubCategory = 'باص';
                                  });
                                },
                                    (subSubCategory == 'باص')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('انوفا', () {
                                  setState(() {
                                    subSubCategory = 'انوفا';
                                  });
                                },
                                    (subSubCategory == 'انوفا')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('راف فور', () {
                                  setState(() {
                                    subSubCategory = 'راف فور';
                                  });
                                },
                                    (subSubCategory == 'راف فور')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('XA', () {
                                  setState(() {
                                    subSubCategory = 'XA';
                                  });
                                },
                                    (subSubCategory == 'XA')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('ايكو', () {
                                  setState(() {
                                    subSubCategory = 'ايكو';
                                  });
                                },
                                    (subSubCategory == 'ايكو')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('تندرا', () {
                                  setState(() {
                                    subSubCategory = 'تندرا';
                                  });
                                },
                                    (subSubCategory == 'تندرا')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('بريفيا', () {
                                  setState(() {
                                    subSubCategory = 'بريفيا';
                                  });
                                },
                                    (subSubCategory == 'بريفيا')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('سوبرا', () {
                                  setState(() {
                                    subSubCategory = 'سوبرا';
                                  });
                                },
                                    (subSubCategory == 'سوبرا')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('تويوتا 86', () {
                                  setState(() {
                                    subSubCategory = 'تويوتا 86';
                                  });
                                },
                                    (subSubCategory == 'تويوتا 86')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('افانزا', () {
                                  setState(() {
                                    subSubCategory = 'افانزا';
                                  });
                                },
                                    (subSubCategory == 'افانزا')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('هايلاندر', () {
                                  setState(() {
                                    subSubCategory = 'هايلاندر';
                                  });
                                },
                                    (subSubCategory == 'هايلاندر')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('بريوس', () {
                                  setState(() {
                                    subSubCategory = 'بريوس';
                                  });
                                },
                                    (subSubCategory == 'بريوس')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('راش', () {
                                  setState(() {
                                    subSubCategory = 'راش';
                                  });
                                },
                                    (subSubCategory == 'راش')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('جرانفيا', () {
                                  setState(() {
                                    subSubCategory = 'جرانفيا';
                                  });
                                },
                                    (subSubCategory == 'جرانفيا')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('C-HR', () {
                                  setState(() {
                                    subSubCategory = 'C-HR';
                                  });
                                },
                                    (subSubCategory == 'C-HR')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                                textCategories('كورولا كروس', () {
                                  setState(() {
                                    subSubCategory = 'كورولا كروس';
                                  });
                                },
                                    (subSubCategory == 'كورولا كروس')
                                        ? Color(0xFF2980b9)
                                        : Colors.transparent),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color:
                                        Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 10))
                                  ],
                                ),
                                child: TextButton(
                                  onLongPress: () {
                                    list3.animateTo(
                                        list3.position.maxScrollExtent,
                                        duration:
                                        Duration(milliseconds: 50000),
                                        curve: Curves.ease);
                                  },
                                  onPressed: () {
                                    list3.animateTo(list3.offset + 100,
                                        duration:
                                        Duration(milliseconds: 1000),
                                        curve: Curves.ease);
                                  },
                                  style: TextButton.styleFrom(
                                      shape: CircleBorder(),
                                      primary: Colors.black,
                                      padding: EdgeInsets.all(10),
                                      backgroundColor:
                                      Colors.transparent),
                                  child: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: 30,
                                    color: Color(0xFFe74c3c),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color:
                                        Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 10))
                                  ],
                                ),
                                child: TextButton(
                                  onLongPress: () {
                                    list3.animateTo(
                                        list3.position.minScrollExtent,
                                        duration:
                                        Duration(milliseconds: 50000),
                                        curve: Curves.ease);
                                  },
                                  onPressed: () {
                                    list3.animateTo(list3.offset - 100,
                                        duration:
                                        Duration(milliseconds: 1000),
                                        curve: Curves.ease);
                                  },
                                  style: TextButton.styleFrom(
                                      shape: CircleBorder(),
                                      primary: Colors.black,
                                      padding: EdgeInsets.all(10),
                                      backgroundColor:
                                      Colors.transparent),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 30,
                                    color: Color(0xFFe74c3c),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        : (subCategory == 'chevrolet')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: Stack(
                            children: [
                              ListView(
                                controller: list3,
                                scrollDirection: Axis.horizontal,
                                reverse: true,
                                children: [
                                  textCategories('كابريس', () {
                                    setState(() {
                                      subSubCategory = 'كابريس';
                                    });
                                  },
                                      (subSubCategory == 'كابريس')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('تاهو', () {
                                    setState(() {
                                      subSubCategory = 'تاهو';
                                    });
                                  },
                                      (subSubCategory == 'تاهو')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('سوبربان', () {
                                    setState(() {
                                      subSubCategory = 'سوبربان';
                                    });
                                  },
                                      (subSubCategory == 'سوبربان')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('لومينا', () {
                                    setState(() {
                                      subSubCategory = 'لومينا';
                                    });
                                  },
                                      (subSubCategory == 'لومينا')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('سلفرادو', () {
                                    setState(() {
                                      subSubCategory = 'سلفرادو';
                                    });
                                  },
                                      (subSubCategory == 'سلفرادو')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('كمارو', () {
                                    setState(() {
                                      subSubCategory = 'كمارو';
                                    });
                                  },
                                      (subSubCategory == 'كمارو')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('بليزر', () {
                                    setState(() {
                                      subSubCategory = 'بليزر';
                                    });
                                  },
                                      (subSubCategory == 'بليزر')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('ابيكا', () {
                                    setState(() {
                                      subSubCategory = 'ابيكا';
                                    });
                                  },
                                      (subSubCategory == 'ابيكا')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('ماليبو', () {
                                    setState(() {
                                      subSubCategory = 'ماليبو';
                                    });
                                  },
                                      (subSubCategory == 'ماليبو')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('افيو', () {
                                    setState(() {
                                      subSubCategory = 'افيو';
                                    });
                                  },
                                      (subSubCategory == 'افيو')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('كروز', () {
                                    setState(() {
                                      subSubCategory = 'كروز';
                                    });
                                  },
                                      (subSubCategory == 'كروز')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('اوبترا', () {
                                    setState(() {
                                      subSubCategory = 'اوبترا';
                                    });
                                  },
                                      (subSubCategory == 'اوبترا')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('تريل بليزر', () {
                                    setState(() {
                                      subSubCategory = 'تريل بليزر';
                                    });
                                  },
                                      (subSubCategory == 'تريل بليزر')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('افلانش', () {
                                    setState(() {
                                      subSubCategory = 'افلانش';
                                    });
                                  },
                                      (subSubCategory == 'افلانش')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('كورفيت', () {
                                    setState(() {
                                      subSubCategory = 'كورفيت';
                                    });
                                  },
                                      (subSubCategory == 'كورفيت')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('فان', () {
                                    setState(() {
                                      subSubCategory = 'فان';
                                    });
                                  },
                                      (subSubCategory == 'فان')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('امبالا', () {
                                    setState(() {
                                      subSubCategory = 'امبالا';
                                    });
                                  },
                                      (subSubCategory == 'امبالا')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('ترافيرس', () {
                                    setState(() {
                                      subSubCategory = 'ترافيرس';
                                    });
                                  },
                                      (subSubCategory == 'ترافيرس')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('ابلاندر', () {
                                    setState(() {
                                      subSubCategory = 'ابلاندر';
                                    });
                                  },
                                      (subSubCategory == 'ابلاندر')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('اكسبرس فان', () {
                                    setState(() {
                                      subSubCategory = 'اكسبرس فان';
                                    });
                                  },
                                      (subSubCategory == 'اكسبرس فان')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('فنشر', () {
                                    setState(() {
                                      subSubCategory = 'فنشر';
                                    });
                                  },
                                      (subSubCategory == 'فنشر')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('كابتيفا', () {
                                    setState(() {
                                      subSubCategory = 'كابتيفا';
                                    });
                                  },
                                      (subSubCategory == 'كابتيفا')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('استروفان', () {
                                    setState(() {
                                      subSubCategory = 'استروفان';
                                    });
                                  },
                                      (subSubCategory == 'استروفان')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('سونيك', () {
                                    setState(() {
                                      subSubCategory = 'سونيك';
                                    });
                                  },
                                      (subSubCategory == 'سونيك')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('سبارك', () {
                                    setState(() {
                                      subSubCategory = 'سبارك';
                                    });
                                  },
                                      (subSubCategory == 'سبارك')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('كرفان', () {
                                    setState(() {
                                      subSubCategory = 'كرفان';
                                    });
                                  },
                                      (subSubCategory == 'كرفان')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('كافالير', () {
                                    setState(() {
                                      subSubCategory = 'كافالير';
                                    });
                                  },
                                      (subSubCategory == 'كافالير')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('كولورادو', () {
                                    setState(() {
                                      subSubCategory = 'كولورادو';
                                    });
                                  },
                                      (subSubCategory == 'كولورادو')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('جي فان', () {
                                    setState(() {
                                      subSubCategory = 'جي فان';
                                    });
                                  },
                                      (subSubCategory == 'جي فان')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('اكوينوكس', () {
                                    setState(() {
                                      subSubCategory = 'اكوينوكس';
                                    });
                                  },
                                      (subSubCategory == 'اكوينوكس')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('بولت', () {
                                    setState(() {
                                      subSubCategory = 'بولت';
                                    });
                                  },
                                      (subSubCategory == 'بولت')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black
                                              .withOpacity(0.1),
                                          offset: Offset(0, 10))
                                    ],
                                  ),
                                  child: TextButton(
                                    onLongPress: () {
                                      list3.animateTo(
                                          list3.position
                                              .maxScrollExtent,
                                          duration: Duration(
                                              milliseconds: 50000),
                                          curve: Curves.ease);
                                    },
                                    onPressed: () {
                                      list3.animateTo(
                                          list3.offset + 100,
                                          duration: Duration(
                                              milliseconds: 1000),
                                          curve: Curves.ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder(),
                                        primary: Colors.black,
                                        padding: EdgeInsets.all(10),
                                        backgroundColor:
                                        Colors.transparent),
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: 30,
                                      color: Color(0xFFe74c3c),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black
                                              .withOpacity(0.1),
                                          offset: Offset(0, 10))
                                    ],
                                  ),
                                  child: TextButton(
                                    onLongPress: () {
                                      list3.animateTo(
                                          list3.position
                                              .minScrollExtent,
                                          duration: Duration(
                                              milliseconds: 50000),
                                          curve: Curves.ease);
                                    },
                                    onPressed: () {
                                      list3.animateTo(
                                          list3.offset - 100,
                                          duration: Duration(
                                              milliseconds: 1000),
                                          curve: Curves.ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder(),
                                        primary: Colors.black,
                                        padding: EdgeInsets.all(10),
                                        backgroundColor:
                                        Colors.transparent),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 30,
                                      color: Color(0xFFe74c3c),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'nissan')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: Stack(
                            children: [
                              ListView(
                                controller: list3,
                                scrollDirection: Axis.horizontal,
                                reverse: true,
                                children: [
                                  textCategories('باترول', () {
                                    setState(() {
                                      subSubCategory = 'باترول';
                                    });
                                  },
                                      (subSubCategory == 'باترول')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('ددسن', () {
                                    setState(() {
                                      subSubCategory = 'ددسن';
                                    });
                                  },
                                      (subSubCategory == 'ددسن')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('التيما', () {
                                    setState(() {
                                      subSubCategory = 'التيما';
                                    });
                                  },
                                      (subSubCategory == 'التيما')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('مكسيما', () {
                                    setState(() {
                                      subSubCategory = 'مكسيما';
                                    });
                                  },
                                      (subSubCategory == 'مكسيما')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('باثفندر', () {
                                    setState(() {
                                      subSubCategory = 'باثفندر';
                                    });
                                  },
                                      (subSubCategory ==
                                          'باثفندر')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('صني', () {
                                    setState(() {
                                      subSubCategory = 'صني';
                                    });
                                  },
                                      (subSubCategory == 'صني')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('ارمادا', () {
                                    setState(() {
                                      subSubCategory = 'ارمادا';
                                    });
                                  },
                                      (subSubCategory == 'ارمادا')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('اكستيرا', () {
                                    setState(() {
                                      subSubCategory = 'اكستيرا';
                                    });
                                  },
                                      (subSubCategory ==
                                          'اكستيرا')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('فئة Z', () {
                                    setState(() {
                                      subSubCategory = 'فئة Z';
                                    });
                                  },
                                      (subSubCategory == 'فئة Z')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('نيسان شاص', () {
                                    setState(() {
                                      subSubCategory =
                                      'نيسان شاص';
                                    });
                                  },
                                      (subSubCategory ==
                                          'نيسان شاص')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('نافارا', () {
                                    setState(() {
                                      subSubCategory = 'نافارا';
                                    });
                                  },
                                      (subSubCategory == 'نافارا')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('مورانو', () {
                                    setState(() {
                                      subSubCategory = 'مورانو';
                                    });
                                  },
                                      (subSubCategory == 'مورانو')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('تيدا', () {
                                    setState(() {
                                      subSubCategory = 'تيدا';
                                    });
                                  },
                                      (subSubCategory == 'تيدا')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('اورفان', () {
                                    setState(() {
                                      subSubCategory = 'اورفان';
                                    });
                                  },
                                      (subSubCategory == 'اورفان')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('سكاي لاين', () {
                                    setState(() {
                                      subSubCategory =
                                      'سكاي لاين';
                                    });
                                  },
                                      (subSubCategory ==
                                          'سكاي لاين')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('سنترا', () {
                                    setState(() {
                                      subSubCategory = 'سنترا';
                                    });
                                  },
                                      (subSubCategory == 'سنترا')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('اكس تريل', () {
                                    setState(() {
                                      subSubCategory = 'اكس تريل';
                                    });
                                  },
                                      (subSubCategory ==
                                          'اكس تريل')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('جلوريا', () {
                                    setState(() {
                                      subSubCategory = 'جلوريا';
                                    });
                                  },
                                      (subSubCategory == 'جلوريا')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('بريميرا', () {
                                    setState(() {
                                      subSubCategory = 'بريميرا';
                                    });
                                  },
                                      (subSubCategory ==
                                          'بريميرا')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('تيرانو', () {
                                    setState(() {
                                      subSubCategory = 'تيرانو';
                                    });
                                  },
                                      (subSubCategory == 'تيرانو')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('قاشقاي', () {
                                    setState(() {
                                      subSubCategory = 'قاشقاي';
                                    });
                                  },
                                      (subSubCategory == 'قاشقاي')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('جوك', () {
                                    setState(() {
                                      subSubCategory = 'جوك';
                                    });
                                  },
                                      (subSubCategory == 'جوك')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('كيكس', () {
                                    setState(() {
                                      subSubCategory = 'كيكس';
                                    });
                                  },
                                      (subSubCategory == 'كيكس')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('370Z', () {
                                    setState(() {
                                      subSubCategory = '370Z';
                                    });
                                  },
                                      (subSubCategory == '370Z')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('GTR', () {
                                    setState(() {
                                      subSubCategory = 'GTR';
                                    });
                                  },
                                      (subSubCategory == 'GTR')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('سيفيليان', () {
                                    setState(() {
                                      subSubCategory = 'سيفيليان';
                                    });
                                  },
                                      (subSubCategory ==
                                          'سيفيليان')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('باترول سفاري',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'باترول سفاري';
                                        });
                                      },
                                      (subSubCategory ==
                                          'باترول سفاري')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black
                                              .withOpacity(0.1),
                                          offset: Offset(0, 10))
                                    ],
                                  ),
                                  child: TextButton(
                                    onLongPress: () {
                                      list3.animateTo(
                                          list3.position
                                              .maxScrollExtent,
                                          duration: Duration(
                                              milliseconds:
                                              50000),
                                          curve: Curves.ease);
                                    },
                                    onPressed: () {
                                      list3.animateTo(
                                          list3.offset + 100,
                                          duration: Duration(
                                              milliseconds: 1000),
                                          curve: Curves.ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder(),
                                        primary: Colors.black,
                                        padding:
                                        EdgeInsets.all(10),
                                        backgroundColor:
                                        Colors.transparent),
                                    child: Icon(
                                      Icons
                                          .arrow_back_ios_rounded,
                                      size: 30,
                                      color: Color(0xFFe74c3c),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black
                                              .withOpacity(0.1),
                                          offset: Offset(0, 10))
                                    ],
                                  ),
                                  child: TextButton(
                                    onLongPress: () {
                                      list3.animateTo(
                                          list3.position
                                              .minScrollExtent,
                                          duration: Duration(
                                              milliseconds:
                                              50000),
                                          curve: Curves.ease);
                                    },
                                    onPressed: () {
                                      list3.animateTo(
                                          list3.offset - 100,
                                          duration: Duration(
                                              milliseconds: 1000),
                                          curve: Curves.ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder(),
                                        primary: Colors.black,
                                        padding:
                                        EdgeInsets.all(10),
                                        backgroundColor:
                                        Colors.transparent),
                                    child: Icon(
                                      Icons
                                          .arrow_forward_ios_rounded,
                                      size: 30,
                                      color: Color(0xFFe74c3c),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'honda')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('اكورد', () {
                                setState(() {
                                  subSubCategory = 'اكورد';
                                });
                              },
                                  (subSubCategory == 'اكورد')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سيفيك', () {
                                setState(() {
                                  subSubCategory = 'سيفيك';
                                });
                              },
                                  (subSubCategory == 'سيفيك')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('اوديسي', () {
                                setState(() {
                                  subSubCategory = 'اوديسي';
                                });
                              },
                                  (subSubCategory == 'اوديسي')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CRV', () {
                                setState(() {
                                  subSubCategory = 'CRV';
                                });
                              },
                                  (subSubCategory == 'CRV')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بايلوت', () {
                                setState(() {
                                  subSubCategory = 'بايلوت';
                                });
                              },
                                  (subSubCategory == 'بايلوت')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سيتي', () {
                                setState(() {
                                  subSubCategory = 'سيتي';
                                });
                              },
                                  (subSubCategory == 'سيتي')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ليجيند', () {
                                setState(() {
                                  subSubCategory = 'ليجيند';
                                });
                              },
                                  (subSubCategory == 'ليجيند')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بريليود', () {
                                setState(() {
                                  subSubCategory = 'بريليود';
                                });
                              },
                                  (subSubCategory ==
                                      'بريليود')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('انتيجرا', () {
                                setState(() {
                                  subSubCategory = 'انتيجرا';
                                });
                              },
                                  (subSubCategory ==
                                      'انتيجرا')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('HRV', () {
                                setState(() {
                                  subSubCategory = 'HRV';
                                });
                              },
                                  (subSubCategory == 'HRV')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'hyundai')
                        ? Padding(
                      padding:
                      const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: Stack(
                            children: [
                              ListView(
                                controller: list3,
                                scrollDirection:
                                Axis.horizontal,
                                reverse: true,
                                children: [
                                  textCategories('سوناتا',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'سوناتا';
                                        });
                                      },
                                      (subSubCategory ==
                                          'سوناتا')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('النترا',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'النترا';
                                        });
                                      },
                                      (subSubCategory ==
                                          'النترا')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('اكسنت',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'اكسنت';
                                        });
                                      },
                                      (subSubCategory ==
                                          'اكسنت')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('ازيرا',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'ازيرا';
                                        });
                                      },
                                      (subSubCategory ==
                                          'ازيرا')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('جنسس',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'جنسس';
                                        });
                                      },
                                      (subSubCategory ==
                                          'جنسس')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'هونداي H1', () {
                                    setState(() {
                                      subSubCategory =
                                      'هونداي H1';
                                    });
                                  },
                                      (subSubCategory ==
                                          'هونداي H1')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('سنتافي',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'سنتافي';
                                        });
                                      },
                                      (subSubCategory ==
                                          'سنتافي')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('توسان',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'توسان';
                                        });
                                      },
                                      (subSubCategory ==
                                          'توسان')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'فيلوستر', () {
                                    setState(() {
                                      subSubCategory =
                                      'فيلوستر';
                                    });
                                  },
                                      (subSubCategory ==
                                          'فيلوستر')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('تراجيت',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'تراجيت';
                                        });
                                      },
                                      (subSubCategory ==
                                          'تراجيت')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('i40',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'i40';
                                        });
                                      },
                                      (subSubCategory ==
                                          'i40')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'سنتنيال', () {
                                    setState(() {
                                      subSubCategory =
                                      'سنتنيال';
                                    });
                                  },
                                      (subSubCategory ==
                                          'سنتنيال')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('كوبية',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'كوبية';
                                        });
                                      },
                                      (subSubCategory ==
                                          'كوبية')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('i10',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'i10';
                                        });
                                      },
                                      (subSubCategory ==
                                          'i10')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'فيراكروز', () {
                                    setState(() {
                                      subSubCategory =
                                      'فيراكروز';
                                    });
                                  },
                                      (subSubCategory ==
                                          'فيراكروز')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'تيريكان', () {
                                    setState(() {
                                      subSubCategory =
                                      'تيريكان';
                                    });
                                  },
                                      (subSubCategory ==
                                          'تيريكان')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'ماتريكس', () {
                                    setState(() {
                                      subSubCategory =
                                      'ماتريكس';
                                    });
                                  },
                                      (subSubCategory ==
                                          'ماتريكس')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('جالوير',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'جالوير';
                                        });
                                      },
                                      (subSubCategory ==
                                          'جالوير')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('كونا',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'كونا';
                                        });
                                      },
                                      (subSubCategory ==
                                          'كونا')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('كريتا',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'كريتا';
                                        });
                                      },
                                      (subSubCategory ==
                                          'كريتا')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'باليسيد', () {
                                    setState(() {
                                      subSubCategory =
                                      'باليسيد';
                                    });
                                  },
                                      (subSubCategory ==
                                          'باليسيد')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'جراند سنتافي', () {
                                    setState(() {
                                      subSubCategory =
                                      'جراند سنتافي';
                                    });
                                  },
                                      (subSubCategory ==
                                          'جراند سنتافي')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('i30',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'i30';
                                        });
                                      },
                                      (subSubCategory ==
                                          'i30')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                              Align(
                                alignment:
                                Alignment.centerLeft,
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors
                                              .black
                                              .withOpacity(
                                              0.1),
                                          offset: Offset(
                                              0, 10))
                                    ],
                                  ),
                                  child: TextButton(
                                    onLongPress: () {
                                      list3.animateTo(
                                          list3.position
                                              .maxScrollExtent,
                                          duration: Duration(
                                              milliseconds:
                                              50000),
                                          curve: Curves
                                              .ease);
                                    },
                                    onPressed: () {
                                      list3.animateTo(
                                          list3.offset +
                                              100,
                                          duration: Duration(
                                              milliseconds:
                                              1000),
                                          curve: Curves
                                              .ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape:
                                        CircleBorder(),
                                        primary:
                                        Colors.black,
                                        padding:
                                        EdgeInsets
                                            .all(10),
                                        backgroundColor:
                                        Colors
                                            .transparent),
                                    child: Icon(
                                      Icons
                                          .arrow_back_ios_rounded,
                                      size: 30,
                                      color: Color(
                                          0xFFe74c3c),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment:
                                Alignment.centerRight,
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors
                                              .black
                                              .withOpacity(
                                              0.1),
                                          offset: Offset(
                                              0, 10))
                                    ],
                                  ),
                                  child: TextButton(
                                    onLongPress: () {
                                      list3.animateTo(
                                          list3.position
                                              .minScrollExtent,
                                          duration: Duration(
                                              milliseconds:
                                              50000),
                                          curve: Curves
                                              .ease);
                                    },
                                    onPressed: () {
                                      list3.animateTo(
                                          list3.offset -
                                              100,
                                          duration: Duration(
                                              milliseconds:
                                              1000),
                                          curve: Curves
                                              .ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape:
                                        CircleBorder(),
                                        primary:
                                        Colors.black,
                                        padding:
                                        EdgeInsets
                                            .all(10),
                                        backgroundColor:
                                        Colors
                                            .transparent),
                                    child: Icon(
                                      Icons
                                          .arrow_forward_ios_rounded,
                                      size: 30,
                                      color: Color(
                                          0xFFe74c3c),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'kia')
                        ? Padding(
                      padding: const EdgeInsets.only(
                          top: 15),
                      child: Container(
                          height: 50,
                          child: Stack(
                            children: [
                              ListView(
                                controller: list3,
                                scrollDirection:
                                Axis.horizontal,
                                reverse: true,
                                children: [
                                  textCategories(
                                      'اوبتيما', () {
                                    setState(() {
                                      subSubCategory =
                                      'اوبتيما';
                                    });
                                  },
                                      (subSubCategory ==
                                          'اوبتيما')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'سيراتو', () {
                                    setState(() {
                                      subSubCategory =
                                      'سيراتو';
                                    });
                                  },
                                      (subSubCategory ==
                                          'سيراتو')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'ريو', () {
                                    setState(() {
                                      subSubCategory =
                                      'ريو';
                                    });
                                  },
                                      (subSubCategory ==
                                          'ريو')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'كارنيفال', () {
                                    setState(() {
                                      subSubCategory =
                                      'كارنيفال';
                                    });
                                  },
                                      (subSubCategory ==
                                          'كارنيفال')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'سبورتاج', () {
                                    setState(() {
                                      subSubCategory =
                                      'سبورتاج';
                                    });
                                  },
                                      (subSubCategory ==
                                          'سبورتاج')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'كادينزا', () {
                                    setState(() {
                                      subSubCategory =
                                      'كادينزا';
                                    });
                                  },
                                      (subSubCategory ==
                                          'كادينزا')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'اوبيروس', () {
                                    setState(() {
                                      subSubCategory =
                                      'اوبيروس';
                                    });
                                  },
                                      (subSubCategory ==
                                          'اوبيروس')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'سورنتو', () {
                                    setState(() {
                                      subSubCategory =
                                      'سورنتو';
                                    });
                                  },
                                      (subSubCategory ==
                                          'سورنتو')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'كارينز', () {
                                    setState(() {
                                      subSubCategory =
                                      'كارينز';
                                    });
                                  },
                                      (subSubCategory ==
                                          'كارينز')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'بيكانتو', () {
                                    setState(() {
                                      subSubCategory =
                                      'بيكانتو';
                                    });
                                  },
                                      (subSubCategory ==
                                          'بيكانتو')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'موهافي', () {
                                    setState(() {
                                      subSubCategory =
                                      'موهافي';
                                    });
                                  },
                                      (subSubCategory ==
                                          'موهافي')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'كوريس', () {
                                    setState(() {
                                      subSubCategory =
                                      'كوريس';
                                    });
                                  },
                                      (subSubCategory ==
                                          'كوريس')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'سول', () {
                                    setState(() {
                                      subSubCategory =
                                      'سول';
                                    });
                                  },
                                      (subSubCategory ==
                                          'سول')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'سيفيا', () {
                                    setState(() {
                                      subSubCategory =
                                      'سيفيا';
                                    });
                                  },
                                      (subSubCategory ==
                                          'سيفيا')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'K900', () {
                                    setState(() {
                                      subSubCategory =
                                      'K900';
                                    });
                                  },
                                      (subSubCategory ==
                                          'K900')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'بيجاس', () {
                                    setState(() {
                                      subSubCategory =
                                      'بيجاس';
                                    });
                                  },
                                      (subSubCategory ==
                                          'بيجاس')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'تيلورايد', () {
                                    setState(() {
                                      subSubCategory =
                                      'تيلورايد';
                                    });
                                  },
                                      (subSubCategory ==
                                          'تيلورايد')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'ستينجر', () {
                                    setState(() {
                                      subSubCategory =
                                      'ستينجر';
                                    });
                                  },
                                      (subSubCategory ==
                                          'ستينجر')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'سيلتوس', () {
                                    setState(() {
                                      subSubCategory =
                                      'سيلتوس';
                                    });
                                  },
                                      (subSubCategory ==
                                          'سيلتوس')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'نيرو', () {
                                    setState(() {
                                      subSubCategory =
                                      'نيرو';
                                    });
                                  },
                                      (subSubCategory ==
                                          'نيرو')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('K5',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'K5';
                                        });
                                      },
                                      (subSubCategory ==
                                          'K5')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'سونيت', () {
                                    setState(() {
                                      subSubCategory =
                                      'سونيت';
                                    });
                                  },
                                      (subSubCategory ==
                                          'سونيت')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment
                                    .centerLeft,
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius:
                                          2,
                                          blurRadius:
                                          10,
                                          color: Colors
                                              .black
                                              .withOpacity(
                                              0.1),
                                          offset:
                                          Offset(
                                              0,
                                              10))
                                    ],
                                  ),
                                  child: TextButton(
                                    onLongPress: () {
                                      list3.animateTo(
                                          list3
                                              .position
                                              .maxScrollExtent,
                                          duration: Duration(
                                              milliseconds:
                                              50000),
                                          curve: Curves
                                              .ease);
                                    },
                                    onPressed: () {
                                      list3.animateTo(
                                          list3.offset +
                                              100,
                                          duration: Duration(
                                              milliseconds:
                                              1000),
                                          curve: Curves
                                              .ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape:
                                        CircleBorder(),
                                        primary: Colors
                                            .black,
                                        padding:
                                        EdgeInsets
                                            .all(
                                            10),
                                        backgroundColor:
                                        Colors
                                            .transparent),
                                    child: Icon(
                                      Icons
                                          .arrow_back_ios_rounded,
                                      size: 30,
                                      color: Color(
                                          0xFFe74c3c),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment
                                    .centerRight,
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius:
                                          2,
                                          blurRadius:
                                          10,
                                          color: Colors
                                              .black
                                              .withOpacity(
                                              0.1),
                                          offset:
                                          Offset(
                                              0,
                                              10))
                                    ],
                                  ),
                                  child: TextButton(
                                    onLongPress: () {
                                      list3.animateTo(
                                          list3
                                              .position
                                              .minScrollExtent,
                                          duration: Duration(
                                              milliseconds:
                                              50000),
                                          curve: Curves
                                              .ease);
                                    },
                                    onPressed: () {
                                      list3.animateTo(
                                          list3.offset -
                                              100,
                                          duration: Duration(
                                              milliseconds:
                                              1000),
                                          curve: Curves
                                              .ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape:
                                        CircleBorder(),
                                        primary: Colors
                                            .black,
                                        padding:
                                        EdgeInsets
                                            .all(
                                            10),
                                        backgroundColor:
                                        Colors
                                            .transparent),
                                    child: Icon(
                                      Icons
                                          .arrow_forward_ios_rounded,
                                      size: 30,
                                      color: Color(
                                          0xFFe74c3c),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'bmw')
                        ? Padding(
                      padding:
                      const EdgeInsets.only(
                          top: 15),
                      child: Container(
                          height: 50,
                          child: Stack(
                            children: [
                              ListView(
                                controller: list3,
                                scrollDirection:
                                Axis.horizontal,
                                reverse: true,
                                children: [
                                  textCategories(
                                      'الفئة السابعة',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'الفئة السابعة';
                                        });
                                      },
                                      (subSubCategory ==
                                          'الفئة السابعة')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'الفئة الخامسة',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'الفئة الخامسة';
                                        });
                                      },
                                      (subSubCategory ==
                                          'الفئة الخامسة')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'الفئة X',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'الفئة X';
                                        });
                                      },
                                      (subSubCategory ==
                                          'الفئة X')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'الفئة الثالثة',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'الفئة الثالثة';
                                        });
                                      },
                                      (subSubCategory ==
                                          'الفئة الثالثة')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'الفئة السادسة',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'الفئة السادسة';
                                        });
                                      },
                                      (subSubCategory ==
                                          'الفئة السادسة')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'الفئة الأولي',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'الفئة الأولي';
                                        });
                                      },
                                      (subSubCategory ==
                                          'الفئة الأولي')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'الفئة M',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'الفئة M';
                                        });
                                      },
                                      (subSubCategory ==
                                          'الفئة M')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'ميني كوبر',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'ميني كوبر';
                                        });
                                      },
                                      (subSubCategory ==
                                          'ميني كوبر')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'الفئة Z',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'الفئة Z';
                                        });
                                      },
                                      (subSubCategory ==
                                          'الفئة Z')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'الفئة i',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'الفئة i';
                                        });
                                      },
                                      (subSubCategory ==
                                          'الفئة i')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'موهافي',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'موهافي';
                                        });
                                      },
                                      (subSubCategory ==
                                          'موهافي')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'الفئة الثامنة',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'الفئة الثامنة';
                                        });
                                      },
                                      (subSubCategory ==
                                          'الفئة الثامنة')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'الفئة الثانية',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'الفئة الثانية';
                                        });
                                      },
                                      (subSubCategory ==
                                          'الفئة الثانية')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'الفئة الرابعة',
                                          () {
                                        setState(() {
                                          subSubCategory =
                                          'الفئة الرابعة';
                                        });
                                      },
                                      (subSubCategory ==
                                          'الفئة الرابعة')
                                          ? Color(
                                          0xFF2980b9)
                                          : Colors
                                          .transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment
                                    .centerLeft,
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius:
                                          2,
                                          blurRadius:
                                          10,
                                          color: Colors
                                              .black
                                              .withOpacity(
                                              0.1),
                                          offset: Offset(
                                              0,
                                              10))
                                    ],
                                  ),
                                  child:
                                  TextButton(
                                    onLongPress:
                                        () {
                                      list3.animateTo(
                                          list3
                                              .position
                                              .maxScrollExtent,
                                          duration: Duration(
                                              milliseconds:
                                              50000),
                                          curve: Curves
                                              .ease);
                                    },
                                    onPressed:
                                        () {
                                      list3.animateTo(
                                          list3.offset +
                                              100,
                                          duration: Duration(
                                              milliseconds:
                                              1000),
                                          curve: Curves
                                              .ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape:
                                        CircleBorder(),
                                        primary:
                                        Colors
                                            .black,
                                        padding:
                                        EdgeInsets.all(
                                            10),
                                        backgroundColor:
                                        Colors
                                            .transparent),
                                    child: Icon(
                                      Icons
                                          .arrow_back_ios_rounded,
                                      size: 30,
                                      color: Color(
                                          0xFFe74c3c),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment
                                    .centerRight,
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius:
                                          2,
                                          blurRadius:
                                          10,
                                          color: Colors
                                              .black
                                              .withOpacity(
                                              0.1),
                                          offset: Offset(
                                              0,
                                              10))
                                    ],
                                  ),
                                  child:
                                  TextButton(
                                    onLongPress:
                                        () {
                                      list3.animateTo(
                                          list3
                                              .position
                                              .minScrollExtent,
                                          duration: Duration(
                                              milliseconds:
                                              50000),
                                          curve: Curves
                                              .ease);
                                    },
                                    onPressed:
                                        () {
                                      list3.animateTo(
                                          list3.offset -
                                              100,
                                          duration: Duration(
                                              milliseconds:
                                              1000),
                                          curve: Curves
                                              .ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape:
                                        CircleBorder(),
                                        primary:
                                        Colors
                                            .black,
                                        padding:
                                        EdgeInsets.all(
                                            10),
                                        backgroundColor:
                                        Colors
                                            .transparent),
                                    child: Icon(
                                      Icons
                                          .arrow_forward_ios_rounded,
                                      size: 30,
                                      color: Color(
                                          0xFFe74c3c),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'mercedes')
                        ? Padding(
                      padding:
                      const EdgeInsets
                          .only(top: 15),
                      child: Container(
                          height: 50,
                          child: Stack(
                            children: [
                              ListView(
                                controller:
                                list3,
                                scrollDirection:
                                Axis.horizontal,
                                reverse: true,
                                children: [
                                  textCategories(
                                      'S',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'S';
                                            });
                                      },
                                      (subSubCategory ==
                                          'S')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'E',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'E';
                                            });
                                      },
                                      (subSubCategory ==
                                          'E')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'SE',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'SE';
                                            });
                                      },
                                      (subSubCategory ==
                                          'SE')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'SEL',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'SEL';
                                            });
                                      },
                                      (subSubCategory ==
                                          'SEL')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'AMG',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'AMG';
                                            });
                                      },
                                      (subSubCategory ==
                                          'AMG')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'مرسيدس G',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'مرسيدس G';
                                            });
                                      },
                                      (subSubCategory ==
                                          'مرسيدس G')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'C',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'C';
                                            });
                                      },
                                      (subSubCategory ==
                                          'C')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'SL',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'SL';
                                            });
                                      },
                                      (subSubCategory ==
                                          'SL')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'CLS',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'CLS';
                                            });
                                      },
                                      (subSubCategory ==
                                          'CLS')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'ML',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'ML';
                                            });
                                      },
                                      (subSubCategory ==
                                          'ML')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'CL',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'CL';
                                            });
                                      },
                                      (subSubCategory ==
                                          'CL')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'CLK',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'CLK';
                                            });
                                      },
                                      (subSubCategory ==
                                          'CLK')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'SEC',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'SEC';
                                            });
                                      },
                                      (subSubCategory ==
                                          'SEC')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'SLK',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'SLK';
                                            });
                                      },
                                      (subSubCategory ==
                                          'SLK')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'الفئة A',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'الفئة A';
                                            });
                                      },
                                      (subSubCategory ==
                                          'الفئة A')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'GLS',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'GLS';
                                            });
                                      },
                                      (subSubCategory ==
                                          'GLS')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'GLE',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'GLE';
                                            });
                                      },
                                      (subSubCategory ==
                                          'GLE')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'GLC',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'GLC';
                                            });
                                      },
                                      (subSubCategory ==
                                          'GLC')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'GLA',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'GLA';
                                            });
                                      },
                                      (subSubCategory ==
                                          'GLA')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'CLA',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'CLA';
                                            });
                                      },
                                      (subSubCategory ==
                                          'CLA')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'الفئة V',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'الفئة V';
                                            });
                                      },
                                      (subSubCategory ==
                                          'الفئة V')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'B',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'B';
                                            });
                                      },
                                      (subSubCategory ==
                                          'B')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'GL',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'GL';
                                            });
                                      },
                                      (subSubCategory ==
                                          'GL')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'GLK',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'GLK';
                                            });
                                      },
                                      (subSubCategory ==
                                          'GLK')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'مرسيدس GT',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'مرسيدس GT';
                                            });
                                      },
                                      (subSubCategory ==
                                          'مرسيدس GT')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'GTS',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'GTS';
                                            });
                                      },
                                      (subSubCategory ==
                                          'GTS')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'R',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'R';
                                            });
                                      },
                                      (subSubCategory ==
                                          'R')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'SLC',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'SLC';
                                            });
                                      },
                                      (subSubCategory ==
                                          'SLC')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'فان سبرنتر',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'فان سبرنتر';
                                            });
                                      },
                                      (subSubCategory ==
                                          'فان سبرنتر')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'مايباخ',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'مايباخ';
                                            });
                                      },
                                      (subSubCategory ==
                                          'مايباخ')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories(
                                      'GLB',
                                          () {
                                        setState(
                                                () {
                                              subSubCategory =
                                              'GLB';
                                            });
                                      },
                                      (subSubCategory ==
                                          'GLB')
                                          ? Color(0xFF2980b9)
                                          : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                              Align(
                                alignment:
                                Alignment
                                    .centerLeft,
                                child:
                                Container(
                                  decoration:
                                  BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius:
                                          2,
                                          blurRadius:
                                          10,
                                          color:
                                          Colors.black.withOpacity(0.1),
                                          offset: Offset(0, 10))
                                    ],
                                  ),
                                  child:
                                  TextButton(
                                    onLongPress:
                                        () {
                                      list3.animateTo(
                                          list3
                                              .position.maxScrollExtent,
                                          duration:
                                          Duration(milliseconds: 50000),
                                          curve: Curves.ease);
                                    },
                                    onPressed:
                                        () {
                                      list3.animateTo(
                                          list3.offset +
                                              100,
                                          duration:
                                          Duration(milliseconds: 1000),
                                          curve: Curves.ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape:
                                        CircleBorder(),
                                        primary: Colors
                                            .black,
                                        padding: EdgeInsets.all(
                                            10),
                                        backgroundColor:
                                        Colors.transparent),
                                    child:
                                    Icon(
                                      Icons
                                          .arrow_back_ios_rounded,
                                      size:
                                      30,
                                      color: Colors
                                          .white,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment:
                                Alignment
                                    .centerRight,
                                child:
                                Container(
                                  decoration:
                                  BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius:
                                          2,
                                          blurRadius:
                                          10,
                                          color:
                                          Colors.black.withOpacity(0.1),
                                          offset: Offset(0, 10))
                                    ],
                                  ),
                                  child:
                                  TextButton(
                                    onLongPress:
                                        () {
                                      list3.animateTo(
                                          list3
                                              .position.minScrollExtent,
                                          duration:
                                          Duration(milliseconds: 50000),
                                          curve: Curves.ease);
                                    },
                                    onPressed:
                                        () {
                                      list3.animateTo(
                                          list3.offset -
                                              100,
                                          duration:
                                          Duration(milliseconds: 1000),
                                          curve: Curves.ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape:
                                        CircleBorder(),
                                        primary: Colors
                                            .black,
                                        padding: EdgeInsets.all(
                                            10),
                                        backgroundColor:
                                        Colors.transparent),
                                    child:
                                    Icon(
                                      Icons
                                          .arrow_forward_ios_rounded,
                                      size:
                                      30,
                                      color: Colors
                                          .white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'gmc')
                        ? Padding(
                      padding:
                      const EdgeInsets
                          .only(
                          top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection:
                            Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories(
                                  'يوكن',
                                      () {
                                    setState(
                                            () {
                                          subSubCategory =
                                          'يوكن';
                                        });
                                  },
                                  (subSubCategory ==
                                      'يوكن')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories(
                                  'سوبربان',
                                      () {
                                    setState(
                                            () {
                                          subSubCategory =
                                          'سوبربان';
                                        });
                                  },
                                  (subSubCategory ==
                                      'سوبربان')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories(
                                  'سييرا',
                                      () {
                                    setState(
                                            () {
                                          subSubCategory =
                                          'سييرا';
                                        });
                                  },
                                  (subSubCategory ==
                                      'سييرا')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories(
                                  'بيك أب',
                                      () {
                                    setState(
                                            () {
                                          subSubCategory =
                                          'بيك أب';
                                        });
                                  },
                                  (subSubCategory ==
                                      'بيك أب')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories(
                                  'انفوي',
                                      () {
                                    setState(
                                            () {
                                          subSubCategory =
                                          'انفوي';
                                        });
                                  },
                                  (subSubCategory ==
                                      'انفوي')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories(
                                  'اكاديا',
                                      () {
                                    setState(
                                            () {
                                          subSubCategory =
                                          'اكاديا';
                                        });
                                  },
                                  (subSubCategory ==
                                      'اكاديا')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories(
                                  'فان',
                                      () {
                                    setState(
                                            () {
                                          subSubCategory =
                                          'فان';
                                        });
                                  },
                                  (subSubCategory ==
                                      'فان')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories(
                                  'سافانا',
                                      () {
                                    setState(
                                            () {
                                          subSubCategory =
                                          'سافانا';
                                        });
                                  },
                                  (subSubCategory ==
                                      'سافانا')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories(
                                  'سفاري',
                                      () {
                                    setState(
                                            () {
                                          subSubCategory =
                                          'سفاري';
                                        });
                                  },
                                  (subSubCategory ==
                                      'سفاري')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories(
                                  'تيرين',
                                      () {
                                    setState(
                                            () {
                                          subSubCategory =
                                          'تيرين';
                                        });
                                  },
                                  (subSubCategory ==
                                      'تيرين')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories(
                                  'جيمي',
                                      () {
                                    setState(
                                            () {
                                          subSubCategory =
                                          'جيمي';
                                        });
                                  },
                                  (subSubCategory ==
                                      'جيمي')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory ==
                        'astonmartin')
                        ? Padding(
                      padding:
                      const EdgeInsets
                          .only(
                          top:
                          15),
                      child:
                      Container(
                          height:
                          50,
                          child:
                          ListView(
                            scrollDirection:
                            Axis.horizontal,
                            reverse:
                            true,
                            children: [
                              textCategories('DB11',
                                      () {
                                    setState(() {
                                      subSubCategory = 'DB11';
                                    });
                                  }, (subSubCategory == 'DB11')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('DBS',
                                      () {
                                    setState(() {
                                      subSubCategory = 'DBS';
                                    });
                                  }, (subSubCategory == 'DBS')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('رابيد اس',
                                      () {
                                    setState(() {
                                      subSubCategory = 'رابيد اس';
                                    });
                                  }, (subSubCategory == 'رابيد اس') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('فانتاج',
                                      () {
                                    setState(() {
                                      subSubCategory = 'فانتاج';
                                    });
                                  }, (subSubCategory == 'فانتاج') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory ==
                        'audi')
                        ? Padding(
                      padding: const EdgeInsets
                          .only(
                          top:
                          15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection:
                            Axis.horizontal,
                            reverse:
                            true,
                            children: [
                              textCategories('A8',
                                      () {
                                    setState(() {
                                      subSubCategory = 'A8';
                                    });
                                  }, (subSubCategory == 'A8')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('A6',
                                      () {
                                    setState(() {
                                      subSubCategory = 'A6';
                                    });
                                  }, (subSubCategory == 'A6')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('Q7',
                                      () {
                                    setState(() {
                                      subSubCategory = 'Q7';
                                    });
                                  }, (subSubCategory == 'Q7')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('Q5',
                                      () {
                                    setState(() {
                                      subSubCategory = 'Q5';
                                    });
                                  }, (subSubCategory == 'Q5')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('A4',
                                      () {
                                    setState(() {
                                      subSubCategory = 'A4';
                                    });
                                  }, (subSubCategory == 'A4')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('A5',
                                      () {
                                    setState(() {
                                      subSubCategory = 'A5';
                                    });
                                  }, (subSubCategory == 'A5')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('A7',
                                      () {
                                    setState(() {
                                      subSubCategory = 'A7';
                                    });
                                  }, (subSubCategory == 'A7')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('S8',
                                      () {
                                    setState(() {
                                      subSubCategory = 'S8';
                                    });
                                  }, (subSubCategory == 'S8')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('TT',
                                      () {
                                    setState(() {
                                      subSubCategory = 'TT';
                                    });
                                  }, (subSubCategory == 'TT')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('A3',
                                      () {
                                    setState(() {
                                      subSubCategory = 'A3';
                                    });
                                  }, (subSubCategory == 'A3')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('Q3',
                                      () {
                                    setState(() {
                                      subSubCategory = 'Q3';
                                    });
                                  }, (subSubCategory == 'Q3')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('Q8',
                                      () {
                                    setState(() {
                                      subSubCategory = 'Q8';
                                    });
                                  }, (subSubCategory == 'Q8')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('R8',
                                      () {
                                    setState(() {
                                      subSubCategory = 'R8';
                                    });
                                  }, (subSubCategory == 'R8')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('RS',
                                      () {
                                    setState(() {
                                      subSubCategory = 'RS';
                                    });
                                  }, (subSubCategory == 'RS')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('S3',
                                      () {
                                    setState(() {
                                      subSubCategory = 'S3';
                                    });
                                  }, (subSubCategory == 'S3')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory ==
                        'cadillac')
                        ? Padding(
                      padding:
                      const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('اسكاليد', () {
                                setState(() {
                                  subSubCategory = 'اسكاليد';
                                });
                              }, (subSubCategory == 'اسكاليد') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CTS', () {
                                setState(() {
                                  subSubCategory = 'CTS';
                                });
                              }, (subSubCategory == 'CTS')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('فليتوود', () {
                                setState(() {
                                  subSubCategory = 'فليتوود';
                                });
                              }, (subSubCategory == 'فليتوود') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('DTS', () {
                                setState(() {
                                  subSubCategory = 'DTS';
                                });
                              }, (subSubCategory == 'DTS')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ديفيل', () {
                                setState(() {
                                  subSubCategory = 'ديفيل';
                                });
                              }, (subSubCategory == 'ديفيل')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('SRX', () {
                                setState(() {
                                  subSubCategory = 'SRX';
                                });
                              }, (subSubCategory == 'SRX')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('STS', () {
                                setState(() {
                                  subSubCategory = 'STS';
                                });
                              }, (subSubCategory == 'STS')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كونكورس', () {
                                setState(() {
                                  subSubCategory = 'كونكورس';
                                });
                              }, (subSubCategory == 'كونكورس') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CT6', () {
                                setState(() {
                                  subSubCategory = 'CT6';
                                });
                              }, (subSubCategory == 'CT6')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('XT4', () {
                                setState(() {
                                  subSubCategory = 'XT4';
                                });
                              }, (subSubCategory == 'null')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('XT5', () {
                                setState(() {
                                  subSubCategory = 'XT5';
                                });
                              }, (subSubCategory == 'XT5')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('XT6', () {
                                setState(() {
                                  subSubCategory = 'XT6';
                                });
                              }, (subSubCategory == 'XT6')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CT4', () {
                                setState(() {
                                  subSubCategory = 'CT4';
                                });
                              }, (subSubCategory == 'CT4')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CT5', () {
                                setState(() {
                                  subSubCategory = 'CT5';
                                });
                              }, (subSubCategory == 'CT5')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ATS', () {
                                setState(() {
                                  subSubCategory = 'ATS';
                                });
                              }, (subSubCategory == 'ATS')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory ==
                        'changan')
                        ? Padding(
                      padding:
                      const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('ايدو', () {
                                setState(() {
                                  subSubCategory = 'ايدو';
                                });
                              }, (subSubCategory == 'ايدو')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CS35', () {
                                setState(() {
                                  subSubCategory = 'CS35';
                                });
                              }, (subSubCategory == 'CS35')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CS75', () {
                                setState(() {
                                  subSubCategory = 'CS75';
                                });
                              }, (subSubCategory == 'CS75')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CS95', () {
                                setState(() {
                                  subSubCategory = 'CS95';
                                });
                              }, (subSubCategory == 'CS95')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('شانجان V7', () {
                                setState(() {
                                  subSubCategory = 'شانجان V7';
                                });
                              }, (subSubCategory == 'شانجان V7') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CS85', () {
                                setState(() {
                                  subSubCategory = 'CS85';
                                });
                              }, (subSubCategory == 'CS85')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('السفن', () {
                                setState(() {
                                  subSubCategory = 'السفن';
                                });
                              }, (subSubCategory == 'السفن')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('هنتر', () {
                                setState(() {
                                  subSubCategory = 'هنتر';
                                });
                              }, (subSubCategory == 'هنتر')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory ==
                        'cherry')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('QQ', () {
                                setState(() {
                                  subSubCategory = 'QQ';
                                });
                              }, (subSubCategory == 'QQ')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('شيري A5', () {
                                setState(() {
                                  subSubCategory = 'شيري A5';
                                });
                              }, (subSubCategory == 'شيري A5') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ايستار', () {
                                setState(() {
                                  subSubCategory = 'ايستار';
                                });
                              }, (subSubCategory == 'ايستار') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كوين', () {
                                setState(() {
                                  subSubCategory = 'كوين';
                                });
                              }, (subSubCategory == 'كوين')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('شيري A3', () {
                                setState(() {
                                  subSubCategory = 'شيري A3';
                                });
                              }, (subSubCategory == 'شيري A3') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('شيري A1', () {
                                setState(() {
                                  subSubCategory = 'شيري A1';
                                });
                              }, (subSubCategory == 'شيري A1') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('اريزو 3', () {
                                setState(() {
                                  subSubCategory = 'اريزو 3';
                                });
                              }, (subSubCategory == 'اريزو 3') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('اريزو 6', () {
                                setState(() {
                                  subSubCategory = 'اريزو 6';
                                });
                              }, (subSubCategory == 'اريزو 6') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('تيجو 2', () {
                                setState(() {
                                  subSubCategory = 'تيجو 2';
                                });
                              }, (subSubCategory == 'تيجو 2') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('تيجو 7', () {
                                setState(() {
                                  subSubCategory = 'تيجو 7';
                                });
                              }, (subSubCategory == 'تيجو 7') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('تيجو 8', () {
                                setState(() {
                                  subSubCategory = 'تيجو 8';
                                });
                              }, (subSubCategory == 'تيجو 8') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'chrysler')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('M300', () {
                                setState(() {
                                  subSubCategory = 'M300';
                                });
                              }, (subSubCategory == 'M300')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('C300', () {
                                setState(() {
                                  subSubCategory = 'C300';
                                });
                              }, (subSubCategory == 'C300')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('جراند فوياجر', () {
                                setState(() {
                                  subSubCategory = 'جراند فوياجر';
                                });
                              }, (subSubCategory == 'جراند فوياجر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كونكورد', () {
                                setState(() {
                                  subSubCategory = 'كونكورد';
                                });
                              }, (subSubCategory == 'كونكورد') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كروس فاير', () {
                                setState(() {
                                  subSubCategory = 'كروس فاير';
                                });
                              }, (subSubCategory == 'كروس فاير') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('C200', () {
                                setState(() {
                                  subSubCategory = 'C200';
                                });
                              }, (subSubCategory == 'C200')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بي تي كروزر', () {
                                setState(() {
                                  subSubCategory = 'بي تي كروزر';
                                });
                              }, (subSubCategory == 'بي تي كروزر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('امبيريال', () {
                                setState(() {
                                  subSubCategory = 'امبيريال';
                                });
                              }, (subSubCategory == 'امبيريال') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بلايموث', () {
                                setState(() {
                                  subSubCategory = 'بلايموث';
                                });
                              }, (subSubCategory == 'بلايموث') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('باسيفيكا', () {
                                setState(() {
                                  subSubCategory = 'باسيفيكا';
                                });
                              }, (subSubCategory == 'باسيفيكا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'citroen')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('C3', () {
                                setState(() {
                                  subSubCategory = 'C3';
                                });
                              }, (subSubCategory == 'C3')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('C4', () {
                                setState(() {
                                  subSubCategory = 'C4';
                                });
                              }, (subSubCategory == 'C4')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('C6', () {
                                setState(() {
                                  subSubCategory = 'C6';
                                });
                              }, (subSubCategory == 'C6')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('اكسارا', () {
                                setState(() {
                                  subSubCategory = 'اكسارا';
                                });
                              }, (subSubCategory == 'اكسارا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('C2', () {
                                setState(() {
                                  subSubCategory = 'C2';
                                });
                              }, (subSubCategory == 'C2')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('C1', () {
                                setState(() {
                                  subSubCategory = 'C1';
                                });
                              }, (subSubCategory == 'C1')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ربجنسي', () {
                                setState(() {
                                  subSubCategory = 'ربجنسي';
                                });
                              }, (subSubCategory == 'ربجنسي') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('برلنجو', () {
                                setState(() {
                                  subSubCategory = 'برلنجو';
                                });
                              }, (subSubCategory == 'برلنجو') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'daewoo')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('ليجانزا', () {
                                setState(() {
                                  subSubCategory = 'ليجانزا';
                                });
                              }, (subSubCategory == 'ليجانزا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('لانوس', () {
                                setState(() {
                                  subSubCategory = 'لانوس';
                                });
                              }, (subSubCategory == 'لانوس')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ماتز', () {
                                setState(() {
                                  subSubCategory = 'ماتز';
                                });
                              }, (subSubCategory == 'ماتز')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('نوبيرا', () {
                                setState(() {
                                  subSubCategory = 'نوبيرا';
                                });
                              }, (subSubCategory == 'نوبيرا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'daihatsu')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('سيريون', () {
                                setState(() {
                                  subSubCategory = 'سيريون';
                                });
                              }, (subSubCategory == 'سيريون') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('تيريوس', () {
                                setState(() {
                                  subSubCategory = 'تيريوس';
                                });
                              }, (subSubCategory == 'تيريوس') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ماتيريا', () {
                                setState(() {
                                  subSubCategory = 'ماتيريا';
                                });
                              }, (subSubCategory == 'ماتيريا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'dodge')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('تشارجر', () {
                                setState(() {
                                  subSubCategory = 'تشارجر';
                                });
                              }, (subSubCategory == 'تشارجر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('تشالنجر', () {
                                setState(() {
                                  subSubCategory = 'تشالنجر';
                                });
                              }, (subSubCategory == 'تشالنجر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('دورانجو', () {
                                setState(() {
                                  subSubCategory = 'دورانجو';
                                });
                              }, (subSubCategory == 'دورانجو') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كارافان', () {
                                setState(() {
                                  subSubCategory = 'كارافان';
                                });
                              }, (subSubCategory == 'كارافان') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('رام', () {
                                setState(() {
                                  subSubCategory = 'رام';
                                });
                              }, (subSubCategory == 'رام')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('نيترو', () {
                                setState(() {
                                  subSubCategory = 'نيترو';
                                });
                              }, (subSubCategory == 'نيترو')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كاليبر', () {
                                setState(() {
                                  subSubCategory = 'كاليبر';
                                });
                              }, (subSubCategory == 'كاليبر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('فايبر', () {
                                setState(() {
                                  subSubCategory = 'فايبر';
                                });
                              }, (subSubCategory == 'فايبر')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('دودج بيك أب', () {
                                setState(() {
                                  subSubCategory = 'دودج بيك أب';
                                });
                              }, (subSubCategory == 'دودج بيك أب') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كارافان', () {
                                setState(() {
                                  subSubCategory = 'كارافان';
                                });
                              }, (subSubCategory == 'كارافان') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('انتربيد', () {
                                setState(() {
                                  subSubCategory = 'انتربيد';
                                });
                              }, (subSubCategory == 'انتربيد') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('نيون', () {
                                setState(() {
                                  subSubCategory = 'نيون';
                                });
                              }, (subSubCategory == 'نيون')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'faw')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('T80', () {
                                setState(() {
                                  subSubCategory = 'T80';
                                });
                              }, (subSubCategory == 'T80')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('V80', () {
                                setState(() {
                                  subSubCategory = 'V80';
                                });
                              }, (subSubCategory == 'V80')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('أولي', () {
                                setState(() {
                                  subSubCategory = 'أولي';
                                });
                              }, (subSubCategory == 'أولي')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بسترن B50', () {
                                setState(() {
                                  subSubCategory = 'بسترن B50';
                                });
                              }, (subSubCategory == 'بسترن B50') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بسترن B70', () {
                                setState(() {
                                  subSubCategory = 'بسترن B70';
                                });
                              }, (subSubCategory == 'بسترن B70') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بسترن X80', () {
                                setState(() {
                                  subSubCategory = 'بسترن X80';
                                });
                              }, (subSubCategory == 'بسترن X80') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('T77', () {
                                setState(() {
                                  subSubCategory = 'T77';
                                });
                              }, (subSubCategory == 'T77')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('X40', () {
                                setState(() {
                                  subSubCategory = 'X40';
                                });
                              }, (subSubCategory == 'X40')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'ferrari')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('488 PISTA', () {
                                setState(() {
                                  subSubCategory = '488 PISTA';
                                });
                              }, (subSubCategory == '488 PISTA') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('812', () {
                                setState(() {
                                  subSubCategory = '812';
                                });
                              }, (subSubCategory == '812')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('F8', () {
                                setState(() {
                                  subSubCategory = 'F8';
                                });
                              }, (subSubCategory == 'F8')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GTC4', () {
                                setState(() {
                                  subSubCategory = 'GTC4';
                                });
                              }, (subSubCategory == 'GTC4')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('MONZA', () {
                                setState(() {
                                  subSubCategory = 'MONZA';
                                });
                              }, (subSubCategory == 'MONZA')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('Roma', () {
                                setState(() {
                                  subSubCategory = 'Roma';
                                });
                              }, (subSubCategory == 'Roma')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('SF90', () {
                                setState(() {
                                  subSubCategory = 'SF90';
                                });
                              }, (subSubCategory == 'SF90')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'fiat')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('دولتشي فيتا', () {
                                setState(() {
                                  subSubCategory = 'دولتشي فيتا';
                                });
                              }, (subSubCategory == 'دولتشي فيتا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('فيات 500', () {
                                setState(() {
                                  subSubCategory = 'فيات 500';
                                });
                              }, (subSubCategory == 'فيات 500') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('500X فيات', () {
                                setState(() {
                                  subSubCategory = '500X فيات';
                                });
                              }, (subSubCategory == '500X فيات') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('فيورينو', () {
                                setState(() {
                                  subSubCategory = 'فيورينو';
                                });
                              }, (subSubCategory == 'فيورينو') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('لينيا', () {
                                setState(() {
                                  subSubCategory = 'لينيا';
                                });
                              }, (subSubCategory == 'لينيا')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'ford')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: Stack(
                            children: [
                              ListView(
                                controller: list3,
                                scrollDirection: Axis.horizontal,
                                reverse: true,
                                children: [
                                  textCategories('كراون فكتوريا', () {
                                    setState(() {
                                      subSubCategory = 'كراون فكتوريا';
                                    });
                                  }, (subSubCategory == 'كراون فكتوريا')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('جراند ماركيز', () {
                                    setState(() {
                                      subSubCategory = 'جراند ماركيز';
                                    });
                                  }, (subSubCategory == 'جراند ماركيز')
                                      ? Color(0xFF2980b9)
                                      : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('اكسبلور', () {
                                    setState(() {
                                      subSubCategory = 'اكسبلور';
                                    });
                                  }, (subSubCategory == 'اكسبلور') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('توروس', () {
                                    setState(() {
                                      subSubCategory = 'توروس';
                                    });
                                  }, (subSubCategory == 'توروس') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('اكسبيدشن', () {
                                    setState(() {
                                      subSubCategory = 'اكسبيدشن';
                                    });
                                  }, (subSubCategory == 'اكسبيدشن') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('موستنج', () {
                                    setState(() {
                                      subSubCategory = 'موستنج';
                                    });
                                  }, (subSubCategory == 'موستنج') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('ايدج', () {
                                    setState(() {
                                      subSubCategory = 'ايدج';
                                    });
                                  }, (subSubCategory == 'ايدج') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('F150', () {
                                    setState(() {
                                      subSubCategory = 'F150';
                                    });
                                  }, (subSubCategory == 'F150') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('فيوجن', () {
                                    setState(() {
                                      subSubCategory = 'فيوجن';
                                    });
                                  }, (subSubCategory == 'فيوجن') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('وندستار', () {
                                    setState(() {
                                      subSubCategory = 'وندستار';
                                    });
                                  }, (subSubCategory == 'وندستار') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('فلكس', () {
                                    setState(() {
                                      subSubCategory = 'فلكس';
                                    });
                                  }, (subSubCategory == 'فلكس') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('فوكس', () {
                                    setState(() {
                                      subSubCategory = 'فوكس';
                                    });
                                  }, (subSubCategory == 'فوكس') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('مونديو', () {
                                    setState(() {
                                      subSubCategory = 'مونديو';
                                    });
                                  }, (subSubCategory == 'مونديو') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('F250', () {
                                    setState(() {
                                      subSubCategory = 'F250';
                                    });
                                  }, (subSubCategory == 'F250') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('F350', () {
                                    setState(() {
                                      subSubCategory = 'F350';
                                    });
                                  }, (subSubCategory == 'F350') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('رينجر', () {
                                    setState(() {
                                      subSubCategory = 'رينجر';
                                    });
                                  }, (subSubCategory == 'رينجر') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('اكس كورجن', () {
                                    setState(() {
                                      subSubCategory = 'اكس كورجن';
                                    });
                                  }, (subSubCategory == 'اكس كورجن') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('بيك اب', () {
                                    setState(() {
                                      subSubCategory = 'بيك اب';
                                    });
                                  }, (subSubCategory == 'بيك اب') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('اسكيب', () {
                                    setState(() {
                                      subSubCategory = 'اسكيب';
                                    });
                                  }, (subSubCategory == 'اسكيب') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('سبلاش', () {
                                    setState(() {
                                      subSubCategory = 'سبلاش';
                                    });
                                  }, (subSubCategory == 'سبلاش') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('كوجر', () {
                                    setState(() {
                                      subSubCategory = 'كوجر';
                                    });
                                  }, (subSubCategory == 'كوجر') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('ثندريبرد', () {
                                    setState(() {
                                      subSubCategory = 'ثندريبرد';
                                    });
                                  }, (subSubCategory == 'ثندريبرد') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('F450', () {
                                    setState(() {
                                      subSubCategory = 'F450';
                                    });
                                  }, (subSubCategory == 'F450') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('F550', () {
                                    setState(() {
                                      subSubCategory = 'F550';
                                    });
                                  }, (subSubCategory == 'F550') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('اسكورت', () {
                                    setState(() {
                                      subSubCategory = 'اسكورت';
                                    });
                                  }, (subSubCategory == 'اسكورت') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('ايكوسبورت', () {
                                    setState(() {
                                      subSubCategory = 'ايكوسبورت';
                                    });
                                  }, (subSubCategory == 'ايكوسبورت') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('فان فورد', () {
                                    setState(() {
                                      subSubCategory = 'فان فورد';
                                    });
                                  }, (subSubCategory == 'فان فورد') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('فيجو', () {
                                    setState(() {
                                      subSubCategory = 'فيجو';
                                    });
                                  }, (subSubCategory == 'فيجو') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  textCategories('برونكو', () {
                                    setState(() {
                                      subSubCategory = 'برونكو';
                                    });
                                  }, (subSubCategory == 'برونكو') ? Color(
                                      0xFF2980b9) : Colors.transparent),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1),
                                          offset: Offset(0, 10))
                                    ],
                                  ),
                                  child: TextButton(
                                    onLongPress: () {
                                      list3.animateTo(
                                          list3.position.maxScrollExtent,
                                          duration: Duration(
                                              milliseconds: 50000),
                                          curve: Curves.ease);
                                    },
                                    onPressed: () {
                                      list3.animateTo(list3.offset + 100,
                                          duration: Duration(
                                              milliseconds: 1000),
                                          curve: Curves.ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder(),
                                        primary: Colors.black,
                                        padding: EdgeInsets.all(10),
                                        backgroundColor: Colors.transparent),
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: 30,
                                      color: Color(0xFFe74c3c),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1),
                                          offset: Offset(0, 10))
                                    ],
                                  ),
                                  child: TextButton(
                                    onLongPress: () {
                                      list3.animateTo(
                                          list3.position.minScrollExtent,
                                          duration: Duration(
                                              milliseconds: 50000),
                                          curve: Curves.ease);
                                    },
                                    onPressed: () {
                                      list3.animateTo(list3.offset - 100,
                                          duration: Duration(
                                              milliseconds: 1000),
                                          curve: Curves.ease);
                                    },
                                    style: TextButton.styleFrom(
                                        shape: CircleBorder(),
                                        primary: Colors.black,
                                        padding: EdgeInsets.all(10),
                                        backgroundColor: Colors.transparent),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 30,
                                      color: Color(0xFFe74c3c),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'GAC')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('GA3', () {
                                setState(() {
                                  subSubCategory = 'GA3';
                                });
                              }, (subSubCategory == 'GA3')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GA4', () {
                                setState(() {
                                  subSubCategory = 'GA4';
                                });
                              }, (subSubCategory == 'GA4')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GA8', () {
                                setState(() {
                                  subSubCategory = 'GA8';
                                });
                              }, (subSubCategory == 'GA8')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GS3', () {
                                setState(() {
                                  subSubCategory = 'GS3';
                                });
                              }, (subSubCategory == 'GS3')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GS4', () {
                                setState(() {
                                  subSubCategory = 'GS4';
                                });
                              }, (subSubCategory == 'GS4')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GS8', () {
                                setState(() {
                                  subSubCategory = 'GS8';
                                });
                              }, (subSubCategory == 'GS8')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GN6', () {
                                setState(() {
                                  subSubCategory = 'GN6';
                                });
                              }, (subSubCategory == 'GN6')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GN8', () {
                                setState(() {
                                  subSubCategory = 'GN8';
                                });
                              }, (subSubCategory == 'GN8')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GS5', () {
                                setState(() {
                                  subSubCategory = 'GN8';
                                });
                              }, (subSubCategory == 'GS5')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'geely')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('EC7', () {
                                setState(() {
                                  subSubCategory = 'EC7';
                                });
                              }, (subSubCategory == 'EC7')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('EC8', () {
                                setState(() {
                                  subSubCategory = 'EC8';
                                });
                              }, (subSubCategory == 'EC8')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('LC Panda', () {
                                setState(() {
                                  subSubCategory = 'LC Panda';
                                });
                              }, (subSubCategory == 'LC Panda') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('امجراند 7', () {
                                setState(() {
                                  subSubCategory = 'امجراند 7';
                                });
                              }, (subSubCategory == 'امجراند 7') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GS اميجراند', () {
                                setState(() {
                                  subSubCategory = 'GS اميجراند';
                                });
                              }, (subSubCategory == 'GS اميجراند') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('X7 اميجراند', () {
                                setState(() {
                                  subSubCategory = 'X7 اميجراند';
                                });
                              }, (subSubCategory == 'X7 اميجراند') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بينراي', () {
                                setState(() {
                                  subSubCategory = 'بينراي';
                                });
                              }, (subSubCategory == 'بينراي') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كولراي', () {
                                setState(() {
                                  subSubCategory = 'كولراي';
                                });
                              }, (subSubCategory == 'كولراي') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ازكارا', () {
                                setState(() {
                                  subSubCategory = 'ازكارا';
                                });
                              }, (subSubCategory == 'ازكارا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'greatwall')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('ونجل 5', () {
                                setState(() {
                                  subSubCategory = 'ونجل 5';
                                });
                              }, (subSubCategory == 'ونجل 5') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ونجل 6', () {
                                setState(() {
                                  subSubCategory = 'ونجل 6';
                                });
                              }, (subSubCategory == 'ونجل 6') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ونجل 7', () {
                                setState(() {
                                  subSubCategory = 'ونجل 7';
                                });
                              }, (subSubCategory == 'ونجل 7') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('باور', () {
                                setState(() {
                                  subSubCategory = 'باور';
                                });
                              }, (subSubCategory == 'باور')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'haval')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('H2 هافال', () {
                                setState(() {
                                  subSubCategory = 'H2 هافال';
                                });
                              }, (subSubCategory == 'H2 هافال') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('H6 هافال', () {
                                setState(() {
                                  subSubCategory = 'H6 هافال';
                                });
                              }, (subSubCategory == 'H6 هافال') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('H9 هافال', () {
                                setState(() {
                                  subSubCategory = 'H9 هافال';
                                });
                              }, (subSubCategory == 'H9 هافال') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'hummer')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('H3', () {
                                setState(() {
                                  subSubCategory = 'H3';
                                });
                              }, (subSubCategory == 'H3')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('H2', () {
                                setState(() {
                                  subSubCategory = 'H2';
                                });
                              }, (subSubCategory == 'H2')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('H1', () {
                                setState(() {
                                  subSubCategory = 'H1';
                                });
                              }, (subSubCategory == 'H1')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'infinity')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('FX', () {
                                setState(() {
                                  subSubCategory = 'FX';
                                });
                              }, (subSubCategory == 'FX')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('QX', () {
                                setState(() {
                                  subSubCategory = 'QX';
                                });
                              }, (subSubCategory == 'QX')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('G انفنيتي', () {
                                setState(() {
                                  subSubCategory = 'G انفنيتي';
                                });
                              }, (subSubCategory == 'G انفنيتي') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('Q', () {
                                setState(() {
                                  subSubCategory = 'Q';
                                });
                              }, (subSubCategory == 'Q')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('M', () {
                                setState(() {
                                  subSubCategory = 'M';
                                });
                              }, (subSubCategory == 'M')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('Q30', () {
                                setState(() {
                                  subSubCategory = 'Q30';
                                });
                              }, (subSubCategory == 'Q30')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('Q50', () {
                                setState(() {
                                  subSubCategory = 'Q50';
                                });
                              }, (subSubCategory == 'Q50')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('Q60', () {
                                setState(() {
                                  subSubCategory = 'Q60';
                                });
                              }, (subSubCategory == 'Q60')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('Q70', () {
                                setState(() {
                                  subSubCategory = 'Q70';
                                });
                              }, (subSubCategory == 'Q70')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('QX50', () {
                                setState(() {
                                  subSubCategory = 'QX50';
                                });
                              }, (subSubCategory == 'QX50')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('QX60', () {
                                setState(() {
                                  subSubCategory = 'QX60';
                                });
                              }, (subSubCategory == 'QX60')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('QX70', () {
                                setState(() {
                                  subSubCategory = 'QX70';
                                });
                              }, (subSubCategory == 'QX70')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('QX80', () {
                                setState(() {
                                  subSubCategory = 'QX80';
                                });
                              }, (subSubCategory == 'QX80')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'ISUZU')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('اسندر', () {
                                setState(() {
                                  subSubCategory = 'اسندر';
                                });
                              }, (subSubCategory == 'اسندر')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ديماكس', () {
                                setState(() {
                                  subSubCategory = 'ديماكس';
                                });
                              }, (subSubCategory == 'ديماكس') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('MUX', () {
                                setState(() {
                                  subSubCategory = 'MUX';
                                });
                              }, (subSubCategory == 'MUX')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'jaguar')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('XJ', () {
                                setState(() {
                                  subSubCategory = 'XJ';
                                });
                              }, (subSubCategory == 'XJ')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('X type', () {
                                setState(() {
                                  subSubCategory = 'X type';
                                });
                              }, (subSubCategory == 'X type') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('S type', () {
                                setState(() {
                                  subSubCategory = 'S type';
                                });
                              }, (subSubCategory == 'S type') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سوفيرجن', () {
                                setState(() {
                                  subSubCategory = 'سوفيرجن';
                                });
                              }, (subSubCategory == 'سوفيرجن') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ديملر', () {
                                setState(() {
                                  subSubCategory = 'ديملر';
                                });
                              }, (subSubCategory == 'ديملر')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('E pace', () {
                                setState(() {
                                  subSubCategory = 'E pace';
                                });
                              }, (subSubCategory == 'E pace') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('F pace', () {
                                setState(() {
                                  subSubCategory = 'F pace';
                                });
                              }, (subSubCategory == 'F pace') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('F type', () {
                                setState(() {
                                  subSubCategory = 'F type';
                                });
                              }, (subSubCategory == 'F type') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('I pace', () {
                                setState(() {
                                  subSubCategory = 'I pace';
                                });
                              }, (subSubCategory == 'I pace') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('XE', () {
                                setState(() {
                                  subSubCategory = 'XE';
                                });
                              }, (subSubCategory == 'XE')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('XF', () {
                                setState(() {
                                  subSubCategory = 'XF';
                                });
                              }, (subSubCategory == 'XF')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'jeep')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('شيروكي', () {
                                setState(() {
                                  subSubCategory = 'شيروكي';
                                });
                              }, (subSubCategory == 'شيروكي') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('جراند شيروكي', () {
                                setState(() {
                                  subSubCategory = 'جراند شيروكي';
                                });
                              }, (subSubCategory == 'جراند شيروكي') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('رانجلر', () {
                                setState(() {
                                  subSubCategory = 'رانجلر';
                                });
                              }, (subSubCategory == 'رانجلر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ليبرتي', () {
                                setState(() {
                                  subSubCategory = 'ليبرتي';
                                });
                              }, (subSubCategory == 'ليبرتي') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'lamborghini')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('افنتادور', () {
                                setState(() {
                                  subSubCategory = 'افنتادور';
                                });
                              }, (subSubCategory == 'افنتادور') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('اوروس', () {
                                setState(() {
                                  subSubCategory = 'اوروس';
                                });
                              }, (subSubCategory == 'اوروس')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('هوراكان', () {
                                setState(() {
                                  subSubCategory = 'هوراكان';
                                });
                              }, (subSubCategory == 'هوراكان') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'land' && selectedCategory == 'cars')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('رنج روفر', () {
                                setState(() {
                                  subSubCategory = 'رنج روفر';
                                });
                              }, (subSubCategory == 'رنج روفر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ديسكفري', () {
                                setState(() {
                                  subSubCategory = 'ديسكفري';
                                });
                              }, (subSubCategory == 'ديسكفري') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('LR2', () {
                                setState(() {
                                  subSubCategory = 'LR2';
                                });
                              }, (subSubCategory == 'LR2')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ديفندر', () {
                                setState(() {
                                  subSubCategory = 'ديفندر';
                                });
                              }, (subSubCategory == 'ديفندر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('LR3', () {
                                setState(() {
                                  subSubCategory = 'LR3';
                                });
                              }, (subSubCategory == 'LR3')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('فري لاند', () {
                                setState(() {
                                  subSubCategory = 'فري لاند';
                                });
                              }, (subSubCategory == 'فري لاند') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('LR4', () {
                                setState(() {
                                  subSubCategory = 'LR4';
                                });
                              }, (subSubCategory == 'LR4')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ايفوك', () {
                                setState(() {
                                  subSubCategory = 'ايفوك';
                                });
                              }, (subSubCategory == 'ايفوك')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('فيلار', () {
                                setState(() {
                                  subSubCategory = 'فيلار';
                                });
                              }, (subSubCategory == 'فيلار')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ديسكفري سبورت', () {
                                setState(() {
                                  subSubCategory = 'ديسكفري سبورت';
                                });
                              }, (subSubCategory == 'ديسكفري سبورت') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('رينج روفر سبورت', () {
                                setState(() {
                                  subSubCategory = 'رينج روفر سبورت';
                                });
                              }, (subSubCategory == 'رينج روفر سبورت') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'lexus')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('LS', () {
                                setState(() {
                                  subSubCategory = 'LS';
                                });
                              }, (subSubCategory == 'LS')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('LX', () {
                                setState(() {
                                  subSubCategory = 'LX';
                                });
                              }, (subSubCategory == 'LX')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ES', () {
                                setState(() {
                                  subSubCategory = 'ES';
                                });
                              }, (subSubCategory == 'ES')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GS', () {
                                setState(() {
                                  subSubCategory = 'GS';
                                });
                              }, (subSubCategory == 'GS')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('IS', () {
                                setState(() {
                                  subSubCategory = 'IS';
                                });
                              }, (subSubCategory == 'IS')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('RX', () {
                                setState(() {
                                  subSubCategory = 'RX';
                                });
                              }, (subSubCategory == 'RX')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GX', () {
                                setState(() {
                                  subSubCategory = 'GX';
                                });
                              }, (subSubCategory == 'GX')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('SC', () {
                                setState(() {
                                  subSubCategory = 'SC';
                                });
                              }, (subSubCategory == 'SC')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('NX', () {
                                setState(() {
                                  subSubCategory = 'NX';
                                });
                              }, (subSubCategory == 'NX')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('LC', () {
                                setState(() {
                                  subSubCategory = 'LC';
                                });
                              }, (subSubCategory == 'LC')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('RC', () {
                                setState(() {
                                  subSubCategory = 'RC';
                                });
                              }, (subSubCategory == 'RC')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('RCF', () {
                                setState(() {
                                  subSubCategory = 'RCF';
                                });
                              }, (subSubCategory == 'RCF')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('UX', () {
                                setState(() {
                                  subSubCategory = 'UX';
                                });
                              }, (subSubCategory == 'UX')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GSF', () {
                                setState(() {
                                  subSubCategory = 'GSF';
                                });
                              }, (subSubCategory == 'GSF')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'mazda')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('مازدا 6', () {
                                setState(() {
                                  subSubCategory = 'مازدا 6';
                                });
                              }, (subSubCategory == 'مازدا 6') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CX9', () {
                                setState(() {
                                  subSubCategory = 'CX9';
                                });
                              }, (subSubCategory == 'CX9')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('مازدا 3', () {
                                setState(() {
                                  subSubCategory = 'مازدا 3';
                                });
                              }, (subSubCategory == 'مازدا 3') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('323', () {
                                setState(() {
                                  subSubCategory = '323';
                                });
                              }, (subSubCategory == '323')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('626', () {
                                setState(() {
                                  subSubCategory = '626';
                                });
                              }, (subSubCategory == '626')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CX7', () {
                                setState(() {
                                  subSubCategory = 'CX7';
                                });
                              }, (subSubCategory == 'CX7')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('BT50', () {
                                setState(() {
                                  subSubCategory = 'BT50';
                                });
                              }, (subSubCategory == 'BT50')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('MPV', () {
                                setState(() {
                                  subSubCategory = 'MPV';
                                });
                              }, (subSubCategory == 'MPV')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CX5', () {
                                setState(() {
                                  subSubCategory = 'CX5';
                                });
                              }, (subSubCategory == 'CX5')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CX2', () {
                                setState(() {
                                  subSubCategory = 'CX2';
                                });
                              }, (subSubCategory == 'CX2')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('RX8', () {
                                setState(() {
                                  subSubCategory = 'RX8';
                                });
                              }, (subSubCategory == 'RX8')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('MX-5', () {
                                setState(() {
                                  subSubCategory = 'MX-5';
                                });
                              }, (subSubCategory == 'MX-5')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CX3', () {
                                setState(() {
                                  subSubCategory = 'CX3';
                                });
                              }, (subSubCategory == 'CX3')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('مازدا 2', () {
                                setState(() {
                                  subSubCategory = 'مازدا 2';
                                });
                              }, (subSubCategory == 'مازدا 2') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('مازدا 5', () {
                                setState(() {
                                  subSubCategory = 'مازدا 5';
                                });
                              }, (subSubCategory == 'مازدا 5') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('CX30', () {
                                setState(() {
                                  subSubCategory = 'CX30';
                                });
                              }, (subSubCategory == 'CX30')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'mercury')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('مونتنير', () {
                                setState(() {
                                  subSubCategory = 'مونتنير';
                                });
                              }, (subSubCategory == 'مونتنير') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'meserati')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('مازيراني', () {
                                setState(() {
                                  subSubCategory = 'مازيراني';
                                });
                              }, (subSubCategory == 'مازيراني') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('جران', () {
                                setState(() {
                                  subSubCategory = 'جران';
                                });
                              }, (subSubCategory == 'جران')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('جيبلي', () {
                                setState(() {
                                  subSubCategory = 'جيبلي';
                                });
                              }, (subSubCategory == 'جيبلي')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كواتربورتي', () {
                                setState(() {
                                  subSubCategory = 'كواتربورتي';
                                });
                              }, (subSubCategory == 'كواتربورتي') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ليفانتي', () {
                                setState(() {
                                  subSubCategory = 'ليفانتي';
                                });
                              }, (subSubCategory == 'ليفانتي') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'MG')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('5', () {
                                setState(() {
                                  subSubCategory = '5';
                                });
                              }, (subSubCategory == '5')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('6', () {
                                setState(() {
                                  subSubCategory = '6';
                                });
                              }, (subSubCategory == '6')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('HS', () {
                                setState(() {
                                  subSubCategory = 'HS';
                                });
                              }, (subSubCategory == 'HS')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('MG RX8', () {
                                setState(() {
                                  subSubCategory = 'MG RX8';
                                });
                              }, (subSubCategory == 'MG RX8') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('RX5', () {
                                setState(() {
                                  subSubCategory = 'RX5';
                                });
                              }, (subSubCategory == 'RX5')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ZS', () {
                                setState(() {
                                  subSubCategory = 'ZS';
                                });
                              }, (subSubCategory == 'ZS')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('T60', () {
                                setState(() {
                                  subSubCategory = 'T60';
                                });
                              }, (subSubCategory == 'T60')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'mitsubishi')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('باجيرو', () {
                                setState(() {
                                  subSubCategory = 'باجيرو';
                                });
                              }, (subSubCategory == 'باجيرو') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('لانسر', () {
                                setState(() {
                                  subSubCategory = 'لانسر';
                                });
                              }, (subSubCategory == 'لانسر')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('L200', () {
                                setState(() {
                                  subSubCategory = 'L200';
                                });
                              }, (subSubCategory == 'L200')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ناتيفا', () {
                                setState(() {
                                  subSubCategory = 'ناتيفا';
                                });
                              }, (subSubCategory == 'ناتيفا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('جالنت', () {
                                setState(() {
                                  subSubCategory = 'جالنت';
                                });
                              }, (subSubCategory == 'جالنت')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كولت', () {
                                setState(() {
                                  subSubCategory = 'كولت';
                                });
                              }, (subSubCategory == 'كولت')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ماجنا', () {
                                setState(() {
                                  subSubCategory = 'ماجنا';
                                });
                              }, (subSubCategory == 'ماجنا')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سقما', () {
                                setState(() {
                                  subSubCategory = 'سقما';
                                });
                              }, (subSubCategory == 'سقما')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ASX', () {
                                setState(() {
                                  subSubCategory = 'ASX';
                                });
                              }, (subSubCategory == 'ASX')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('اتراج', () {
                                setState(() {
                                  subSubCategory = 'اتراج';
                                });
                              }, (subSubCategory == 'اتراج')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('اكلبس كروس', () {
                                setState(() {
                                  subSubCategory = 'اكلبس كروس';
                                });
                              }, (subSubCategory == 'اكلبس كروس') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('اوتلاندر', () {
                                setState(() {
                                  subSubCategory = 'اوتلاندر';
                                });
                              }, (subSubCategory == 'اوتلاندر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سبيس ستار', () {
                                setState(() {
                                  subSubCategory = 'سبيس ستار';
                                });
                              }, (subSubCategory == 'سبيس ستار') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('مونتيرو', () {
                                setState(() {
                                  subSubCategory = 'مونتيرو';
                                });
                              }, (subSubCategory == 'مونتيرو') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'opal')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('استرا', () {
                                setState(() {
                                  subSubCategory = 'استرا';
                                });
                              }, (subSubCategory == 'استرا')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ريكورد', () {
                                setState(() {
                                  subSubCategory = 'ريكورد';
                                });
                              }, (subSubCategory == 'ريكورد') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'peugeot')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('307', () {
                                setState(() {
                                  subSubCategory = '307';
                                });
                              }, (subSubCategory == '307')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('407', () {
                                setState(() {
                                  subSubCategory = '407';
                                });
                              }, (subSubCategory == '407')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('206', () {
                                setState(() {
                                  subSubCategory = '206';
                                });
                              }, (subSubCategory == '206')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('508', () {
                                setState(() {
                                  subSubCategory = '508';
                                });
                              }, (subSubCategory == '508')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('406', () {
                                setState(() {
                                  subSubCategory = '406';
                                });
                              }, (subSubCategory == '406')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بارتنر', () {
                                setState(() {
                                  subSubCategory = 'بارتنر';
                                });
                              }, (subSubCategory == 'بارتنر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('607', () {
                                setState(() {
                                  subSubCategory = '607';
                                });
                              }, (subSubCategory == '607')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('404', () {
                                setState(() {
                                  subSubCategory = '404';
                                });
                              }, (subSubCategory == '404')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('3008', () {
                                setState(() {
                                  subSubCategory = '3008';
                                });
                              }, (subSubCategory == '3008')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('301', () {
                                setState(() {
                                  subSubCategory = '301';
                                });
                              }, (subSubCategory == '301')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('5008', () {
                                setState(() {
                                  subSubCategory = '5008';
                                });
                              }, (subSubCategory == '5008')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بوكسر', () {
                                setState(() {
                                  subSubCategory = 'بوكسر';
                                });
                              }, (subSubCategory == 'بوكسر')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('اكسبيرت', () {
                                setState(() {
                                  subSubCategory = 'اكسبيرت';
                                });
                              }, (subSubCategory == 'اكسبيرت') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'porsche')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('كايين', () {
                                setState(() {
                                  subSubCategory = 'كايين';
                                });
                              }, (subSubCategory == 'كايين')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('باناميرا', () {
                                setState(() {
                                  subSubCategory = 'باناميرا';
                                });
                              }, (subSubCategory == 'باناميرا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('911', () {
                                setState(() {
                                  subSubCategory = '911';
                                });
                              }, (subSubCategory == '911')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كاريرا', () {
                                setState(() {
                                  subSubCategory = 'كاريرا';
                                });
                              }, (subSubCategory == 'كاريرا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كايمن', () {
                                setState(() {
                                  subSubCategory = 'كايمن';
                                });
                              }, (subSubCategory == 'كايمن')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بوكستر', () {
                                setState(() {
                                  subSubCategory = 'بوكستر';
                                });
                              }, (subSubCategory == 'بوكستر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('توربو', () {
                                setState(() {
                                  subSubCategory = 'توربو';
                                });
                              }, (subSubCategory == 'توربو')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GT', () {
                                setState(() {
                                  subSubCategory = 'GT';
                                });
                              }, (subSubCategory == 'GT')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ماكان', () {
                                setState(() {
                                  subSubCategory = 'ماكان';
                                });
                              }, (subSubCategory == 'ماكان')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('718', () {
                                setState(() {
                                  subSubCategory = '718';
                                });
                              }, (subSubCategory == '718')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'proton')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('جن 2', () {
                                setState(() {
                                  subSubCategory = 'جن 2';
                                });
                              }, (subSubCategory == 'جن ')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بيرسونا', () {
                                setState(() {
                                  subSubCategory = 'بيرسونا';
                                });
                              }, (subSubCategory == 'بيرسونا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('واجا', () {
                                setState(() {
                                  subSubCategory = 'واجا';
                                });
                              }, (subSubCategory == 'واجا')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'renault')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('ميغان', () {
                                setState(() {
                                  subSubCategory = 'ميغان';
                                });
                              }, (subSubCategory == 'ميغان')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('فلوانس', () {
                                setState(() {
                                  subSubCategory = 'فلوانس';
                                });
                              }, (subSubCategory == 'فلوانس') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سافران', () {
                                setState(() {
                                  subSubCategory = 'سافران';
                                });
                              }, (subSubCategory == 'سافران') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('لاغونا', () {
                                setState(() {
                                  subSubCategory = 'لاغونا';
                                });
                              }, (subSubCategory == 'لاغونا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كليو', () {
                                setState(() {
                                  subSubCategory = 'كليو';
                                });
                              }, (subSubCategory == 'كليو')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('تاليسمان', () {
                                setState(() {
                                  subSubCategory = 'تاليسمان';
                                });
                              }, (subSubCategory == 'تاليسمان') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('داستر', () {
                                setState(() {
                                  subSubCategory = 'داستر';
                                });
                              }, (subSubCategory == 'داستر')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('دوكر فان', () {
                                setState(() {
                                  subSubCategory = 'دوكر فان';
                                });
                              }, (subSubCategory == 'دوكر فان') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سيمبول', () {
                                setState(() {
                                  subSubCategory = 'سيمبول';
                                });
                              }, (subSubCategory == 'سيمبول') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كابتشر', () {
                                setState(() {
                                  subSubCategory = 'كابتشر';
                                });
                              }, (subSubCategory == 'كابتشر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كوليوس', () {
                                setState(() {
                                  subSubCategory = 'كوليوس';
                                });
                              }, (subSubCategory == 'كوليوس') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ماستر', () {
                                setState(() {
                                  subSubCategory = 'ماستر';
                                });
                              }, (subSubCategory == 'ماستر')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('GT ميجان', () {
                                setState(() {
                                  subSubCategory = 'GT ميجان';
                                });
                              }, (subSubCategory == 'GT ميجان') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('RS ميجان', () {
                                setState(() {
                                  subSubCategory = 'RS ميجان';
                                });
                              }, (subSubCategory == 'RS ميجان') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'rollsroyce')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('فانتوم', () {
                                setState(() {
                                  subSubCategory = 'فانتوم';
                                });
                              }, (subSubCategory == 'فانتوم') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('قوست', () {
                                setState(() {
                                  subSubCategory = 'قوست';
                                });
                              }, (subSubCategory == 'قوست')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('داون', () {
                                setState(() {
                                  subSubCategory = 'داون';
                                });
                              }, (subSubCategory == 'داون')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ريث', () {
                                setState(() {
                                  subSubCategory = 'ريث';
                                });
                              }, (subSubCategory == 'ريث')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كولينان', () {
                                setState(() {
                                  subSubCategory = 'كولينان';
                                });
                              }, (subSubCategory == 'كولينان') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'skoda')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('أوكتافيا', () {
                                setState(() {
                                  subSubCategory = 'أوكتافيا';
                                });
                              }, (subSubCategory == 'أوكتافيا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('رابيد', () {
                                setState(() {
                                  subSubCategory = 'رابيد';
                                });
                              }, (subSubCategory == 'رابيد')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سوبيرب', () {
                                setState(() {
                                  subSubCategory = 'سوبيرب';
                                });
                              }, (subSubCategory == 'سوبيرب') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('فابيا', () {
                                setState(() {
                                  subSubCategory = 'فابيا';
                                });
                              }, (subSubCategory == 'فابيا')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كاروك', () {
                                setState(() {
                                  subSubCategory = 'كاروك';
                                });
                              }, (subSubCategory == 'كاروك')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كودياك', () {
                                setState(() {
                                  subSubCategory = 'كودياك';
                                });
                              }, (subSubCategory == 'كودياك') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'ssanyong')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('اكتيون', () {
                                setState(() {
                                  subSubCategory = 'اكتيون';
                                });
                              }, (subSubCategory == 'اكتيون') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('موسو', () {
                                setState(() {
                                  subSubCategory = 'موسو';
                                });
                              }, (subSubCategory == 'موسو')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('كوراندو', () {
                                setState(() {
                                  subSubCategory = 'كوراندو';
                                });
                              }, (subSubCategory == 'كوراندو') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('XLV', () {
                                setState(() {
                                  subSubCategory = 'XLV';
                                });
                              }, (subSubCategory == 'XLV')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('تيفولي', () {
                                setState(() {
                                  subSubCategory = 'تيفولي';
                                });
                              }, (subSubCategory == 'تيفولي') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ريكستون', () {
                                setState(() {
                                  subSubCategory = 'ريكستون';
                                });
                              }, (subSubCategory == 'ريكستون') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'subaru')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('ليجاسي', () {
                                setState(() {
                                  subSubCategory = 'ليجاسي';
                                });
                              }, (subSubCategory == 'ليجاسي') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('امبريزا', () {
                                setState(() {
                                  subSubCategory = 'امبريزا';
                                });
                              }, (subSubCategory == 'امبريزا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('فورستر', () {
                                setState(() {
                                  subSubCategory = 'فورستر';
                                });
                              }, (subSubCategory == 'فورستر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('اوت باك', () {
                                setState(() {
                                  subSubCategory = 'اوت باك';
                                });
                              }, (subSubCategory == 'اوت باك') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('WRX', () {
                                setState(() {
                                  subSubCategory = 'WRX';
                                });
                              }, (subSubCategory == 'WRX')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('WRX STI', () {
                                setState(() {
                                  subSubCategory = 'WRX STI';
                                });
                              }, (subSubCategory == 'WRX STI') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('XV', () {
                                setState(() {
                                  subSubCategory = 'XV';
                                });
                              }, (subSubCategory == 'XV')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'suzuki')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('فيتارا', () {
                                setState(() {
                                  subSubCategory = 'فيتارا';
                                });
                              }, (subSubCategory == 'فيتارا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ساموراي', () {
                                setState(() {
                                  subSubCategory = 'ساموراي';
                                });
                              }, (subSubCategory == 'ساموراي') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سويفت', () {
                                setState(() {
                                  subSubCategory = 'سويفت';
                                });
                              }, (subSubCategory == 'سويفت')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('جمني', () {
                                setState(() {
                                  subSubCategory = 'جمني';
                                });
                              }, (subSubCategory == 'جمني')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ليانا', () {
                                setState(() {
                                  subSubCategory = 'ليانا';
                                });
                              }, (subSubCategory == 'ليانا')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('SX4', () {
                                setState(() {
                                  subSubCategory = 'SX4';
                                });
                              }, (subSubCategory == 'SX4')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ارتيجا', () {
                                setState(() {
                                  subSubCategory = 'ارتيجا';
                                });
                              }, (subSubCategory == 'ارتيجا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بالينو', () {
                                setState(() {
                                  subSubCategory = 'بالينو';
                                });
                              }, (subSubCategory == 'بالينو') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('جراند فيتارا', () {
                                setState(() {
                                  subSubCategory = 'جراند فيتارا';
                                });
                              }, (subSubCategory == 'جراند فيتارا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سياز', () {
                                setState(() {
                                  subSubCategory = 'سياز';
                                });
                              }, (subSubCategory == 'سياز')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سيليريو', () {
                                setState(() {
                                  subSubCategory = 'سيليريو';
                                });
                              }, (subSubCategory == 'سيليريو') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('APV بيك اب', () {
                                setState(() {
                                  subSubCategory = 'APV بيك اب';
                                });
                              }, (subSubCategory == 'APV بيك اب') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('APV فان', () {
                                setState(() {
                                  subSubCategory = 'APV فان';
                                });
                              }, (subSubCategory == 'APV فان') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ديزاير', () {
                                setState(() {
                                  subSubCategory = 'ديزاير';
                                });
                              }, (subSubCategory == 'ديزاير') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'volkswagen')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('فيتارا', () {
                                setState(() {
                                  subSubCategory = 'فيتارا';
                                });
                              }, (subSubCategory == 'فيتارا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ساموراي', () {
                                setState(() {
                                  subSubCategory = 'ساموراي';
                                });
                              }, (subSubCategory == 'ساموراي') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سويفت', () {
                                setState(() {
                                  subSubCategory = 'سويفت';
                                });
                              }, (subSubCategory == 'سويفت')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('جمني', () {
                                setState(() {
                                  subSubCategory = 'جمني';
                                });
                              }, (subSubCategory == 'جمني')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ليانا', () {
                                setState(() {
                                  subSubCategory = 'ليانا';
                                });
                              }, (subSubCategory == 'ليانا')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('SX4', () {
                                setState(() {
                                  subSubCategory = 'SX4';
                                });
                              }, (subSubCategory == 'SX4')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ارتيجا', () {
                                setState(() {
                                  subSubCategory = 'ارتيجا';
                                });
                              }, (subSubCategory == 'ارتيجا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('بالينو', () {
                                setState(() {
                                  subSubCategory = 'بالينو';
                                });
                              }, (subSubCategory == 'بالينو') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('جراند فيتارا', () {
                                setState(() {
                                  subSubCategory = 'جراند فيتارا';
                                });
                              }, (subSubCategory == 'جراند فيتارا') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سياز', () {
                                setState(() {
                                  subSubCategory = 'سياز';
                                });
                              }, (subSubCategory == 'سياز')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('سيليريو', () {
                                setState(() {
                                  subSubCategory = 'سيليريو';
                                });
                              }, (subSubCategory == 'سيليريو') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('APV بيك اب', () {
                                setState(() {
                                  subSubCategory = 'APV بيك اب';
                                });
                              }, (subSubCategory == 'APV بيك اب') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('APV فان', () {
                                setState(() {
                                  subSubCategory = 'APV فان';
                                });
                              }, (subSubCategory == 'APV فان') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('ديزاير', () {
                                setState(() {
                                  subSubCategory = 'ديزاير';
                                });
                              }, (subSubCategory == 'ديزاير') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'volvo')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('S 80', () {
                                setState(() {
                                  subSubCategory = 'S 80';
                                });
                              }, (subSubCategory == 'S 80')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('850', () {
                                setState(() {
                                  subSubCategory = '850';
                                });
                              }, (subSubCategory == '850')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('XC90', () {
                                setState(() {
                                  subSubCategory = 'XC90';
                                });
                              }, (subSubCategory == 'XC90')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('S 60R', () {
                                setState(() {
                                  subSubCategory = 'S 60R';
                                });
                              }, (subSubCategory == 'S 60R')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('S 40', () {
                                setState(() {
                                  subSubCategory = 'S 40';
                                });
                              }, (subSubCategory == 'S 40')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('960', () {
                                setState(() {
                                  subSubCategory = '960';
                                });
                              }, (subSubCategory == '960')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('S 70', () {
                                setState(() {
                                  subSubCategory = 'S 70';
                                });
                              }, (subSubCategory == 'S 70')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('V 70XC', () {
                                setState(() {
                                  subSubCategory = 'V 70XC';
                                });
                              }, (subSubCategory == 'V 70XC') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('C 70', () {
                                setState(() {
                                  subSubCategory = 'C 70';
                                });
                              }, (subSubCategory == 'C 70')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('S60', () {
                                setState(() {
                                  subSubCategory = 'S60';
                                });
                              }, (subSubCategory == 'S60')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('S90', () {
                                setState(() {
                                  subSubCategory = 'S90';
                                });
                              }, (subSubCategory == 'S90')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('XC40', () {
                                setState(() {
                                  subSubCategory = 'XC40';
                                });
                              }, (subSubCategory == 'XC40')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('XC60', () {
                                setState(() {
                                  subSubCategory = 'XC60';
                                });
                              }, (subSubCategory == 'XC60')
                                  ? Color(0xFF2980b9)
                                  : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : (subCategory == 'ZXauto')
                        ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              textCategories('ادميرال', () {
                                setState(() {
                                  subSubCategory = 'ادميرال';
                                });
                              }, (subSubCategory == 'ادميرال') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                              textCategories('جرامد تايجر', () {
                                setState(() {
                                  subSubCategory = 'جرامد تايجر';
                                });
                              }, (subSubCategory == 'جرامد تايجر') ? Color(
                                  0xFF2980b9) : Colors.transparent),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          )),
                    )
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),

                    // isStrechedDropDownRiyadh
                    // isStrechedDropDownShurqia
                    // isStrechedDropDownMekkah
                    // isStrechedDropDownMeddinah

                    // isStrechedDropDownTabuk
                    // isStrechedDropDownQassim
                    // isStrechedDropDownHail
                    // isStrechedDropDownAseer
                    // isStrechedDropDownNajran
                    // isStrechedDropDownJowf
                    // isStrechedDropDownArar
                    // isStrechedDropDown


                    Container(
                      height: 60,
                      child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF2980b9)),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(27))),
                              child: Container(
                                // height: 45,
                                  width: 170,
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  decoration: BoxDecoration(
                                      border:
                                      Border.all(color: Color(0xFF2980b9)),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(27))),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Text(
                                          title,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontFamily: 'Bahij',
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            _optionsCountryFilter(context);
                                          },
                                          child: Icon(
                                            Icons.arrow_downward,
                                            color: Color(0xFF2980b9),
                                          ))
                                    ],
                                  )),
                            ),
                          ),
                          (country == 'الرياض' ||
                              country == 'الشرقيه' ||
                              country == 'مكه' ||
                              country == 'المدينة' ||
                              country == 'تبوك' ||
                              country == 'القصيم' ||
                              country == 'حائل' ||
                              country == 'عسير' ||
                              country == 'نجران' ||
                              country == 'الجوف' ||
                              country == 'عرعر')
                              ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xFF2980b9)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(27))),
                                child: Container(
                                  // height: 45,
                                    width: 170,
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Color(0xFF2980b9)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(27))),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10),
                                          child: Text(
                                            (country == 'الرياض')
                                                ? titleRiyadh
                                                : (country == 'الشرقيه')
                                                ? titleShurqia
                                                : (country == 'مكه')
                                                ? titleMeddinah
                                                : (country ==
                                                'المدينة')
                                                ? titleMeddinah
                                                : (country ==
                                                'تبوك')
                                                ? titleTabuk
                                                : (country ==
                                                'القصيم')
                                                ? titleQassim
                                                : (country ==
                                                'حائل')
                                                ? titleHail
                                                : (country == 'عسير')
                                                ? titleAseer
                                                : (country == 'نجران')
                                                ? titleNajran
                                                : (country == 'الجوف')
                                                ? titleJowf
                                                : (country == 'عرعر')
                                                ? titleArar
                                                : '',
                                            style: TextStyle(
                                                fontFamily: 'Bahij',
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              switch (country) {
                                                case 'الرياض':
                                                  _optionsRiyadhCountryFilter(
                                                      context);
                                                  break;
                                                case 'الشرقيه':
                                                  _optionsShurqiaCountryFilter(
                                                      context);
                                                  break;
                                                case 'مكه':
                                                  _optionsMekkahCountryFilter(
                                                      context);
                                                  break;
                                                case 'المدينة':
                                                  _optionsMeddinahCountryFilter(
                                                      context);
                                                  break;
                                                case 'تبوك':
                                                  _optionsTabukCountryFilter(
                                                      context);
                                                  break;
                                                case 'القصيم':
                                                  _optionsQassimCountryFilter(
                                                      context);
                                                  break;
                                                case 'حائل':
                                                  _optionsHailCountryFilter(
                                                      context);
                                                  break;
                                                case 'عسير':
                                                  _optionsAseerCountryFilter(
                                                      context);
                                                  break;
                                                case 'نجران':
                                                  _optionsNajranCountryFilter(
                                                      context);
                                                  break;
                                                case 'الجوف':
                                                  _optionsJowfCountryFilter(
                                                      context);
                                                  break;
                                                case 'عرعر':
                                                  _optionsArarCountryFilter(
                                                      context);
                                                  break;
                                                default:
                                              }
                                            },
                                            child: Icon(
                                                Icons.arrow_downward,
                                                color: Color(0xFF2980b9)))
                                      ],
                                    )),
                              ),
                            ),
                          )
                              : Container(),
                          (subSubCategory != 'null')
                              ? Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xFF2980b9)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(27))),
                                child: Container(
                                  // height: 45,
                                    width: 170,
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFF2980b9)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10),
                                          child: Text(
                                            titleModel,
                                            style: TextStyle(
                                                fontFamily: 'Bahij',
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              _optionsModelFilter(context);
                                            },
                                            child: Icon(
                                              Icons.arrow_downward,
                                              color: Color(0xFF2980b9),
                                            ))
                                      ],
                                    )),
                              ),
                            ),
                          )
                              : Container(),
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: 50,
                            child: textCategories("كل الاعلانات", () {
                              setState(() {
                                photoBool = 'all';
                              });
                            },
                                (photoBool == 'all')
                                    ? Color(0xFF2980b9)
                                    : Colors.transparent),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: 50,
                            child: textCategories("اعلانات بدون صور", () {
                              setState(() {
                                photoBool = 'false';
                              });
                            },
                                (photoBool == 'false')
                                    ? Color(0xFF2980b9)
                                    : Colors.transparent),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: 50,
                            child: textCategories("اعلانات بصور", () {
                              setState(() {
                                photoBool = 'true';
                              });
                            },
                                (photoBool == 'true')
                                    ? Color(0xFF2980b9)
                                    : Colors.transparent),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column(
                //   children: [
                //     StreamBuilder<DocumentSnapshot>(
                //       stream: loadBanners(),
                //       builder: (context, snapshot) {
                //         if (snapshot.hasData) {
                //           String banner = snapshot.data.data()['ads 3'];
                //           return Padding(
                //             padding: const EdgeInsets.only(left: 20),
                //             child: Container(
                //               width: 300,
                //               height: 600,
                //               child: StreamBuilder<Uri>(
                //                 stream: downloadUrl(banner).asStream(),
                //                 builder: (context, snapshot) {
                //                   if (snapshot.connectionState ==
                //                       ConnectionState.waiting)
                //                     return Center(
                //                       child: CircularProgressIndicator(),
                //                     );
                //                   return Image.network(
                //                     snapshot.data.toString(),
                //                     fit: BoxFit.fill,
                //                   );
                //                 },
                //               ),
                //             ),
                //           );
                //         } else {
                //           return Center(
                //             child: CircularProgressIndicator(),
                //           );
                //         }
                //       },
                //     ),
                //     SizedBox(
                //       height: 50,
                //     ),
                //     StreamBuilder<DocumentSnapshot>(
                //       stream: loadBanners(),
                //       builder: (context, snapshot) {
                //         if (snapshot.hasData) {
                //           String banner = snapshot.data.data()['ads 4'];
                //           return Padding(
                //             padding: const EdgeInsets.only(left: 20),
                //             child: Container(
                //               width: 300,
                //               height: 600,
                //               child: StreamBuilder<Uri>(
                //                 stream: downloadUrl(banner).asStream(),
                //                 builder: (context, snapshot) {
                //                   if (snapshot.connectionState ==
                //                       ConnectionState.waiting)
                //                     return Center(
                //                       child: CircularProgressIndicator(),
                //                     );
                //                   return Image.network(
                //                     snapshot.data.toString(),
                //                     fit: BoxFit.fill,
                //                   );
                //                 },
                //               ),
                //             ),
                //           );
                //         } else {
                //           return Center(
                //             child: CircularProgressIndicator(),
                //           );
                //         }
                //       },
                //     ),
                //   ],
                // ),
                StreamBuilder<QuerySnapshot>(
                  stream: loadAds(),
                  builder: (context, snapshot) {

                    if (!snapshot.hasData || snapshot.data.docs.length == 0) {
                      return Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Container(child: Text(
                            "لاتوجد اعلانات فالوقت الحالي")),
                      );
                    } else {
                      List<AdDisplayInfo> ads = [];

                      for (var doc in snapshot.data.docs) {
                        final Timestamp timestamp =
                        doc.data()['date'] as Timestamp;
                        final DateTime dateTime = timestamp.toDate();

                        ads.add(AdDisplayInfo(
                            title: doc.data()['Title'],
                            country: doc.data()['Country'],
                            subCountry: doc.data()['subCountry'],
                            photoBool: doc.data()['photoBool'],
                            subCategory: doc.data()['subCategory'],
                            subSubCategory: doc.data()['subSubCategory'],
                            model: doc.data()['model'],
                            username: doc.data()['userName'],
                            communication:doc.data()['Communication'] ,
                            commission:doc.data()['Commission'] ,
                            membership:doc.data()['Membership'] ,
                            docId: doc.id,
                            photoPath: (doc.data()['photoBool'] == 'true')
                                ? doc.data()['photo_url 0']
                                : '',
                            selectedCategory: doc.data()['selectedCategory'],
                            dateDays:
                            DateTime
                                .now()
                                .difference(dateTime)
                                .inDays,
                            dateHours:
                            DateTime
                                .now()
                                .difference(dateTime)
                                .inHours,
                            dateMins:
                            DateTime
                                .now()
                                .difference(dateTime)
                                .inMinutes));
                      }

                      List<AdDisplayInfo> sorted = (selectedCategory != 'all')
                          ? (subCategory == 'null')
                          ? (photoBool != 'all')
                          ? ads
                          .where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.photoBool == photoBool)
                          .toList()
                          : ads
                          .where((e) =>
                      e.selectedCategory ==
                          selectedCategory)
                          .toList()
                          : (country == 'كل المناطق')
                          ? (photoBool != 'all')
                          ? (subSubCategory == 'null')
                          ? ads
                          .where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory ==
                              subCategory &&
                          e.photoBool == photoBool)
                          .toList()
                          : (model == 'null' ||
                          model == 'كل الموديلات')
                          ? ads
                          .where((e) =>
                      e.selectedCategory ==
                          selectedCategory &&
                          e.subCategory ==
                              subCategory &&
                          e.photoBool ==
                              photoBool &&
                          e.subSubCategory ==
                              subSubCategory)
                          .toList()
                          : ads
                          .where((e) =>
                      e.selectedCategory ==
                          selectedCategory &&
                          e.subCategory ==
                              subCategory &&
                          e.photoBool ==
                              photoBool &&
                          e.subSubCategory ==
                              subSubCategory &&
                          e.model == model)
                          .toList()
                          : (subSubCategory == 'null')
                          ? ads
                          .where((e) =>
                      e.selectedCategory ==
                          selectedCategory &&
                          e.subCategory == subCategory)
                          .toList()
                          : (model == 'null')
                          ? ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory &&
                          e.subSubCategory == subSubCategory).toList()
                          : ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory &&
                          e.subSubCategory == subSubCategory &&
                          e.model == model).toList()
                          : (photoBool != 'all')
                          ? (subCountry == 'الكل')
                          ? (subSubCategory == 'null')
                          ? ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory &&
                          e.country == country && e.photoBool == photoBool)
                          .toList()
                          : (model == 'null' || model == 'كل الموديلات')
                          ? ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory &&
                          e.country == country && e.photoBool == photoBool &&
                          e.subSubCategory == subSubCategory).toList()
                          : ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory &&
                          e.country == country && e.photoBool == photoBool &&
                          e.subSubCategory == subSubCategory &&
                          e.model == model).toList()
                          : (subSubCategory == 'null')
                          ? ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory &&
                          e.country == country && e.photoBool == photoBool &&
                          e.subCountry == subCountry).toList()
                          : (model == 'null' || model == 'كل الموديلات')
                          ? ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory &&
                          e.country == country && e.photoBool == photoBool &&
                          e.subCountry == subCountry &&
                          e.subSubCategory == subSubCategory).toList()
                          : ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory &&
                          e.country == country && e.photoBool == photoBool &&
                          e.subCountry == subCountry &&
                          e.subSubCategory == subSubCategory &&
                          e.model == model).toList()
                          : (subCountry == 'الكل')
                          ? (subSubCategory == 'null')
                          ? ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory && e.country == country)
                          .toList()
                          : (model == 'null' || model == 'كل الموديلات')
                          ? ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory &&
                          e.country == country &&
                          e.subSubCategory == subSubCategory).toList()
                          : ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory &&
                          e.country == country &&
                          e.subSubCategory == subSubCategory &&
                          e.model == model).toList()
                          : (subSubCategory == 'null')
                          ? ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory &&
                          e.country == country && e.subCountry == subCountry)
                          .toList()
                          : (model == 'null' || model == 'كل الموديلات')
                          ? ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory &&
                          e.country == country && e.subCountry == subCountry &&
                          e.subSubCategory == subSubCategory).toList()
                          : ads.where((e) =>
                      e.selectedCategory == selectedCategory &&
                          e.subCategory == subCategory &&
                          e.country == country && e.subCountry == subCountry &&
                          e.subSubCategory == subSubCategory &&
                          e.model == model).toList()
                          : (country == 'كل المناطق')
                          ? (photoBool == 'all')
                          ? ads
                          : ads.where((e) => e.photoBool == photoBool).toList()
                          : (photoBool == 'all')
                          ? (subCountry == 'الكل')
                          ? ads.where((e) => e.country == country).toList()
                          : ads.where((e) =>


                      e.country == country && e.subCountry == subCountry).toList() : (subCountry == 'الكل') ? ads.where((e) => e.country == country && e.photoBool == photoBool).toList() : ads.where((e) => e.country == country && e.photoBool == photoBool && e.subCountry == subCountry).toList();


                      List<AdDisplayInfo> search = (query != '') ? ads.where((element) =>
                          element.title.toLowerCase().contains(query.toLowerCase()))
                          .toList()
                          : sorted;


                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: SizedBox(
                          child: Padding(
                            padding:  EdgeInsets.only(left: 20, right: 20, ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints.expand(
                                height:MediaQuery.of(context).size.height*2.2,
                                width: MediaQuery.of(context).size.width / 1.5,

                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(parent: ClampingScrollPhysics()),
                                itemCount:
                                (query != '') ? search.length : sorted.length,
                                shrinkWrap: true,
                                //reverse: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 25),
                                    child: TextButton(
                                        onPressed: () {
                                          locator<NavigationService>()
                                              .navigateTo(
                                              AdDetailsRoute,
                                              queryParams: {
                                                'id': (query != '') ? search[index].docId : sorted[index].docId,
                                              });
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFF2980b9),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width *0.32,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          (query != '')
                                                              ? search[index].title
                                                              : sorted[index].title,
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                              fontFamily: 'Bahij',
                                                              fontSize: 25,
                                                              color: Colors.white,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                (query != '') ? search[index].username :
                                                                sorted[index].username,
                                                                style: TextStyle(
                                                                  fontFamily: 'Bahij',
                                                                  fontSize: 20,
                                                                  color: Colors.white,
                                                                ),
                                                              ),

                                                              Visibility(
                                                                visible: (query != ''),
                                                                child:(search[index].commission.toString() == 'Paid')? Container(
                                                                  margin: EdgeInsets.only(right: 5),
                                                                  child: Row(
                                                                    children: [
                                                                      Image.asset(
                                                                        'assets/images/icons/feature.png',
                                                                        height: 15,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ): Container(),
                                                                replacement: (sorted[index].commission.toString() == 'Paid')? Container(
                                                                  margin: EdgeInsets.only(right: 5),
                                                                  child: Row(
                                                                    children: [
                                                                      Image.asset(
                                                                        'assets/images/icons/feature.png',
                                                                        height: 15,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ): Container(),
                                                              ),

                                                            ],
                                                          ),
                                                          /// star islam
                                                          // (commission == 'Paid')
                                                          //     ? Row(
                                                          //   children: [
                                                          //     Text(
                                                          //       "دفع العمولة",
                                                          //       style: TextStyle(
                                                          //           fontFamily: 'Bahij',
                                                          //           fontSize: 25,
                                                          //           color: Colors.black,
                                                          //           fontWeight:
                                                          //           FontWeight.bold),
                                                          //     ),
                                                          //     SizedBox(
                                                          //       width: 5,
                                                          //     ),
                                                          //     Image.asset(
                                                          //       'assets/images/icons/invoice.png',
                                                          //       height: 35,
                                                          //     ),
                                                          //   ],
                                                          // )
                                                          //     : Container(),

                                                        ],
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
                                                            ( (query != '') ? search[index].country : sorted[index].country)=="All"?"كل المناطق": ( (query != '') ? search[index].country : sorted[index].country),
                                                            style: TextStyle(
                                                              fontFamily: 'Bahij',
                                                              fontSize: 25,
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
                                                            (query != '')
                                                                ? (sorted[index]
                                                                .dateDays !=
                                                                0)
                                                                ? "قبل ${search[index]
                                                                .dateDays} ايام"
                                                                : (sorted[index]
                                                                .dateHours !=
                                                                0)
                                                                ? "قبل ${search[index]
                                                                .dateHours} ساعات"
                                                                : "قبل ${search[index]
                                                                .dateMins} دقائق"
                                                                : (sorted[index]
                                                                .dateDays !=
                                                                0)
                                                                ? "قبل ${sorted[index]
                                                                .dateDays} ايام"
                                                                : (sorted[index]
                                                                .dateHours !=
                                                                0)
                                                                ? "قبل ${sorted[index]
                                                                .dateHours} ساعات"
                                                                : "قبل ${sorted[index]
                                                                .dateMins} دقائق",
                                                            style: TextStyle(
                                                              fontFamily: 'Bahij',
                                                              fontSize: 25,
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),

                                                Row(
                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(bottom: 10),
                                                      alignment: Alignment.centerRight,
                                                      child: ((query != '')
                                                          ? search[index]
                                                          .photoBool ==
                                                          'true'
                                                          : sorted[index]
                                                          .photoBool ==
                                                          'true')
                                                          ? FutureBuilder<Uri>(
                                                        future: downloadUrl(
                                                            (query != '')
                                                                ? search[index]
                                                                .photoPath
                                                                : sorted[index]
                                                                .photoPath),
                                                        builder:
                                                            (context, snapshot) {
                                                          if (snapshot
                                                              .connectionState ==
                                                              ConnectionState
                                                                  .waiting)
                                                            return Center(
                                                              child:
                                                              CircularProgressIndicator(),
                                                            );
                                                          return ClipRRect(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                8.0),
                                                            child: Image.network(
                                                              snapshot.data
                                                                  .toString(),
                                                              width: MediaQuery.of(context).size.width *0.17,
                                                              height: MediaQuery.of(context).size.width *0.1,
                                                              alignment: Alignment.centerRight,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          );
                                                        },
                                                      )
                                                          : ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                        child: Image.asset(
                                                          'assets/images/no_image.png',
                                                          width: MediaQuery.of(context).size.width *0.17,
                                                          height: MediaQuery.of(context).size.width *0.1,
                                                          alignment: Alignment.centerRight,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ))).mouseUpOnHover,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                      );
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50,

            ),
            Container(
              height: 10,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
                          child: Image
                              .asset(
                            'assets/images/icons/googleplay.png',
                            height: 100,
                            width: 150,
                          )
                              .mouseUpOnHover
                              .showCursorOnHover,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            launch(appstore);
                          },
                          child: Image
                              .asset(
                            'assets/images/icons/appstore.png',
                            height: 100,
                            width: 150,
                          )
                              .mouseUpOnHover
                              .showCursorOnHover,
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
            // SizedBox(
            //   height: 15,
            // ),
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

    if (phoneNo != null) {
      var doc = await _firestore.collection('users').doc(phoneNo).get();
      if (!doc.exists) {
        savePhoneNumber(null);
        saveLogin(false);
        setState(() {
          phoneNo = null;
        });
      }
    }
  }

  void _optionsRiyadhCountryFilter(context) {
    ScrollController list1 = ScrollController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اختر المدينة',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bahij",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff818181),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 2) - 134,
                  child: VsScrollbar(
                    controller: list1,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0, // default 12.0
                      radius:
                      Radius.circular(10), // default Radius.circular(8.0)
                      thickness: 10.0, // [ default 8.0 ]
                      color: Color(0xFF2980b9), // default ColorScheme Theme
                    ),
                    child: ListView.builder(
                        controller: list1,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: _riyadhList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              activeColor: Color(0xFF2980b9),
                              title: Text(_riyadhList.elementAt(index),
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: index,
                              groupValue: groupValueRiyadh,
                              onChanged: (val) {
                                setState(() {
                                  subCountry = _riyadhList.elementAt(index);
                                  groupValueRiyadh = val;
                                  titleRiyadh = _riyadhList.elementAt(index);
                                });
                                Navigator.pop(context);
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _optionsShurqiaCountryFilter(context) {
    ScrollController list1 = ScrollController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اختر المدينة',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bahij",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff818181),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 2) - 134,
                  child: VsScrollbar(
                    controller: list1,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0, // default 12.0
                      radius:
                      Radius.circular(10), // default Radius.circular(8.0)
                      thickness: 10.0, // [ default 8.0 ]
                      color: Color(0xFF2980b9), // default ColorScheme Theme
                    ),
                    child: ListView.builder(
                        controller: list1,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: _shurqiaList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              activeColor: Color(0xFF2980b9),
                              title: Text(_shurqiaList.elementAt(index),
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: index,
                              groupValue: groupValueShurqia,
                              onChanged: (val) {
                                setState(() {
                                  subCountry = _shurqiaList.elementAt(index);
                                  groupValueShurqia = val;
                                  titleShurqia = _shurqiaList.elementAt(index);
                                });
                                Navigator.pop(context);
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _optionsMeddinahCountryFilter(context) {
    ScrollController list1 = ScrollController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اختر المدينة',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bahij",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff818181),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 2) - 134,
                  child: VsScrollbar(
                    controller: list1,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0, // default 12.0
                      radius:
                      Radius.circular(10), // default Radius.circular(8.0)
                      thickness: 10.0, // [ default 8.0 ]
                      color: Color(0xFF2980b9), // default ColorScheme Theme
                    ),
                    child: ListView.builder(
                        controller: list1,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: _meddinahList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              activeColor: Color(0xFF2980b9),
                              title: Text(_meddinahList.elementAt(index),
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: index,
                              groupValue: groupValueMeddinah,
                              onChanged: (val) {
                                setState(() {
                                  subCountry = _meddinahList.elementAt(index);
                                  groupValueMeddinah = val;
                                  titleMeddinah =
                                      _meddinahList.elementAt(index);
                                });
                                Navigator.pop(context);
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _optionsMekkahCountryFilter(context) {
    ScrollController list1 = ScrollController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اختر المدينة',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bahij",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff818181),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 2) - 134,
                  child: VsScrollbar(
                    controller: list1,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0, // default 12.0
                      radius:
                      Radius.circular(10), // default Radius.circular(8.0)
                      thickness: 10.0, // [ default 8.0 ]
                      color: Color(0xFF2980b9), // default ColorScheme Theme
                    ),
                    child: ListView.builder(
                        controller: list1,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: _mekkahList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              activeColor: Color(0xFF2980b9),
                              title: Text(_mekkahList.elementAt(index),
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: index,
                              groupValue: groupValueMekkah,
                              onChanged: (val) {
                                setState(() {
                                  subCountry = _mekkahList.elementAt(index);
                                  groupValueMekkah = val;
                                  titleMekkah = _mekkahList.elementAt(index);
                                });
                                Navigator.pop(context);
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _optionsTabukCountryFilter(context) {
    ScrollController list1 = ScrollController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اختر المدينة',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bahij",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff818181),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 2) - 134,
                  child: VsScrollbar(
                    controller: list1,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0, // default 12.0
                      radius:
                      Radius.circular(10), // default Radius.circular(8.0)
                      thickness: 10.0, // [ default 8.0 ]
                      color: Color(0xFF2980b9), // default ColorScheme Theme
                    ),
                    child: ListView.builder(
                        controller: list1,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: _tabukList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              activeColor: Color(0xFF2980b9),
                              title: Text(_tabukList.elementAt(index),
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: index,
                              groupValue: groupValueTabuk,
                              onChanged: (val) {
                                setState(() {
                                  subCountry = _tabukList.elementAt(index);
                                  groupValueTabuk = val;
                                  titleTabuk = _tabukList.elementAt(index);
                                });
                                Navigator.pop(context);
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _optionsQassimCountryFilter(context) {
    ScrollController list1 = ScrollController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اختر المدينة',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bahij",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff818181),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 2) - 134,
                  child: VsScrollbar(
                    controller: list1,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0, // default 12.0
                      radius:
                      Radius.circular(10), // default Radius.circular(8.0)
                      thickness: 10.0, // [ default 8.0 ]
                      color: Color(0xFF2980b9), // default ColorScheme Theme
                    ),
                    child: ListView.builder(
                        controller: list1,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: _qassimList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              activeColor: Color(0xFF2980b9),
                              title: Text(_qassimList.elementAt(index),
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: index,
                              groupValue: groupValueQassim,
                              onChanged: (val) {
                                setState(() {
                                  subCountry = _qassimList.elementAt(index);
                                  groupValueQassim = val;
                                  titleQassim = _qassimList.elementAt(index);
                                });
                                Navigator.pop(context);
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _optionsHailCountryFilter(context) {
    ScrollController list1 = ScrollController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اختر المدينة',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bahij",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff818181),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 2) - 134,
                  child: VsScrollbar(
                    controller: list1,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0, // default 12.0
                      radius:
                      Radius.circular(10), // default Radius.circular(8.0)
                      thickness: 10.0, // [ default 8.0 ]
                      color: Color(0xFF2980b9), // default ColorScheme Theme
                    ),
                    child: ListView.builder(
                        controller: list1,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: _hailList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              activeColor: Color(0xFF2980b9),
                              title: Text(_hailList.elementAt(index),
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: index,
                              groupValue: groupValueHail,
                              onChanged: (val) {
                                setState(() {
                                  subCountry = _hailList.elementAt(index);
                                  groupValueHail = val;
                                  titleHail = _hailList.elementAt(index);
                                });
                                Navigator.pop(context);
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _optionsAseerCountryFilter(context) {
    ScrollController list1 = ScrollController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اختر المدينة',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bahij",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff818181),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 2) - 134,
                  child: VsScrollbar(
                    controller: list1,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0, // default 12.0
                      radius:
                      Radius.circular(10), // default Radius.circular(8.0)
                      thickness: 10.0, // [ default 8.0 ]
                      color: Color(0xFF2980b9), // default ColorScheme Theme
                    ),
                    child: ListView.builder(
                        controller: list1,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: _aseerList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              activeColor: Color(0xFF2980b9),
                              title: Text(_aseerList.elementAt(index),
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: index,
                              groupValue: groupValueAseer,
                              onChanged: (val) {
                                setState(() {
                                  subCountry = _aseerList.elementAt(index);
                                  groupValueAseer = val;
                                  titleAseer = _aseerList.elementAt(index);
                                });
                                Navigator.pop(context);
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _optionsNajranCountryFilter(context) {
    ScrollController list1 = ScrollController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اختر المدينة',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bahij",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff818181),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 2) - 134,
                  child: VsScrollbar(
                    controller: list1,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0, // default 12.0
                      radius:
                      Radius.circular(10), // default Radius.circular(8.0)
                      thickness: 10.0, // [ default 8.0 ]
                      color: Color(0xFF2980b9), // default ColorScheme Theme
                    ),
                    child: ListView.builder(
                        controller: list1,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: _najranList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              activeColor: Color(0xFF2980b9),
                              title: Text(_najranList.elementAt(index),
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: index,
                              groupValue: groupValueNajran,
                              onChanged: (val) {
                                setState(() {
                                  subCountry = _najranList.elementAt(index);
                                  groupValueNajran = val;
                                  titleNajran = _najranList.elementAt(index);
                                });
                                Navigator.pop(context);
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _optionsJowfCountryFilter(context) {
    ScrollController list1 = ScrollController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اختر المدينة',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bahij",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff818181),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 2) - 134,
                  child: VsScrollbar(
                    controller: list1,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0, // default 12.0
                      radius:
                      Radius.circular(10), // default Radius.circular(8.0)
                      thickness: 10.0, // [ default 8.0 ]
                      color: Color(0xFF2980b9), // default ColorScheme Theme
                    ),
                    child: ListView.builder(
                        controller: list1,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: _jowfList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              activeColor: Color(0xFF2980b9),
                              title: Text(_jowfList.elementAt(index),
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: index,
                              groupValue: groupValueJowf,
                              onChanged: (val) {
                                setState(() {
                                  subCountry = _jowfList.elementAt(index);
                                  groupValueJowf = val;
                                  titleJowf = _jowfList.elementAt(index);
                                });
                                Navigator.pop(context);
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _optionsArarCountryFilter(context) {
    ScrollController list1 = ScrollController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اختر المدينة',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bahij",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff818181),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 2) - 134,
                  child: VsScrollbar(
                    controller: list1,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0, // default 12.0
                      radius:
                      Radius.circular(10), // default Radius.circular(8.0)
                      thickness: 10.0, // [ default 8.0 ]
                      color: Color(0xFF2980b9), // default ColorScheme Theme
                    ),
                    child: ListView.builder(
                        controller: list1,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: _ararList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              activeColor: Color(0xFF2980b9),
                              title: Text(_ararList.elementAt(index),
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: index,
                              groupValue: groupValueArar,
                              onChanged: (val) {
                                setState(() {
                                  subCountry = _ararList.elementAt(index);
                                  groupValueArar = val;
                                  titleArar = _ararList.elementAt(index);
                                });
                                Navigator.pop(context);
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _optionsCountryFilter(context) {
    ScrollController list1 = ScrollController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اختر المنطقة',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bahij",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff818181),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 2) - 134,
                  child: VsScrollbar(
                    controller: list1,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0, // default 12.0
                      radius: Radius.circular(10), // default Radius.circular(8.0)
                      thickness: 10.0, // [ default 8.0 ]
                      color: Color(0xFF2980b9), // default ColorScheme Theme
                    ),
                    child: ListView.builder(
                        controller: list1,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: _list.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              activeColor: Color(0xFF2980b9),
                              title: Text(_list.elementAt(index),
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: index,
                              groupValue: groupValue,
                              onChanged: (val) {
                                setState(() {
                                  country = _list.elementAt(index);
                                  groupValue = val;
                                  title = _list.elementAt(index);
                                });
                                Navigator.pop(context);
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _optionsModelFilter(context) {
    ScrollController list1 = ScrollController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'اختر المودل',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Bahij",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff818181),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height / 2) - 134,
                  child: VsScrollbar(
                    controller: list1,
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    style: VsScrollbarStyle(
                      hoverThickness: 10.0, // default 12.0
                      radius:
                      Radius.circular(10), // default Radius.circular(8.0)
                      thickness: 10.0, // [ default 8.0 ]
                      color: Color(0xFF2980b9), // default ColorScheme Theme
                    ),
                    child: ListView.builder(
                        controller: list1,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: _modellist.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                              activeColor: Color(0xFF2980b9),
                              title: Text(_modellist.elementAt(index),
                                  style: TextStyle(
                                      fontFamily: 'Bahij',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: index,
                              groupValue: groupValueModel,
                              onChanged: (val) {
                                setState(() {
                                  model = _modellist.elementAt(index);
                                  groupValueModel = val;
                                  titleModel = _modellist.elementAt(index);
                                });
                                Navigator.pop(context);
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
