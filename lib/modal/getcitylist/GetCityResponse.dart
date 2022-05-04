import 'dart:convert';
/// cities : [{"name":"Abu Road","id":3294},{"name":"Ajmer","id":3295},{"name":"Aklera","id":3296},{"name":"Alwar","id":3297},{"name":"Amet","id":3298},{"name":"Antah","id":3299},{"name":"Anupgarh","id":3300},{"name":"Asind","id":3301},{"name":"Bagar","id":3302},{"name":"Bagru","id":3303},{"name":"Bahror","id":3304},{"name":"Bakani","id":3305},{"name":"Bali","id":3306},{"name":"Balotra","id":3307},{"name":"Bandikui","id":3308},{"name":"Banswara","id":3309},{"name":"Baran","id":3310},{"name":"Bari","id":3311},{"name":"Bari Sadri","id":3312},{"name":"Barmer","id":3313},{"name":"Basi","id":3314},{"name":"Basni Belima","id":3315},{"name":"Baswa","id":3316},{"name":"Bayana","id":3317},{"name":"Beawar","id":3318},{"name":"Begun","id":3319},{"name":"Bhadasar","id":3320},{"name":"Bhadra","id":3321},{"name":"Bhalariya","id":3322},{"name":"Bharatpur","id":3323},{"name":"Bhasawar","id":3324},{"name":"Bhawani Mandi","id":3325},{"name":"Bhawri","id":3326},{"name":"Bhilwara","id":3327},{"name":"Bhindar","id":3328},{"name":"Bhinmal","id":3329},{"name":"Bhiwadi","id":3330},{"name":"Bijoliya Kalan","id":3331},{"name":"Bikaner","id":3332},{"name":"Bilara","id":3333},{"name":"Bissau","id":3334},{"name":"Borkhera","id":3335},{"name":"Budhpura","id":3336},{"name":"Bundi","id":3337},{"name":"Chatsu","id":3338},{"name":"Chechat","id":3339},{"name":"Chhabra","id":3340},{"name":"Chhapar","id":3341},{"name":"Chhipa Barod","id":3342},{"name":"Chhoti Sadri","id":3343},{"name":"Chirawa","id":3344},{"name":"Chittaurgarh","id":3345},{"name":"Chittorgarh","id":3346},{"name":"Chomun","id":3347},{"name":"Churu","id":3348},{"name":"Daosa","id":3349},{"name":"Dariba","id":3350},{"name":"Dausa","id":3351},{"name":"Deoli","id":3352},{"name":"Deshnok","id":3353},{"name":"Devgarh","id":3354},{"name":"Devli","id":3355},{"name":"Dhariawad","id":3356},{"name":"Dhaulpur","id":3357},{"name":"Dholpur","id":3358},{"name":"Didwana","id":3359},{"name":"Dig","id":3360},{"name":"Dungargarh","id":3361},{"name":"Dungarpur","id":3362},{"name":"Falna","id":3363},{"name":"Fatehnagar","id":3364},{"name":"Fatehpur","id":3365},{"name":"Gajsinghpur","id":3366},{"name":"Galiakot","id":3367},{"name":"Ganganagar","id":3368},{"name":"Gangapur","id":3369},{"name":"Goredi Chancha","id":3370},{"name":"Gothra","id":3371},{"name":"Govindgarh","id":3372},{"name":"Gulabpura","id":3373},{"name":"Hanumangarh","id":3374},{"name":"Hindaun","id":3375},{"name":"Indragarh","id":3376},{"name":"Jahazpur","id":3377},{"name":"Jaipur","id":3378},{"name":"Jaisalmer","id":3379},{"name":"Jaiselmer","id":3380},{"name":"Jaitaran","id":3381},{"name":"Jalore","id":3382},{"name":"Jhalawar","id":3383},{"name":"Jhalrapatan","id":3384},{"name":"Jhunjhunun","id":3385},{"name":"Jobner","id":3386},{"name":"Jodhpur","id":3387},{"name":"Kaithun","id":3388},{"name":"Kaman","id":3389},{"name":"Kankroli","id":3390},{"name":"Kanor","id":3391},{"name":"Kapasan","id":3392},{"name":"Kaprain","id":3393},{"name":"Karanpura","id":3394},{"name":"Karauli","id":3395},{"name":"Kekri","id":3396},{"name":"Keshorai Patan","id":3397},{"name":"Kesrisinghpur","id":3398},{"name":"Khairthal","id":3399},{"name":"Khandela","id":3400},{"name":"Khanpur","id":3401},{"name":"Kherli","id":3402},{"name":"Kherliganj","id":3403},{"name":"Kherwara Chhaoni","id":3404},{"name":"Khetri","id":3405},{"name":"Kiranipura","id":3406},{"name":"Kishangarh","id":3407},{"name":"Kishangarh Ranwal","id":3408},{"name":"Kolvi Rajendrapura","id":3409},{"name":"Kot Putli","id":3410},{"name":"Kota","id":3411},{"name":"Kuchaman","id":3412},{"name":"Kuchera","id":3413},{"name":"Kumbhalgarh","id":3414},{"name":"Kumbhkot","id":3415},{"name":"Kumher","id":3416},{"name":"Kushalgarh","id":3417},{"name":"Lachhmangarh","id":3418},{"name":"Ladnun","id":3419},{"name":"Lakheri","id":3420},{"name":"Lalsot","id":3421},{"name":"Losal","id":3422},{"name":"Madanganj","id":3423},{"name":"Mahu Kalan","id":3424},{"name":"Mahwa","id":3425},{"name":"Makrana","id":3426},{"name":"Malpura","id":3427},{"name":"Mandal","id":3428},{"name":"Mandalgarh","id":3429},{"name":"Mandawar","id":3430},{"name":"Mandwa","id":3431},{"name":"Mangrol","id":3432},{"name":"Manohar Thana","id":3433},{"name":"Manoharpur","id":3434},{"name":"Marwar","id":3435},{"name":"Merta","id":3436},{"name":"Modak","id":3437},{"name":"Mount Abu","id":3438},{"name":"Mukandgarh","id":3439},{"name":"Mundwa","id":3440},{"name":"Nadbai","id":3441},{"name":"Naenwa","id":3442},{"name":"Nagar","id":3443},{"name":"Nagaur","id":3444},{"name":"Napasar","id":3445},{"name":"Naraina","id":3446},{"name":"Nasirabad","id":3447},{"name":"Nathdwara","id":3448},{"name":"Nawa","id":3449},{"name":"Nawalgarh","id":3450},{"name":"Neem Ka Thana","id":3451},{"name":"Neemrana","id":3452},{"name":"Newa Talai","id":3453},{"name":"Nimaj","id":3454},{"name":"Nimbahera","id":3455},{"name":"Niwai","id":3456},{"name":"Nohar","id":3457},{"name":"Nokha","id":3458},{"name":"One SGM","id":3459},{"name":"Padampur","id":3460},{"name":"Pali","id":3461},{"name":"Partapur","id":3462},{"name":"Parvatsar","id":3463},{"name":"Pasoond","id":3464},{"name":"Phalna","id":3465},{"name":"Phalodi","id":3466},{"name":"Phulera","id":3467},{"name":"Pilani","id":3468},{"name":"Pilibanga","id":3469},{"name":"Pindwara","id":3470},{"name":"Pipalia Kalan","id":3471},{"name":"Pipar","id":3472},{"name":"Pirawa","id":3473},{"name":"Pokaran","id":3474},{"name":"Pratapgarh","id":3475},{"name":"Pushkar","id":3476},{"name":"Raipur","id":3477},{"name":"Raisinghnagar","id":3478},{"name":"Rajakhera","id":3479},{"name":"Rajaldesar","id":3480},{"name":"Rajgarh","id":3481},{"name":"Rajsamand","id":3482},{"name":"Ramganj Mandi","id":3483},{"name":"Ramgarh","id":3484},{"name":"Rani","id":3485},{"name":"Raniwara","id":3486},{"name":"Ratan Nagar","id":3487},{"name":"Ratangarh","id":3488},{"name":"Rawatbhata","id":3489},{"name":"Rawatsar","id":3490},{"name":"Rikhabdev","id":3491},{"name":"Ringas","id":3492},{"name":"Sadri","id":3493},{"name":"Sadulshahar","id":3494},{"name":"Sagwara","id":3495},{"name":"Salumbar","id":3496},{"name":"Sambhar","id":3497},{"name":"Samdari","id":3498},{"name":"Sanchor","id":3499},{"name":"Sangariya","id":3500},{"name":"Sangod","id":3501},{"name":"Sardarshahr","id":3502},{"name":"Sarwar","id":3503},{"name":"Satal Kheri","id":3504},{"name":"Sawai Madhopur","id":3505},{"name":"Sewan Kalan","id":3506},{"name":"Shahpura","id":3507},{"name":"Sheoganj","id":3508},{"name":"Sikar","id":3509},{"name":"Sirohi","id":3510},{"name":"Siwana","id":3511},{"name":"Sogariya","id":3512},{"name":"Sojat","id":3513},{"name":"Sojat Road","id":3514},{"name":"Sri Madhopur","id":3515},{"name":"Sriganganagar","id":3516},{"name":"Sujangarh","id":3517},{"name":"Suket","id":3518},{"name":"Sumerpur","id":3519},{"name":"Sunel","id":3520},{"name":"Surajgarh","id":3521},{"name":"Suratgarh","id":3522},{"name":"Swaroopganj","id":3523},{"name":"Takhatgarh","id":3524},{"name":"Taranagar","id":3525},{"name":"Three STR","id":3526},{"name":"Tijara","id":3527},{"name":"Toda Bhim","id":3528},{"name":"Toda Raisingh","id":3529},{"name":"Todra","id":3530},{"name":"Tonk","id":3531},{"name":"Udaipur","id":3532},{"name":"Udpura","id":3533},{"name":"Uniara","id":3534},{"name":"Vanasthali","id":3535},{"name":"Vidyavihar","id":3536},{"name":"Vijainagar","id":3537},{"name":"Viratnagar","id":3538},{"name":"Wer","id":3539},{"name":"Abu Road","id":45311},{"name":"Ajmer","id":45312},{"name":"Aklera","id":45313},{"name":"Alwar","id":45314},{"name":"Amet","id":45315},{"name":"Antah","id":45316},{"name":"Anupgarh","id":45317},{"name":"Asind","id":45318},{"name":"Bagar","id":45319},{"name":"Bagru","id":45320},{"name":"Bahror","id":45321},{"name":"Bakani","id":45322},{"name":"Bali","id":45323},{"name":"Balotra","id":45324},{"name":"Bandikui","id":45325},{"name":"Banswara","id":45326},{"name":"Baran","id":45327},{"name":"Bari","id":45328},{"name":"Bari Sadri","id":45329},{"name":"Barmer","id":45330},{"name":"Basi","id":45331},{"name":"Basni Belima","id":45332},{"name":"Baswa","id":45333},{"name":"Bayana","id":45334},{"name":"Beawar","id":45335},{"name":"Begun","id":45336},{"name":"Bhadasar","id":45337},{"name":"Bhadra","id":45338},{"name":"Bhalariya","id":45339},{"name":"Bharatpur","id":45340},{"name":"Bhasawar","id":45341},{"name":"Bhawani Mandi","id":45342},{"name":"Bhawri","id":45343},{"name":"Bhilwara","id":45344},{"name":"Bhindar","id":45345},{"name":"Bhinmal","id":45346},{"name":"Bhiwadi","id":45347},{"name":"Bijoliya Kalan","id":45348},{"name":"Bikaner","id":45349},{"name":"Bilara","id":45350},{"name":"Bissau","id":45351},{"name":"Borkhera","id":45352},{"name":"Budhpura","id":45353},{"name":"Bundi","id":45354},{"name":"Chatsu","id":45355},{"name":"Chechat","id":45356},{"name":"Chhabra","id":45357},{"name":"Chhapar","id":45358},{"name":"Chhipa Barod","id":45359},{"name":"Chhoti Sadri","id":45360},{"name":"Chirawa","id":45361},{"name":"Chittaurgarh","id":45362},{"name":"Chittorgarh","id":45363},{"name":"Chomun","id":45364},{"name":"Churu","id":45365},{"name":"Daosa","id":45366},{"name":"Dariba","id":45367},{"name":"Dausa","id":45368},{"name":"Deoli","id":45369},{"name":"Deshnok","id":45370},{"name":"Devgarh","id":45371},{"name":"Devli","id":45372},{"name":"Dhariawad","id":45373},{"name":"Dhaulpur","id":45374},{"name":"Dholpur","id":45375},{"name":"Didwana","id":45376},{"name":"Dig","id":45377},{"name":"Dungargarh","id":45378},{"name":"Dungarpur","id":45379},{"name":"Falna","id":45380},{"name":"Fatehnagar","id":45381},{"name":"Fatehpur","id":45382},{"name":"Gajsinghpur","id":45383},{"name":"Galiakot","id":45384},{"name":"Ganganagar","id":45385},{"name":"Gangapur","id":45386},{"name":"Goredi Chancha","id":45387},{"name":"Gothra","id":45388},{"name":"Govindgarh","id":45389},{"name":"Gulabpura","id":45390},{"name":"Hanumangarh","id":45391},{"name":"Hindaun","id":45392},{"name":"Indragarh","id":45393},{"name":"Jahazpur","id":45394},{"name":"Jaipur","id":45395},{"name":"Jaisalmer","id":45396},{"name":"Jaiselmer","id":45397},{"name":"Jaitaran","id":45398},{"name":"Jalore","id":45399},{"name":"Jhalawar","id":45400},{"name":"Jhalrapatan","id":45401},{"name":"Jhunjhunun","id":45402},{"name":"Jobner","id":45403},{"name":"Jodhpur","id":45404},{"name":"Kaithun","id":45405},{"name":"Kaman","id":45406},{"name":"Kankroli","id":45407},{"name":"Kanor","id":45408},{"name":"Kapasan","id":45409},{"name":"Kaprain","id":45410},{"name":"Karanpura","id":45411},{"name":"Karauli","id":45412},{"name":"Kekri","id":45413},{"name":"Keshorai Patan","id":45414},{"name":"Kesrisinghpur","id":45415},{"name":"Khairthal","id":45416},{"name":"Khandela","id":45417},{"name":"Khanpur","id":45418},{"name":"Kherli","id":45419},{"name":"Kherliganj","id":45420},{"name":"Kherwara Chhaoni","id":45421},{"name":"Khetri","id":45422},{"name":"Kiranipura","id":45423},{"name":"Kishangarh","id":45424},{"name":"Kishangarh Ranwal","id":45425},{"name":"Kolvi Rajendrapura","id":45426},{"name":"Kot Putli","id":45427},{"name":"Kota","id":45428},{"name":"Kuchaman","id":45429},{"name":"Kuchera","id":45430},{"name":"Kumbhalgarh","id":45431},{"name":"Kumbhkot","id":45432},{"name":"Kumher","id":45433},{"name":"Kushalgarh","id":45434},{"name":"Lachhmangarh","id":45435},{"name":"Ladnun","id":45436},{"name":"Lakheri","id":45437},{"name":"Lalsot","id":45438},{"name":"Losal","id":45439},{"name":"Madanganj","id":45440},{"name":"Mahu Kalan","id":45441},{"name":"Mahwa","id":45442},{"name":"Makrana","id":45443},{"name":"Malpura","id":45444},{"name":"Mandal","id":45445},{"name":"Mandalgarh","id":45446},{"name":"Mandawar","id":45447},{"name":"Mandwa","id":45448},{"name":"Mangrol","id":45449},{"name":"Manohar Thana","id":45450},{"name":"Manoharpur","id":45451},{"name":"Marwar","id":45452},{"name":"Merta","id":45453},{"name":"Modak","id":45454},{"name":"Mount Abu","id":45455},{"name":"Mukandgarh","id":45456},{"name":"Mundwa","id":45457},{"name":"Nadbai","id":45458},{"name":"Naenwa","id":45459},{"name":"Nagar","id":45460},{"name":"Nagaur","id":45461},{"name":"Napasar","id":45462},{"name":"Naraina","id":45463},{"name":"Nasirabad","id":45464},{"name":"Nathdwara","id":45465},{"name":"Nawa","id":45466},{"name":"Nawalgarh","id":45467},{"name":"Neem Ka Thana","id":45468},{"name":"Neemrana","id":45469},{"name":"Newa Talai","id":45470},{"name":"Nimaj","id":45471},{"name":"Nimbahera","id":45472},{"name":"Niwai","id":45473},{"name":"Nohar","id":45474},{"name":"Nokha","id":45475},{"name":"One SGM","id":45476},{"name":"Padampur","id":45477},{"name":"Pali","id":45478},{"name":"Partapur","id":45479},{"name":"Parvatsar","id":45480},{"name":"Pasoond","id":45481},{"name":"Phalna","id":45482},{"name":"Phalodi","id":45483},{"name":"Phulera","id":45484},{"name":"Pilani","id":45485},{"name":"Pilibanga","id":45486},{"name":"Pindwara","id":45487},{"name":"Pipalia Kalan","id":45488},{"name":"Pipar","id":45489},{"name":"Pirawa","id":45490},{"name":"Pokaran","id":45491},{"name":"Pratapgarh","id":45492},{"name":"Pushkar","id":45493},{"name":"Raipur","id":45494},{"name":"Raisinghnagar","id":45495},{"name":"Rajakhera","id":45496},{"name":"Rajaldesar","id":45497},{"name":"Rajgarh","id":45498},{"name":"Rajsamand","id":45499},{"name":"Ramganj Mandi","id":45500},{"name":"Ramgarh","id":45501},{"name":"Rani","id":45502},{"name":"Raniwara","id":45503},{"name":"Ratan Nagar","id":45504},{"name":"Ratangarh","id":45505},{"name":"Rawatbhata","id":45506},{"name":"Rawatsar","id":45507},{"name":"Rikhabdev","id":45508},{"name":"Ringas","id":45509},{"name":"Sadri","id":45510},{"name":"Sadulshahar","id":45511},{"name":"Sagwara","id":45512},{"name":"Salumbar","id":45513},{"name":"Sambhar","id":45514},{"name":"Samdari","id":45515},{"name":"Sanchor","id":45516},{"name":"Sangariya","id":45517},{"name":"Sangod","id":45518},{"name":"Sardarshahr","id":45519},{"name":"Sarwar","id":45520},{"name":"Satal Kheri","id":45521},{"name":"Sawai Madhopur","id":45522},{"name":"Sewan Kalan","id":45523},{"name":"Shahpura","id":45524},{"name":"Sheoganj","id":45525},{"name":"Sikar","id":45526},{"name":"Sirohi","id":45527},{"name":"Siwana","id":45528},{"name":"Sogariya","id":45529},{"name":"Sojat","id":45530},{"name":"Sojat Road","id":45531},{"name":"Sri Madhopur","id":45532},{"name":"Sriganganagar","id":45533},{"name":"Sujangarh","id":45534},{"name":"Suket","id":45535},{"name":"Sumerpur","id":45536},{"name":"Sunel","id":45537},{"name":"Surajgarh","id":45538},{"name":"Suratgarh","id":45539},{"name":"Swaroopganj","id":45540},{"name":"Takhatgarh","id":45541},{"name":"Taranagar","id":45542},{"name":"Three STR","id":45543},{"name":"Tijara","id":45544},{"name":"Toda Bhim","id":45545},{"name":"Toda Raisingh","id":45546},{"name":"Todra","id":45547},{"name":"Tonk","id":45548},{"name":"Udaipur","id":45549},{"name":"Udpura","id":45550},{"name":"Uniara","id":45551},{"name":"Vanasthali","id":45552},{"name":"Vidyavihar","id":45553},{"name":"Vijainagar","id":45554},{"name":"Viratnagar","id":45555},{"name":"Wer","id":45556}]

GetCityResponse getCityResponseFromJson(String str) => GetCityResponse.fromJson(json.decode(str));
String getCityResponseToJson(GetCityResponse data) => json.encode(data.toJson());
class GetCityResponse {
  GetCityResponse({
      List<Cities>? cities,}){
    _cities = cities;
}

  GetCityResponse.fromJson(dynamic json) {
    if (json['cities'] != null) {
      _cities = [];
      json['cities'].forEach((v) {
        _cities?.add(Cities.fromJson(v));
      });
    }
  }
  List<Cities>? _cities;

  List<Cities>? get cities => _cities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cities != null) {
      map['cities'] = _cities?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Abu Road"
/// id : 3294

Cities citiesFromJson(String str) => Cities.fromJson(json.decode(str));
String citiesToJson(Cities data) => json.encode(data.toJson());
class Cities {
  Cities({
      String? name, 
      int? id,}){
    _name = name;
    _id = id;
}

  Cities.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
  }
  String? _name;
  int? _id;

  String? get name => _name;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    return map;
  }

}