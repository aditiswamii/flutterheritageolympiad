import 'dart:convert';
/// status : 200
/// data : {"dual_id":2188,"domain":"Knowledge Traditions,Languages and Literature,Performing Arts,Practices and Rituals,Visual and Material Arts,Histories,Institutions,People,Built Spaces,Natural Environment","quiz_speed":"Quickfire","difficulty":"Beginner","link":"cul.tre/duel#2188","image":"http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg","name":"neoaditi","created_date":"26-May-2022"}
/// message : "Dual data"

GetDualDetailResponse getDualDetailResponseFromJson(String str) => GetDualDetailResponse.fromJson(json.decode(str));
String getDualDetailResponseToJson(GetDualDetailResponse data) => json.encode(data.toJson());
class GetDualDetailResponse {
  GetDualDetailResponse({
      int? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetDualDetailResponse.fromJson(dynamic json) {
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

/// dual_id : 2188
/// domain : "Knowledge Traditions,Languages and Literature,Performing Arts,Practices and Rituals,Visual and Material Arts,Histories,Institutions,People,Built Spaces,Natural Environment"
/// quiz_speed : "Quickfire"
/// difficulty : "Beginner"
/// link : "cul.tre/duel#2188"
/// image : "http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg"
/// name : "neoaditi"
/// created_date : "26-May-2022"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? dualId, 
      String? domain, 
      String? quizSpeed, 
      String? difficulty, 
      String? link, 
      String? image, 
      String? name, 
      String? createdDate,}){
    _dualId = dualId;
    _domain = domain;
    _quizSpeed = quizSpeed;
    _difficulty = difficulty;
    _link = link;
    _image = image;
    _name = name;
    _createdDate = createdDate;
}

  Data.fromJson(dynamic json) {
    _dualId = json['dual_id'];
    _domain = json['domain'];
    _quizSpeed = json['quiz_speed'];
    _difficulty = json['difficulty'];
    _link = json['link'];
    _image = json['image'];
    _name = json['name'];
    _createdDate = json['created_date'];
  }
  int? _dualId;
  String? _domain;
  String? _quizSpeed;
  String? _difficulty;
  String? _link;
  String? _image;
  String? _name;
  String? _createdDate;

  int? get dualId => _dualId;
  String? get domain => _domain;
  String? get quizSpeed => _quizSpeed;
  String? get difficulty => _difficulty;
  String? get link => _link;
  String? get image => _image;
  String? get name => _name;
  String? get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dual_id'] = _dualId;
    map['domain'] = _domain;
    map['quiz_speed'] = _quizSpeed;
    map['difficulty'] = _difficulty;
    map['link'] = _link;
    map['image'] = _image;
    map['name'] = _name;
    map['created_date'] = _createdDate;
    return map;
  }

}