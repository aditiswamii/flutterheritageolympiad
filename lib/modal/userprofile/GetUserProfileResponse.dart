import 'dart:convert';
/// status : 200
/// message : "Profile data"
/// data : {"user":{"id":75,"name":"Neo","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Online","image":"http://3.108.183.42/storage/images/O6aa2UMYgRlkE8eXtaV1NerehMBnnqbprao7ewwd.jpg"},"contact":"{}","is_friend":0,"your_league":{"league_id":5,"league_name":"Initiate"}}

GetUserProfileResponse getUserProfileResponseFromJson(String str) => GetUserProfileResponse.fromJson(json.decode(str));
String getUserProfileResponseToJson(GetUserProfileResponse data) => json.encode(data.toJson());
class GetUserProfileResponse {
  GetUserProfileResponse({
      int? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetUserProfileResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _status;
  String? _message;
  Data? _data;

  int? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// user : {"id":75,"name":"Neo","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Online","image":"http://3.108.183.42/storage/images/O6aa2UMYgRlkE8eXtaV1NerehMBnnqbprao7ewwd.jpg"}
/// contact : "{}"
/// is_friend : 0
/// your_league : {"league_id":5,"league_name":"Initiate"}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      User? user, 
      String? contact, 
      int? isFriend, 
      YourLeague? yourLeague,}){
    _user = user;
    _contact = contact;
    _isFriend = isFriend;
    _yourLeague = yourLeague;
}

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _contact = json['contact'];
    _isFriend = json['is_friend'];
    _yourLeague = json['your_league'] != null ? YourLeague.fromJson(json['yourLeague']) : null;
  }
  User? _user;
  String? _contact;
  int? _isFriend;
  YourLeague? _yourLeague;

  User? get user => _user;
  String? get contact => _contact;
  int? get isFriend => _isFriend;
  YourLeague? get yourLeague => _yourLeague;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['contact'] = _contact;
    map['is_friend'] = _isFriend;
    if (_yourLeague != null) {
      map['your_league'] = _yourLeague?.toJson();
    }
    return map;
  }

}

/// league_id : 5
/// league_name : "Initiate"

YourLeague yourLeagueFromJson(String str) => YourLeague.fromJson(json.decode(str));
String yourLeagueToJson(YourLeague data) => json.encode(data.toJson());
class YourLeague {
  YourLeague({
      int? leagueId, 
      String? leagueName,}){
    _leagueId = leagueId;
    _leagueName = leagueName;
}

  YourLeague.fromJson(dynamic json) {
    _leagueId = json['league_id'];
    _leagueName = json['league_name'];
  }
  int? _leagueId;
  String? _leagueName;

  int? get leagueId => _leagueId;
  String? get leagueName => _leagueName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['league_id'] = _leagueId;
    map['league_name'] = _leagueName;
    return map;
  }

}

/// id : 75
/// name : "Neo"
/// age_group : "Group 4"
/// country : "India"
/// flag_icon : "http://3.108.183.42/flags/in.png"
/// status : "Online"
/// image : "http://3.108.183.42/storage/images/O6aa2UMYgRlkE8eXtaV1NerehMBnnqbprao7ewwd.jpg"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      int? id, 
      String? name, 
      String? ageGroup, 
      String? country, 
      String? flagIcon, 
      String? status, 
      String? image,}){
    _id = id;
    _name = name;
    _ageGroup = ageGroup;
    _country = country;
    _flagIcon = flagIcon;
    _status = status;
    _image = image;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _ageGroup = json['age_group'];
    _country = json['country'];
    _flagIcon = json['flag_icon'];
    _status = json['status'];
    _image = json['image'];
  }
  int? _id;
  String? _name;
  String? _ageGroup;
  String? _country;
  String? _flagIcon;
  String? _status;
  String? _image;

  int? get id => _id;
  String? get name => _name;
  String? get ageGroup => _ageGroup;
  String? get country => _country;
  String? get flagIcon => _flagIcon;
  String? get status => _status;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['age_group'] = _ageGroup;
    map['country'] = _country;
    map['flag_icon'] = _flagIcon;
    map['status'] = _status;
    map['image'] = _image;
    return map;
  }

}