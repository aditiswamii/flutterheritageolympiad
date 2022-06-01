import 'dart:convert';
/// status : 200
/// data : {"oleague1":{"league_id":1,"league_name":"Expert","data":[]},"oleague2":{"league_id":2,"league_name":"Scholar","data":[]},"oleague3":{"league_id":3,"league_name":"Culture Vulutre","data":[]},"oleague4":{"league_id":4,"league_name":"Dabbler","data":[]},"your_leage":{"league_id":5,"league_name":"Initiate","top":[{"rank":1,"percentage":19,"user_id":18},{"rank":2,"percentage":1,"user_id":4},{"rank":3,"percentage":1,"user_id":136},{"rank":4,"percentage":0,"user_id":96},{"rank":5,"percentage":0,"user_id":108},{"rank":6,"percentage":0,"user_id":107},{"rank":7,"percentage":0,"user_id":106},{"rank":8,"percentage":0,"user_id":105},{"rank":9,"percentage":0,"user_id":104},{"rank":10,"percentage":0,"user_id":103},{"rank":11,"percentage":0,"user_id":102},{"rank":12,"percentage":0,"user_id":101},{"rank":13,"percentage":0,"user_id":100},{"rank":14,"percentage":0,"user_id":99},{"rank":15,"percentage":0,"user_id":98},{"rank":16,"percentage":0,"user_id":97},{"rank":17,"percentage":0,"user_id":116},{"rank":18,"percentage":0,"user_id":95},{"rank":19,"percentage":0,"user_id":93},{"rank":20,"percentage":0,"user_id":92},{"rank":21,"percentage":0,"user_id":91},{"rank":22,"percentage":0,"user_id":90},{"rank":23,"percentage":0,"user_id":89},{"rank":24,"percentage":0,"user_id":88},{"rank":25,"percentage":0,"user_id":87},{"rank":26,"percentage":0,"user_id":131},{"rank":27,"percentage":0,"user_id":145},{"rank":28,"percentage":0,"user_id":139},{"rank":29,"percentage":0,"user_id":144},{"rank":30,"percentage":0,"user_id":137},{"rank":31,"percentage":0,"user_id":126},{"rank":32,"percentage":0,"user_id":130},{"rank":33,"percentage":0,"user_id":135},{"rank":34,"percentage":0,"user_id":134},{"rank":35,"percentage":0,"user_id":133},{"rank":36,"percentage":0,"user_id":132},{"rank":37,"percentage":0,"user_id":109},{"rank":38,"percentage":0,"user_id":129},{"rank":39,"percentage":0,"user_id":127},{"rank":40,"percentage":0,"user_id":125},{"rank":41,"percentage":0,"user_id":124},{"rank":42,"percentage":0,"user_id":123},{"rank":43,"percentage":0,"user_id":122},{"rank":44,"percentage":0,"user_id":121},{"rank":45,"percentage":0,"user_id":118},{"rank":46,"percentage":0,"user_id":85},{"rank":47,"percentage":0,"user_id":110},{"rank":48,"percentage":0,"user_id":21},{"rank":49,"percentage":0,"user_id":66},{"rank":50,"percentage":0,"user_id":56},{"rank":51,"percentage":0,"user_id":65},{"rank":52,"percentage":0,"user_id":63},{"rank":53,"percentage":0,"user_id":62},{"rank":54,"percentage":0,"user_id":61},{"rank":55,"percentage":0,"user_id":20},{"rank":56,"percentage":0,"user_id":60},{"rank":57,"percentage":0,"user_id":59},{"rank":58,"percentage":0,"user_id":22},{"rank":59,"percentage":0,"user_id":3},{"rank":60,"percentage":0,"user_id":14},{"rank":61,"percentage":0,"user_id":19},{"rank":62,"percentage":0,"user_id":17},{"rank":63,"percentage":0,"user_id":12},{"rank":64,"percentage":0,"user_id":16},{"rank":65,"percentage":0,"user_id":15},{"rank":66,"percentage":0,"user_id":2},{"rank":67,"percentage":0,"user_id":5},{"rank":68,"percentage":0,"user_id":13},{"rank":69,"percentage":0,"user_id":1},{"rank":70,"percentage":0,"user_id":79},{"rank":71,"percentage":0,"user_id":6},{"rank":72,"percentage":0,"user_id":84},{"rank":73,"percentage":0,"user_id":83},{"rank":74,"percentage":0,"user_id":82},{"rank":75,"percentage":0,"user_id":115},{"rank":76,"percentage":0,"user_id":80},{"rank":77,"percentage":0,"user_id":113},{"rank":78,"percentage":0,"user_id":112},{"rank":79,"percentage":0,"user_id":111},{"rank":80,"percentage":0,"user_id":81},{"rank":81,"percentage":0,"user_id":86},{"rank":82,"percentage":0,"user_id":78},{"rank":83,"percentage":0,"user_id":77},{"rank":84,"percentage":0,"user_id":75},{"rank":85,"percentage":0,"user_id":74}]}}
/// message : "Success"

