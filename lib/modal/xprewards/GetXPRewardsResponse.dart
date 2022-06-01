import 'dart:convert';
/// status : 200
/// data : {"oleague1":{"league_id":1,"league":"Expert","xp":2000},"oleague2":{"league_id":2,"league":"Scholar","xp":1600},"oleague3":{"league_id":3,"league":"Culture Vulutre","xp":1200},"oleague4":{"league_id":4,"league":"Dabbler","xp":800},"your_leage":{"league":"Initiate","league_id":5,"xp":400,"user_id":"74"}}
/// message : "Success"

GetXpRewardsResponse getXpRewardsResponseFromJson(String str) => GetXpRewardsResponse.fromJson(json.decode(str));
String getXpRewardsResponseToJson(GetXpRewardsResponse data) => json.encode(data.toJson());
class GetXpRewardsResponse {
  GetXpRewardsResponse({
      int? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetXpRewardsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  int? _status;
  Data? _data;
  String? _message;
GetXpRewardsResponse copyWith({  int? status,
  Data? data,
  String? message,
}) => GetXpRewardsResponse(  status: status ?? _status,
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

/// oleague1 : {"league_id":1,"league":"Expert","xp":2000}
/// oleague2 : {"league_id":2,"league":"Scholar","xp":1600}
/// oleague3 : {"league_id":3,"league":"Culture Vulutre","xp":1200}
/// oleague4 : {"league_id":4,"league":"Dabbler","xp":800}
/// your_leage : {"league":"Initiate","league_id":5,"xp":400,"user_id":"74"}

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

/// league : "Initiate"
/// league_id : 5
/// xp : 400
/// user_id : "74"

YourLeage yourLeageFromJson(String str) => YourLeage.fromJson(json.decode(str));
String yourLeageToJson(YourLeage data) => json.encode(data.toJson());
class YourLeage {
  YourLeage({
      String? league, 
      int? leagueId, 
      int? xp, 
      String? userId,}){
    _league = league;
    _leagueId = leagueId;
    _xp = xp;
    _userId = userId;
}

  YourLeage.fromJson(dynamic json) {
    _league = json['league'];
    _leagueId = json['league_id'];
    _xp = json['xp'];
    _userId = json['user_id'];
  }
  String? _league;
  int? _leagueId;
  int? _xp;
  String? _userId;
YourLeage copyWith({  String? league,
  int? leagueId,
  int? xp,
  String? userId,
}) => YourLeage(  league: league ?? _league,
  leagueId: leagueId ?? _leagueId,
  xp: xp ?? _xp,
  userId: userId ?? _userId,
);
  String? get league => _league;
  int? get leagueId => _leagueId;
  int? get xp => _xp;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['league'] = _league;
    map['league_id'] = _leagueId;
    map['xp'] = _xp;
    map['user_id'] = _userId;
    return map;
  }

}

/// league_id : 4
/// league : "Dabbler"
/// xp : 800

Oleague4 oleague4FromJson(String str) => Oleague4.fromJson(json.decode(str));
String oleague4ToJson(Oleague4 data) => json.encode(data.toJson());
class Oleague4 {
  Oleague4({
      int? leagueId, 
      String? league, 
      int? xp,}){
    _leagueId = leagueId;
    _league = league;
    _xp = xp;
}

  Oleague4.fromJson(dynamic json) {
    _leagueId = json['league_id'];
    _league = json['league'];
    _xp = json['xp'];
  }
  int? _leagueId;
  String? _league;
  int? _xp;
Oleague4 copyWith({  int? leagueId,
  String? league,
  int? xp,
}) => Oleague4(  leagueId: leagueId ?? _leagueId,
  league: league ?? _league,
  xp: xp ?? _xp,
);
  int? get leagueId => _leagueId;
  String? get league => _league;
  int? get xp => _xp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['league_id'] = _leagueId;
    map['league'] = _league;
    map['xp'] = _xp;
    return map;
  }

}

/// league_id : 3
/// league : "Culture Vulutre"
/// xp : 1200

Oleague3 oleague3FromJson(String str) => Oleague3.fromJson(json.decode(str));
String oleague3ToJson(Oleague3 data) => json.encode(data.toJson());
class Oleague3 {
  Oleague3({
      int? leagueId, 
      String? league, 
      int? xp,}){
    _leagueId = leagueId;
    _league = league;
    _xp = xp;
}

  Oleague3.fromJson(dynamic json) {
    _leagueId = json['league_id'];
    _league = json['league'];
    _xp = json['xp'];
  }
  int? _leagueId;
  String? _league;
  int? _xp;
Oleague3 copyWith({  int? leagueId,
  String? league,
  int? xp,
}) => Oleague3(  leagueId: leagueId ?? _leagueId,
  league: league ?? _league,
  xp: xp ?? _xp,
);
  int? get leagueId => _leagueId;
  String? get league => _league;
  int? get xp => _xp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['league_id'] = _leagueId;
    map['league'] = _league;
    map['xp'] = _xp;
    return map;
  }

}

/// league_id : 2
/// league : "Scholar"
/// xp : 1600

Oleague2 oleague2FromJson(String str) => Oleague2.fromJson(json.decode(str));
String oleague2ToJson(Oleague2 data) => json.encode(data.toJson());
class Oleague2 {
  Oleague2({
      int? leagueId, 
      String? league, 
      int? xp,}){
    _leagueId = leagueId;
    _league = league;
    _xp = xp;
}

  Oleague2.fromJson(dynamic json) {
    _leagueId = json['league_id'];
    _league = json['league'];
    _xp = json['xp'];
  }
  int? _leagueId;
  String? _league;
  int? _xp;
Oleague2 copyWith({  int? leagueId,
  String? league,
  int? xp,
}) => Oleague2(  leagueId: leagueId ?? _leagueId,
  league: league ?? _league,
  xp: xp ?? _xp,
);
  int? get leagueId => _leagueId;
  String? get league => _league;
  int? get xp => _xp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['league_id'] = _leagueId;
    map['league'] = _league;
    map['xp'] = _xp;
    return map;
  }

}

/// league_id : 1
/// league : "Expert"
/// xp : 2000

Oleague1 oleague1FromJson(String str) => Oleague1.fromJson(json.decode(str));
String oleague1ToJson(Oleague1 data) => json.encode(data.toJson());
class Oleague1 {
  Oleague1({
      int? leagueId, 
      String? league, 
      int? xp,}){
    _leagueId = leagueId;
    _league = league;
    _xp = xp;
}

  Oleague1.fromJson(dynamic json) {
    _leagueId = json['league_id'];
    _league = json['league'];
    _xp = json['xp'];
  }
  int? _leagueId;
  String? _league;
  int? _xp;
Oleague1 copyWith({  int? leagueId,
  String? league,
  int? xp,
}) => Oleague1(  leagueId: leagueId ?? _leagueId,
  league: league ?? _league,
  xp: xp ?? _xp,
);
  int? get leagueId => _leagueId;
  String? get league => _league;
  int? get xp => _xp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['league_id'] = _leagueId;
    map['league'] = _league;
    map['xp'] = _xp;
    return map;
  }

}