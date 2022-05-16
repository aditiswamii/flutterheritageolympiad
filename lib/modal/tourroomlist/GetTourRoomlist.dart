import 'dart:convert';
/// status : 200
/// remaningtimestamp : 120
/// data : [{"id":73,"name":"Jahan","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","image":"http://3.108.183.42/storage/images/6jYf4ZcEzpQZk2lnkKIJyPXLYbmQ0rx209ecolXp.jpg"}]
/// message : "TOurnament user list"

GetTourRoomlist getTourRoomlistFromJson(String str) => GetTourRoomlist.fromJson(json.decode(str));
String getTourRoomlistToJson(GetTourRoomlist data) => json.encode(data.toJson());
class GetTourRoomlist {
  GetTourRoomlist({
      int? status, 
      int? remaningtimestamp, 
      List<Data>? data, 
      String? message,}){
    _status = status;
    _remaningtimestamp = remaningtimestamp;
    _data = data;
    _message = message;
}

  GetTourRoomlist.fromJson(dynamic json) {
    _status = json['status'];
    _remaningtimestamp = json['remaningtimestamp'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _message = json['message'];
  }
  int? _status;
  int? _remaningtimestamp;
  List<Data>? _data;
  String? _message;

  int? get status => _status;
  int? get remaningtimestamp => _remaningtimestamp;
  List<Data>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['remaningtimestamp'] = _remaningtimestamp;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// id : 73
/// name : "Jahan"
/// age_group : "Group 4"
/// country : "India"
/// flag_icon : "http://3.108.183.42/flags/in.png"
/// image : "http://3.108.183.42/storage/images/6jYf4ZcEzpQZk2lnkKIJyPXLYbmQ0rx209ecolXp.jpg"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? id, 
      String? name, 
      String? ageGroup, 
      String? country, 
      String? flagIcon, 
      String? image,}){
    _id = id;
    _name = name;
    _ageGroup = ageGroup;
    _country = country;
    _flagIcon = flagIcon;
    _image = image;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _ageGroup = json['age_group'];
    _country = json['country'];
    _flagIcon = json['flag_icon'];
    _image = json['image'];
  }
  int? _id;
  String? _name;
  String? _ageGroup;
  String? _country;
  String? _flagIcon;
  String? _image;

  int? get id => _id;
  String? get name => _name;
  String? get ageGroup => _ageGroup;
  String? get country => _country;
  String? get flagIcon => _flagIcon;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['age_group'] = _ageGroup;
    map['country'] = _country;
    map['flag_icon'] = _flagIcon;
    map['image'] = _image;
    return map;
  }

}