GetLeagueRankResponse getLeagueRankResponseFromJson(String str) => GetLeagueRankResponse.fromJson(json.decode(str));
String getLeagueRankResponseToJson(GetLeagueRankResponse data) => json.encode(data.toJson());
class GetLeagueRankResponse {
  GetLeagueRankResponse({
      int? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetLeagueRankResponse.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  int? _status;
  Data? _data;
  String? _message;
GetLeagueRankResponse copyWith({  int? status,
  Data? data,
  String? message,
}) => GetLeagueRankResponse(  status: status ?? _status,
  data: data ?? _data,
  message: message ?? _message,
);
  int? get status => _status;
  Data? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

/// oleague1 : {"league_id":1,"league_name":"Expert","data":[]}
/// oleague2 : {"league_id":2,"league_name":"Scholar","data":[]}
/// oleague3 : {"league_id":3,"league_name":"Culture Vulutre","data":[]}
/// oleague4 : {"league_id":4,"league_name":"Dabbler","data":[]}
/// your_leage : {"league_id":5,"league_name":"Initiate","top":[{"rank":1,"percentage":19,"user_id":18},{"rank":2,"percentage":1,"user_id":4},{"rank":3,"percentage":1,"user_id":136},{"rank":4,"percentage":0,"user_id":96},{"rank":5,"percentage":0,"user_id":108},{"rank":6,"percentage":0,"user_id":107},{"rank":7,"percentage":0,"user_id":106},{"rank":8,"percentage":0,"user_id":105},{"rank":9,"percentage":0,"user_id":104},{"rank":10,"percentage":0,"user_id":103},{"rank":11,"percentage":0,"user_id":102},{"rank":12,"percentage":0,"user_id":101},{"rank":13,"percentage":0,"user_id":100},{"rank":14,"percentage":0,"user_id":99},{"rank":15,"percentage":0,"user_id":98},{"rank":16,"percentage":0,"user_id":97},{"rank":17,"percentage":0,"user_id":116},{"rank":18,"percentage":0,"user_id":95},{"rank":19,"percentage":0,"user_id":93},{"rank":20,"percentage":0,"user_id":92},{"rank":21,"percentage":0,"user_id":91},{"rank":22,"percentage":0,"user_id":90},{"rank":23,"percentage":0,"user_id":89},{"rank":24,"percentage":0,"user_id":88},{"rank":25,"percentage":0,"user_id":87},{"rank":26,"percentage":0,"user_id":131},{"rank":27,"percentage":0,"user_id":145},{"rank":28,"percentage":0,"user_id":139},{"rank":29,"percentage":0,"user_id":144},{"rank":30,"percentage":0,"user_id":137},{"rank":31,"percentage":0,"user_id":126},{"rank":32,"percentage":0,"user_id":130},{"rank":33,"percentage":0,"user_id":135},{"rank":34,"percentage":0,"user_id":134},{"rank":35,"percentage":0,"user_id":133},{"rank":36,"percentage":0,"user_id":132},{"rank":37,"percentage":0,"user_id":109},{"rank":38,"percentage":0,"user_id":129},{"rank":39,"percentage":0,"user_id":127},{"rank":40,"percentage":0,"user_id":125},{"rank":41,"percentage":0,"user_id":124},{"rank":42,"percentage":0,"user_id":123},{"rank":43,"percentage":0,"user_id":122},{"rank":44,"percentage":0,"user_id":121},{"rank":45,"percentage":0,"user_id":118},{"rank":46,"percentage":0,"user_id":85},{"rank":47,"percentage":0,"user_id":110},{"rank":48,"percentage":0,"user_id":21},{"rank":49,"percentage":0,"user_id":66},{"rank":50,"percentage":0,"user_id":56},{"rank":51,"percentage":0,"user_id":65},{"rank":52,"percentage":0,"user_id":63},{"rank":53,"percentage":0,"user_id":62},{"rank":54,"percentage":0,"user_id":61},{"rank":55,"percentage":0,"user_id":20},{"rank":56,"percentage":0,"user_id":60},{"rank":57,"percentage":0,"user_id":59},{"rank":58,"percentage":0,"user_id":22},{"rank":59,"percentage":0,"user_id":3},{"rank":60,"percentage":0,"user_id":14},{"rank":61,"percentage":0,"user_id":19},{"rank":62,"percentage":0,"user_id":17},{"rank":63,"percentage":0,"user_id":12},{"rank":64,"percentage":0,"user_id":16},{"rank":65,"percentage":0,"user_id":15},{"rank":66,"percentage":0,"user_id":2},{"rank":67,"percentage":0,"user_id":5},{"rank":68,"percentage":0,"user_id":13},{"rank":69,"percentage":0,"user_id":1},{"rank":70,"percentage":0,"user_id":79},{"rank":71,"percentage":0,"user_id":6},{"rank":72,"percentage":0,"user_id":84},{"rank":73,"percentage":0,"user_id":83},{"rank":74,"percentage":0,"user_id":82},{"rank":75,"percentage":0,"user_id":115},{"rank":76,"percentage":0,"user_id":80},{"rank":77,"percentage":0,"user_id":113},{"rank":78,"percentage":0,"user_id":112},{"rank":79,"percentage":0,"user_id":111},{"rank":80,"percentage":0,"user_id":81},{"rank":81,"percentage":0,"user_id":86},{"rank":82,"percentage":0,"user_id":78},{"rank":83,"percentage":0,"user_id":77},{"rank":84,"percentage":0,"user_id":75},{"rank":85,"percentage":0,"user_id":74}]}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      Oleague1? oleague1, 
      Oleague2? oleague2, 
      Oleague3? oleague3, 
      Oleague4? oleague4, 
      YourLeage? yourLeage,}){
    _oleague1 = oleague1;
    _oleague2 = oleague2;
    _oleague3 = oleague3;
    _oleague4 = oleague4;
    _yourLeage = yourLeage;
}

