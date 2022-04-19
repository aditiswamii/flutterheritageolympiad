import 'dart:convert';
/// countries : [{"name":"Afghanistan","id":1},{"name":"Albania","id":2},{"name":"Algeria","id":3},{"name":"American Samoa","id":4},{"name":"Andorra","id":5},{"name":"Angola","id":6},{"name":"Anguilla","id":7},{"name":"Antarctica","id":8},{"name":"Antigua And Barbuda","id":9},{"name":"Argentina","id":10},{"name":"Armenia","id":11},{"name":"Aruba","id":12},{"name":"Australia","id":13},{"name":"Austria","id":14},{"name":"Azerbaijan","id":15},{"name":"Bahamas The","id":16},{"name":"Bahrain","id":17},{"name":"Bangladesh","id":18},{"name":"Barbados","id":19},{"name":"Belarus","id":20},{"name":"Belgium","id":21},{"name":"Belize","id":22},{"name":"Benin","id":23},{"name":"Bermuda","id":24},{"name":"Bhutan","id":25},{"name":"Bolivia","id":26},{"name":"Bosnia and Herzegovina","id":27},{"name":"Botswana","id":28},{"name":"Bouvet Island","id":29},{"name":"Brazil","id":30},{"name":"British Indian Ocean Territory","id":31},{"name":"Brunei","id":32},{"name":"Bulgaria","id":33},{"name":"Burkina Faso","id":34},{"name":"Burundi","id":35},{"name":"Cambodia","id":36},{"name":"Cameroon","id":37},{"name":"Canada","id":38},{"name":"Cape Verde","id":39},{"name":"Cayman Islands","id":40},{"name":"Central African Republic","id":41},{"name":"Chad","id":42},{"name":"Chile","id":43},{"name":"China","id":44},{"name":"Christmas Island","id":45},{"name":"Cocos (Keeling) Islands","id":46},{"name":"Colombia","id":47},{"name":"Comoros","id":48},{"name":"Congo","id":49},{"name":"Congo The Democratic Republic Of The","id":50},{"name":"Cook Islands","id":51},{"name":"Costa Rica","id":52},{"name":"Cote D Ivoire (Ivory Coast)","id":53},{"name":"Croatia (Hrvatska)","id":54},{"name":"Cuba","id":55},{"name":"Cyprus","id":56},{"name":"Czech Republic","id":57},{"name":"Denmark","id":58},{"name":"Djibouti","id":59},{"name":"Dominica","id":60},{"name":"Dominican Republic","id":61},{"name":"East Timor","id":62},{"name":"Ecuador","id":63},{"name":"Egypt","id":64},{"name":"El Salvador","id":65},{"name":"Equatorial Guinea","id":66},{"name":"Eritrea","id":67},{"name":"Estonia","id":68},{"name":"Ethiopia","id":69},{"name":"External Territories of Australia","id":70},{"name":"Falkland Islands","id":71},{"name":"Faroe Islands","id":72},{"name":"Fiji Islands","id":73},{"name":"Finland","id":74},{"name":"France","id":75},{"name":"French Guiana","id":76},{"name":"French Polynesia","id":77},{"name":"French Southern Territories","id":78},{"name":"Gabon","id":79},{"name":"Gambia The","id":80},{"name":"Georgia","id":81},{"name":"Germany","id":82},{"name":"Ghana","id":83},{"name":"Gibraltar","id":84},{"name":"Greece","id":85},{"name":"Greenland","id":86},{"name":"Grenada","id":87},{"name":"Guadeloupe","id":88},{"name":"Guam","id":89},{"name":"Guatemala","id":90},{"name":"Guernsey and Alderney","id":91},{"name":"Guinea","id":92},{"name":"Guinea-Bissau","id":93},{"name":"Guyana","id":94},{"name":"Haiti","id":95},{"name":"Heard and McDonald Islands","id":96},{"name":"Honduras","id":97},{"name":"Hong Kong S.A.R.","id":98},{"name":"Hungary","id":99},{"name":"Iceland","id":100},{"name":"India","id":101},{"name":"Indonesia","id":102},{"name":"Iran","id":103},{"name":"Iraq","id":104},{"name":"Ireland","id":105},{"name":"Israel","id":106},{"name":"Italy","id":107},{"name":"Jamaica","id":108},{"name":"Japan","id":109},{"name":"Jersey","id":110},{"name":"Jordan","id":111},{"name":"Kazakhstan","id":112},{"name":"Kenya","id":113},{"name":"Kiribati","id":114},{"name":"Korea North","id":115},{"name":"Korea South","id":116},{"name":"Kuwait","id":117},{"name":"Kyrgyzstan","id":118},{"name":"Laos","id":119},{"name":"Latvia","id":120},{"name":"Lebanon","id":121},{"name":"Lesotho","id":122},{"name":"Liberia","id":123},{"name":"Libya","id":124},{"name":"Liechtenstein","id":125},{"name":"Lithuania","id":126},{"name":"Luxembourg","id":127},{"name":"Macau S.A.R.","id":128},{"name":"Macedonia","id":129},{"name":"Madagascar","id":130},{"name":"Malawi","id":131},{"name":"Malaysia","id":132},{"name":"Maldives","id":133},{"name":"Mali","id":134},{"name":"Malta","id":135},{"name":"Man (Isle of)","id":136},{"name":"Marshall Islands","id":137},{"name":"Martinique","id":138},{"name":"Mauritania","id":139},{"name":"Mauritius","id":140},{"name":"Mayotte","id":141},{"name":"Mexico","id":142},{"name":"Micronesia","id":143},{"name":"Moldova","id":144},{"name":"Monaco","id":145},{"name":"Mongolia","id":146},{"name":"Montserrat","id":147},{"name":"Morocco","id":148},{"name":"Mozambique","id":149},{"name":"Myanmar","id":150},{"name":"Namibia","id":151},{"name":"Nauru","id":152},{"name":"Nepal","id":153},{"name":"Netherlands Antilles","id":154},{"name":"Netherlands The","id":155},{"name":"New Caledonia","id":156},{"name":"New Zealand","id":157},{"name":"Nicaragua","id":158},{"name":"Niger","id":159},{"name":"Nigeria","id":160},{"name":"Niue","id":161},{"name":"Norfolk Island","id":162},{"name":"Northern Mariana Islands","id":163},{"name":"Norway","id":164},{"name":"Oman","id":165},{"name":"Pakistan","id":166},{"name":"Palau","id":167},{"name":"Palestinian Territory Occupied","id":168},{"name":"Panama","id":169},{"name":"Papua new Guinea","id":170},{"name":"Paraguay","id":171},{"name":"Peru","id":172},{"name":"Philippines","id":173},{"name":"Pitcairn Island","id":174},{"name":"Poland","id":175},{"name":"Portugal","id":176},{"name":"Puerto Rico","id":177},{"name":"Qatar","id":178},{"name":"Reunion","id":179},{"name":"Romania","id":180},{"name":"Russia","id":181},{"name":"Rwanda","id":182},{"name":"Saint Helena","id":183},{"name":"Saint Kitts And Nevis","id":184},{"name":"Saint Lucia","id":185},{"name":"Saint Pierre and Miquelon","id":186},{"name":"Saint Vincent And The Grenadines","id":187},{"name":"Samoa","id":188},{"name":"San Marino","id":189},{"name":"Sao Tome and Principe","id":190},{"name":"Saudi Arabia","id":191},{"name":"Senegal","id":192},{"name":"Serbia","id":193},{"name":"Seychelles","id":194},{"name":"Sierra Leone","id":195},{"name":"Singapore","id":196},{"name":"Slovakia","id":197},{"name":"Slovenia","id":198},{"name":"Smaller Territories of the UK","id":199},{"name":"Solomon Islands","id":200},{"name":"Somalia","id":201},{"name":"South Africa","id":202},{"name":"South Georgia","id":203},{"name":"South Sudan","id":204},{"name":"Spain","id":205},{"name":"Sri Lanka","id":206},{"name":"Sudan","id":207},{"name":"Suriname","id":208},{"name":"Svalbard And Jan Mayen Islands","id":209},{"name":"Swaziland","id":210},{"name":"Sweden","id":211},{"name":"Switzerland","id":212},{"name":"Syria","id":213},{"name":"Taiwan","id":214},{"name":"Tajikistan","id":215},{"name":"Tanzania","id":216},{"name":"Thailand","id":217},{"name":"Togo","id":218},{"name":"Tokelau","id":219},{"name":"Tonga","id":220},{"name":"Trinidad And Tobago","id":221},{"name":"Tunisia","id":222},{"name":"Turkey","id":223},{"name":"Turkmenistan","id":224},{"name":"Turks And Caicos Islands","id":225},{"name":"Tuvalu","id":226},{"name":"Uganda","id":227},{"name":"Ukraine","id":228},{"name":"United Arab Emirates","id":229},{"name":"United Kingdom","id":230},{"name":"United States","id":231},{"name":"United States Minor Outlying Islands","id":232},{"name":"Uruguay","id":233},{"name":"Uzbekistan","id":234},{"name":"Vanuatu","id":235},{"name":"Vatican City State (Holy See)","id":236},{"name":"Venezuela","id":237},{"name":"Vietnam","id":238},{"name":"Virgin Islands (British)","id":239},{"name":"Virgin Islands (US)","id":240},{"name":"Wallis And Futuna Islands","id":241},{"name":"Western Sahara","id":242},{"name":"Yemen","id":243},{"name":"Yugoslavia","id":244},{"name":"Zambia","id":245},{"name":"Zimbabwe","id":246}]

GetCountryList getCountryListFromJson(String str) => GetCountryList.fromJson(json.decode(str));
String getCountryListToJson(GetCountryList data) => json.encode(data.toJson());
class GetCountryList {
  GetCountryList({
      List<Countries>? countries,}){
    _countries = countries;
}

  GetCountryList.fromJson(dynamic json) {
    if (json['countries'] != null) {
      _countries = [];
      json['countries'].forEach((v) {
        _countries?.add(Countries.fromJson(v));
      });
    }
  }
  List<Countries>? _countries;

  List<Countries>? get countries => _countries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_countries != null) {
      map['countries'] = _countries?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Afghanistan"
/// id : 1

Countries countriesFromJson(String str) => Countries.fromJson(json.decode(str));
String countriesToJson(Countries data) => json.encode(data.toJson());
class Countries {
  Countries({
      String? name, 
      int? id,}){
    _name = name;
    _id = id;
}

  Countries.fromJson(dynamic json) {
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