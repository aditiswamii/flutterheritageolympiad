import 'dart:convert';
/// status : 200
/// message : "Badge data"
/// data : [{"title":"Newbie quizzer","image":"http://3.108.183.42/storage/badgesimages/fourhundred/Newbiequizzer.png","description":"Congrats! You have completed first 50 quizzes","id":1}]

GetBadgeResponse getBadgeResponseFromJson(String str) => GetBadgeResponse.fromJson(json.decode(str));
String getBadgeResponseToJson(GetBadgeResponse data) => json.encode(data.toJson());
class GetBadgeResponse {
  GetBadgeResponse({
      int? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetBadgeResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _status;
  String? _message;
  List<Data>? _data;

  int? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// title : "Newbie quizzer"
/// image : "http://3.108.183.42/storage/badgesimages/fourhundred/Newbiequizzer.png"
/// description : "Congrats! You have completed first 50 quizzes"
/// id : 1

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? title, 
      String? image, 
      String? description, 
      int? id,}){
    _title = title;
    _image = image;
    _description = description;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _title = json['title'];
    _image = json['image'];
    _description = json['description'];
    _id = json['id'];
  }
  String? _title;
  String? _image;
  String? _description;
  int? _id;

  String? get title => _title;
  String? get image => _image;
  String? get description => _description;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['image'] = _image;
    map['description'] = _description;
    map['id'] = _id;
    return map;
  }

}