  Data.fromJson(dynamic json) {
    _oleague1 = json['oleague1'] != null ? Oleague1.fromJson(json['oleague1']) : null;
    _oleague2 = json['oleague2'] != null ? Oleague2.fromJson(json['oleague2']) : null;
    _oleague3 = json['oleague3'] != null ? Oleague3.fromJson(json['oleague3']) : null;
    _oleague4 = json['oleague4'] != null ? Oleague4.fromJson(json['oleague4']) : null;
    _yourLeage = json['your_leage'] != null ? YourLeage.fromJson(json['your_leage']) : null;
  }
  Oleague1? _oleague1;
  Oleague2? _oleague2;
  Oleague3? _oleague3;
  Oleague4? _oleague4;
  YourLeage? _yourLeage;
Data copyWith({  Oleague1? oleague1,
  Oleague2? oleague2,
  Oleague3? oleague3,
  Oleague4? oleague4,
  YourLeage? yourLeage,
}) => Data(  oleague1: oleague1 ?? _oleague1,
  oleague2: oleague2 ?? _oleague2,
  oleague3: oleague3 ?? _oleague3,
  oleague4: oleague4 ?? _oleague4,
  yourLeage: yourLeage ?? _yourLeage,
);
  Oleague1? get oleague1 => _oleague1;
  Oleague2? get oleague2 => _oleague2;
  Oleague3? get oleague3 => _oleague3;
  Oleague4? get oleague4 => _oleague4;
  YourLeage? get yourLeage => _yourLeage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_oleague1 != null) {
      map['oleague1'] = _oleague1?.toJson();
    }
    if (_oleague2 != null) {
      map['oleague2'] = _oleague2?.toJson();
    }
    if (_oleague3 != null) {
      map['oleague3'] = _oleague3?.toJson();
    }
    if (_oleague4 != null) {
      map['oleague4'] = _oleague4?.toJson();
    }
    if (_yourLeage != null) {
      map['your_leage'] = _yourLeage?.toJson();
    }
    return map;
  }

}

