import 'dart:convert';
/// status : 200
/// message : "Dual Created"
/// data : {"dual_id":1856,"user":"Neoaditi","domain":[{"id":1,"name":"Knowledge Traditions"},{"id":2,"name":"Languages and Literature"},{"id":3,"name":"Performing Arts"}],"quiz_speed":"Quickfire","difficulty":"Beginner","quiz_type":"Duel","created_date":"20-May-2022"}

CreateDuelResponse createDuelResponseFromJson(String str) => CreateDuelResponse.fromJson(json.decode(str));
String createDuelResponseToJson(CreateDuelResponse data) => json.encode(data.toJson());
class CreateDuelResponse {
  CreateDuelResponse({
      int? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  CreateDuelResponse.fromJson(dynamic json) {
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

/// dual_id : 1856
/// user : "Neoaditi"
/// domain : [{"id":1,"name":"Knowledge Traditions"},{"id":2,"name":"Languages and Literature"},{"id":3,"name":"Performing Arts"}]
/// quiz_speed : "Quickfire"
/// difficulty : "Beginner"
/// quiz_type : "Duel"
/// created_date : "20-May-2022"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? dualId, 
      String? user, 
      List<Domain>? domain, 
      String? quizSpeed, 
      String? difficulty, 
      String? quizType, 
      String? createdDate,}){
    _dualId = dualId;
    _user = user;
    _domain = domain;
    _quizSpeed = quizSpeed;
    _difficulty = difficulty;
    _quizType = quizType;
    _createdDate = createdDate;
}

  Data.fromJson(dynamic json) {
    _dualId = json['dual_id'];
    _user = json['user'];
    if (json['domain'] != null) {
      _domain = [];
      json['domain'].forEach((v) {
        _domain?.add(Domain.fromJson(v));
      });
    }
    _quizSpeed = json['quiz_speed'];
    _difficulty = json['difficulty'];
    _quizType = json['quiz_type'];
    _createdDate = json['created_date'];
  }
  int? _dualId;
  String? _user;
  List<Domain>? _domain;
  String? _quizSpeed;
  String? _difficulty;
  String? _quizType;
  String? _createdDate;

  int? get dualId => _dualId;
  String? get user => _user;
  List<Domain>? get domain => _domain;
  String? get quizSpeed => _quizSpeed;
  String? get difficulty => _difficulty;
  String? get quizType => _quizType;
  String? get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dual_id'] = _dualId;
    map['user'] = _user;
    if (_domain != null) {
      map['domain'] = _domain?.map((v) => v.toJson()).toList();
    }
    map['quiz_speed'] = _quizSpeed;
    map['difficulty'] = _difficulty;
    map['quiz_type'] = _quizType;
    map['created_date'] = _createdDate;
    return map;
  }

}

/// id : 1
/// name : "Knowledge Traditions"

Domain domainFromJson(String str) => Domain.fromJson(json.decode(str));
String domainToJson(Domain data) => json.encode(data.toJson());
class Domain {
  Domain({
      int? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Domain.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}