class Countries {
  int id;
  String country;

  Countries(this.id, this.country);

  static List<Countries> getCountries() {
    return <Countries>[
      Countries(0, 'كل المناطق'),
      Countries(1, 'الرياض'),
      Countries(2, 'الشرقيه'),
      Countries(3, 'جده'),
      Countries(4, 'مكة'),
      Countries(5, 'ينبع'),
      Countries(6, 'حفر الباطن'),
      Countries(7, 'المدينة'),
      Countries(8, 'الطايف'),
      Countries(9, 'تبوك'),
      Countries(10, 'القصيم'),
      Countries(11, 'حائل'),
      Countries(12, 'أبها'),
      Countries(13, 'عسير'),
      Countries(14, 'الباحة'),
      Countries(15, 'جيزان'),
      Countries(16, 'نجران'),
      Countries(17, 'الجوف'),
      Countries(18, 'عرعر'),
    ];
  }
}