/// league_id : 5
/// league_name : "Initiate"
/// top : [{"rank":1,"percentage":19,"user_id":18},{"rank":2,"percentage":1,"user_id":4},{"rank":3,"percentage":1,"user_id":136},{"rank":4,"percentage":0,"user_id":96},{"rank":5,"percentage":0,"user_id":108},{"rank":6,"percentage":0,"user_id":107},{"rank":7,"percentage":0,"user_id":106},{"rank":8,"percentage":0,"user_id":105},{"rank":9,"percentage":0,"user_id":104},{"rank":10,"percentage":0,"user_id":103},{"rank":11,"percentage":0,"user_id":102},{"rank":12,"percentage":0,"user_id":101},{"rank":13,"percentage":0,"user_id":100},{"rank":14,"percentage":0,"user_id":99},{"rank":15,"percentage":0,"user_id":98},{"rank":16,"percentage":0,"user_id":97},{"rank":17,"percentage":0,"user_id":116},{"rank":18,"percentage":0,"user_id":95},{"rank":19,"percentage":0,"user_id":93},{"rank":20,"percentage":0,"user_id":92},{"rank":21,"percentage":0,"user_id":91},{"rank":22,"percentage":0,"user_id":90},{"rank":23,"percentage":0,"user_id":89},{"rank":24,"percentage":0,"user_id":88},{"rank":25,"percentage":0,"user_id":87},{"rank":26,"percentage":0,"user_id":131},{"rank":27,"percentage":0,"user_id":145},{"rank":28,"percentage":0,"user_id":139},{"rank":29,"percentage":0,"user_id":144},{"rank":30,"percentage":0,"user_id":137},{"rank":31,"percentage":0,"user_id":126},{"rank":32,"percentage":0,"user_id":130},{"rank":33,"percentage":0,"user_id":135},{"rank":34,"percentage":0,"user_id":134},{"rank":35,"percentage":0,"user_id":133},{"rank":36,"percentage":0,"user_id":132},{"rank":37,"percentage":0,"user_id":109},{"rank":38,"percentage":0,"user_id":129},{"rank":39,"percentage":0,"user_id":127},{"rank":40,"percentage":0,"user_id":125},{"rank":41,"percentage":0,"user_id":124},{"rank":42,"percentage":0,"user_id":123},{"rank":43,"percentage":0,"user_id":122},{"rank":44,"percentage":0,"user_id":121},{"rank":45,"percentage":0,"user_id":118},{"rank":46,"percentage":0,"user_id":85},{"rank":47,"percentage":0,"user_id":110},{"rank":48,"percentage":0,"user_id":21},{"rank":49,"percentage":0,"user_id":66},{"rank":50,"percentage":0,"user_id":56},{"rank":51,"percentage":0,"user_id":65},{"rank":52,"percentage":0,"user_id":63},{"rank":53,"percentage":0,"user_id":62},{"rank":54,"percentage":0,"user_id":61},{"rank":55,"percentage":0,"user_id":20},{"rank":56,"percentage":0,"user_id":60},{"rank":57,"percentage":0,"user_id":59},{"rank":58,"percentage":0,"user_id":22},{"rank":59,"percentage":0,"user_id":3},{"rank":60,"percentage":0,"user_id":14},{"rank":61,"percentage":0,"user_id":19},{"rank":62,"percentage":0,"user_id":17},{"rank":63,"percentage":0,"user_id":12},{"rank":64,"percentage":0,"user_id":16},{"rank":65,"percentage":0,"user_id":15},{"rank":66,"percentage":0,"user_id":2},{"rank":67,"percentage":0,"user_id":5},{"rank":68,"percentage":0,"user_id":13},{"rank":69,"percentage":0,"user_id":1},{"rank":70,"percentage":0,"user_id":79},{"rank":71,"percentage":0,"user_id":6},{"rank":72,"percentage":0,"user_id":84},{"rank":73,"percentage":0,"user_id":83},{"rank":74,"percentage":0,"user_id":82},{"rank":75,"percentage":0,"user_id":115},{"rank":76,"percentage":0,"user_id":80},{"rank":77,"percentage":0,"user_id":113},{"rank":78,"percentage":0,"user_id":112},{"rank":79,"percentage":0,"user_id":111},{"rank":80,"percentage":0,"user_id":81},{"rank":81,"percentage":0,"user_id":86},{"rank":82,"percentage":0,"user_id":78},{"rank":83,"percentage":0,"user_id":77},{"rank":84,"percentage":0,"user_id":75},{"rank":85,"percentage":0,"user_id":74}]

