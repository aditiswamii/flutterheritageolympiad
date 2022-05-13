import 'dart:convert';
/// status : 200
/// data : {"user":{"title":"Initiate","id":5},"league":[{"id":1,"title":"Expert"},{"id":2,"title":"Scholar"},{"id":3,"title":"Culture Vulutre"},{"id":4,"title":"Dabbler"},{"id":5,"title":"Initiate"}],"rank":[0,0,2,2,2,0,3,0,2,1,0,0,0,0,0,0],"percentage":"0","goalsummery":{"total":10,"play":21,"type":"monthly"}}
/// message : "Success"

GetUserLeagueResponse getUserLeagueResponseFromJson(String str) => GetUserLeagueResponse.fromJson(json.decode(str));
String getUserLeagueResponseToJson(GetUserLeagueResponse data) => json.encode(data.toJson());
class GetUserLeagueResponse {
  GetUserLeagueResponse({
      int? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetUserLeagueResponse.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  int? _status;
  Data? _data;
  String? _message;

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

/// user : {"title":"Initiate","id":5}
/// league : [{"id":1,"title":"Expert"},{"id":2,"title":"Scholar"},{"id":3,"title":"Culture Vulutre"},{"id":4,"title":"Dabbler"},{"id":5,"title":"Initiate"}]
/// rank : [0,0,2,2,2,0,3,0,2,1,0,0,0,0,0,0]
/// percentage : "0"
/// goalsummery : {"total":10,"play":21,"type":"monthly"}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      User? user, 
      List<League>? league, 
      List<int>? rank, 
      String? percentage, 
      Goalsummery? goalsummery,}){
    _user = user;
    _league = league;
    _rank = rank;
    _percentage = percentage;
    _goalsummery = goalsummery;
}

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['league'] != null) {
      _league = [];
      json['league'].forEach((v) {
        _league?.add(League.fromJson(v));
      });
    }
    _rank = json['rank'] != null ? json['rank'].cast<int>() : [];
    _percentage = json['percentage'];
    _goalsummery = json['goalsummery'] != null ? Goalsummery.fromJson(json['goalsummery']) : null;
  }
  User? _user;
  List<League>? _league;
  List<int>? _rank;
  String? _percentage;
  Goalsummery? _goalsummery;

  User? get user => _user;
  List<League>? get league => _league;
  List<int>? get rank => _rank;
  String? get percentage => _percentage;
  Goalsummery? get goalsummery => _goalsummery;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_league != null) {
      map['league'] = _league?.map((v) => v.toJson()).toList();
    }
    map['rank'] = _rank;
    map['percentage'] = _percentage;
    if (_goalsummery != null) {
      map['goalsummery'] = _goalsummery?.toJson();
    }
    return map;
  }

}

/// total : 10
/// play : 21
/// type : "monthly"

Goalsummery goalsummeryFromJson(String str) => Goalsummery.fromJson(json.decode(str));
String goalsummeryToJson(Goalsummery data) => json.encode(data.toJson());
class Goalsummery {
  Goalsummery({
      int? total, 
      int? play, 
      String? type,}){
    _total = total;
    _play = play;
    _type = type;
}

  Goalsummery.fromJson(dynamic json) {
    _total = json['total'];
    _play = json['play'];
    _type = json['type'];
  }
  int? _total;
  int? _play;
  String? _type;

  int? get total => _total;
  int? get play => _play;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['play'] = _play;
    map['type'] = _type;
    return map;
  }

}

/// id : 1
/// title : "Expert"

League leagueFromJson(String str) => League.fromJson(json.decode(str));
String leagueToJson(League data) => json.encode(data.toJson());
class League {
  League({
      int? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  League.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
  }
  int? _id;
  String? _title;

  int? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    return map;
  }

}

/// title : "Initiate"
/// id : 5

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? title, 
      int? id,}){
    _title = title;
    _id = id;
}

  User.fromJson(dynamic json) {
    _title = json['title'];
    _id = json['id'];
  }
  String? _title;
  int? _id;

  String? get title => _title;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['id'] = _id;
    return map;
  }

}