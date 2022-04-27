import 'dart:convert';
/// status : 200
/// message : "Quiz created successfully"
/// data : {"user_id":"2","quiz_type_id":"1","difficulty_level_id":"1","quiz_speed_id":"1","updated_at":"2022-04-27T06:44:08.000000Z","created_at":"2022-04-27T06:44:08.000000Z","id":1151}

CreateQuizResponse createQuizResponseFromJson(String str) => CreateQuizResponse.fromJson(json.decode(str));
String createQuizResponseToJson(CreateQuizResponse data) => json.encode(data.toJson());
class CreateQuizResponse {
  CreateQuizResponse({
      int? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  CreateQuizResponse.fromJson(dynamic json) {
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

/// user_id : "2"
/// quiz_type_id : "1"
/// difficulty_level_id : "1"
/// quiz_speed_id : "1"
/// updated_at : "2022-04-27T06:44:08.000000Z"
/// created_at : "2022-04-27T06:44:08.000000Z"
/// id : 1151

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? userId, 
      String? quizTypeId, 
      String? difficultyLevelId, 
      String? quizSpeedId, 
      String? updatedAt, 
      String? createdAt, 
      int? id,}){
    _userId = userId;
    _quizTypeId = quizTypeId;
    _difficultyLevelId = difficultyLevelId;
    _quizSpeedId = quizSpeedId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _quizTypeId = json['quiz_type_id'];
    _difficultyLevelId = json['difficulty_level_id'];
    _quizSpeedId = json['quiz_speed_id'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _userId;
  String? _quizTypeId;
  String? _difficultyLevelId;
  String? _quizSpeedId;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  String? get userId => _userId;
  String? get quizTypeId => _quizTypeId;
  String? get difficultyLevelId => _difficultyLevelId;
  String? get quizSpeedId => _quizSpeedId;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['quiz_type_id'] = _quizTypeId;
    map['difficulty_level_id'] = _difficultyLevelId;
    map['quiz_speed_id'] = _quizSpeedId;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}