YourLeage yourLeageFromJson(String str) => YourLeage.fromJson(json.decode(str));
String yourLeageToJson(YourLeage data) => json.encode(data.toJson());
class YourLeage {
  YourLeage({
      int? leagueId, 
      String? leagueName, 
      List<Top>? top,}){
    _leagueId = leagueId;
    _leagueName = leagueName;
    _top = top;
}

  YourLeage.fromJson(dynamic json) {
    _leagueId = json['league_id'];
    _leagueName = json['league_name'];
    if (json['top'] != null) {
      _top = [];
      json['top'].forEach((v) {
        _top?.add(Top.fromJson(v));
      });
    }
  }
  int? _leagueId;
  String? _leagueName;
  List<Top>? _top;
YourLeage copyWith({  int? leagueId,
  String? leagueName,
  List<Top>? top,
}) => YourLeage(  leagueId: leagueId ?? _leagueId,
  leagueName: leagueName ?? _leagueName,
  top: top ?? _top,
);
  int? get leagueId => _leagueId;
  String? get leagueName => _leagueName;
  List<Top>? get top => _top;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['league_id'] = _leagueId;
    map['league_name'] = _leagueName;
    if (_top != null) {
      map['top'] = _top?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// rank : 1
/// percentage : 19
/// user_id : 18

Top topFromJson(String str) => Top.fromJson(json.decode(str));
String topToJson(Top data) => json.encode(data.toJson());
class Top {
  Top({
      int? rank, 
      int? percentage, 
      int? userId,}){
    _rank = rank;
    _percentage = percentage;
    _userId = userId;
}

  Top.fromJson(dynamic json) {
    _rank = json['rank'];
    _percentage = json['percentage'];
    _userId = json['user_id'];
  }
  int? _rank;
  int? _percentage;
  int? _userId;
Top copyWith({  int? rank,
  int? percentage,
  int? userId,
}) => Top(  rank: rank ?? _rank,
  percentage: percentage ?? _percentage,
  userId: userId ?? _userId,
);
  int? get rank => _rank;
  int? get percentage => _percentage;
  int? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rank'] = _rank;
    map['percentage'] = _percentage;
    map['user_id'] = _userId;
    return map;
  }

}

/// league_id : 4
/// league_name : "Dabbler"
/// data : []

Oleague4 oleague4FromJson(String str) => Oleague4.fromJson(json.decode(str));
String oleague4ToJson(Oleague4 data) => json.encode(data.toJson());
class Oleague4 {
  Oleague4({
      int? leagueId, 
      String? leagueName, 
      List<Data1>? data,}){
    _leagueId = leagueId;
    _leagueName = leagueName;
    _data = data;
}

  Oleague4.fromJson(dynamic json) {
    _leagueId = json['league_id'];
    _leagueName = json['league_name'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data1.fromJson(v));
      });
    }
  }
  int? _leagueId;
  String? _leagueName;
  List<Data1>? _data;
Oleague4 copyWith({  int? leagueId,
  String? leagueName,
  List<Data1>? data,
}) => Oleague4(  leagueId: leagueId ?? _leagueId,
  leagueName: leagueName ?? _leagueName,
  data: data ?? _data,
);
  int? get leagueId => _leagueId;
  String? get leagueName => _leagueName;
  List<Data1>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['league_id'] = _leagueId;
    map['league_name'] = _leagueName;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// league_id : 3
/// league_name : "Culture Vulutre"
/// data : []

Oleague3 oleague3FromJson(String str) => Oleague3.fromJson(json.decode(str));
String oleague3ToJson(Oleague3 data) => json.encode(data.toJson());
class Oleague3 {
  Oleague3({
      int? leagueId, 
      String? leagueName, 
      List<Data1>? data,}){
    _leagueId = leagueId;
    _leagueName = leagueName;
    _data = data;
}

  Oleague3.fromJson(dynamic json) {
    _leagueId = json['league_id'];
    _leagueName = json['league_name'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data1.fromJson(v));
      });
    }
  }
  int? _leagueId;
  String? _leagueName;
  List<Data1>? _data;
Oleague3 copyWith({  int? leagueId,
  String? leagueName,
  List<Data1>? data,
}) => Oleague3(  leagueId: leagueId ?? _leagueId,
  leagueName: leagueName ?? _leagueName,
  data: data ?? _data,
);
  int? get leagueId => _leagueId;
  String? get leagueName => _leagueName;
  List<dynamic>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['league_id'] = _leagueId;
    map['league_name'] = _leagueName;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// league_id : 2
/// league_name : "Scholar"
/// data : []

Oleague2 oleague2FromJson(String str) => Oleague2.fromJson(json.decode(str));
String oleague2ToJson(Oleague2 data) => json.encode(data.toJson());
class Oleague2 {
  Oleague2({
      int? leagueId, 
      String? leagueName, 
      List<Data1>? data,}){
    _leagueId = leagueId;
    _leagueName = leagueName;
    _data = data;
}

  Oleague2.fromJson(dynamic json) {
    _leagueId = json['league_id'];
    _leagueName = json['league_name'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data1.fromJson(v));
      });
    }
  }
  int? _leagueId;
  String? _leagueName;
  List<Data1>? _data;
Oleague2 copyWith({  int? leagueId,
  String? leagueName,
  List<Data1>? data,
}) => Oleague2(  leagueId: leagueId ?? _leagueId,
  leagueName: leagueName ?? _leagueName,
  data: data ?? _data,
);
  int? get leagueId => _leagueId;
  String? get leagueName => _leagueName;
  List<dynamic>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['league_id'] = _leagueId;
    map['league_name'] = _leagueName;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// league_id : 1
/// league_name : "Expert"
/// data : []

Oleague1 oleague1FromJson(String str) => Oleague1.fromJson(json.decode(str));
String oleague1ToJson(Oleague1 data) => json.encode(data.toJson());
class Oleague1 {
  Oleague1({
      int? leagueId, 
      String? leagueName, 
      List<Data1>? data,}){
    _leagueId = leagueId;
    _leagueName = leagueName;
    _data = data;
}

  Oleague1.fromJson(dynamic json) {
    _leagueId = json['league_id'];
    _leagueName = json['league_name'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data1.fromJson(v));
      });
    }
  }
  int? _leagueId;
  String? _leagueName;
  List<Data1>? _data;
Oleague1 copyWith({  int? leagueId,
  String? leagueName,
  List<Data1>? data,
}) => Oleague1(  leagueId: leagueId ?? _leagueId,
  leagueName: leagueName ?? _leagueName,
  data: data ?? _data,
);
  int? get leagueId => _leagueId;
  String? get leagueName => _leagueName;
  List<Data1>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['league_id'] = _leagueId;
    map['league_name'] = _leagueName;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Data1 data1FromJson(String str) => Data1.fromJson(json.decode(str));
String data1ToJson(Top data) => json.encode(data.toJson());
class Data1 {
  Data1({
    int? rank,
    int? percentage,
    int? userId,}){
    _rank = rank;
    _percentage = percentage;
    _userId = userId;
  }

  Data1.fromJson(dynamic json) {
    _rank = json['rank'];
    _percentage = json['percentage'];
    _userId = json['user_id'];
  }
  int? _rank;
  int? _percentage;
  int? _userId;
  Data1 copyWith({  int? rank,
    int? percentage,
    int? userId,
  }) => Data1(  rank: rank ?? _rank,
    percentage: percentage ?? _percentage,
    userId: userId ?? _userId,
  );
  int? get rank => _rank;
  int? get percentage => _percentage;
  int? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rank'] = _rank;
    map['percentage'] = _percentage;
    map['user_id'] = _userId;
    return map;
  }

}
