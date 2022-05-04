import 'dart:convert';
/// status : 200
/// message : "Result saved succesfully"
/// data : {"quiz_id":"1339","xp":6,"per":"14"}

SaveResultResponse saveResultResponseFromJson(String str) => SaveResultResponse.fromJson(json.decode(str));
String saveResultResponseToJson(SaveResultResponse data) => json.encode(data.toJson());
class SaveResultResponse {
  SaveResultResponse({
      int? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  SaveResultResponse.fromJson(dynamic json) {
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

/// quiz_id : "1339"
/// xp : 6
/// per : "14"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? quizId, 
      int? xp, 
      String? per,}){
    _quizId = quizId;
    _xp = xp;
    _per = per;
}

  Data.fromJson(dynamic json) {
    _quizId = json['quiz_id'];
    _xp = json['xp'];
    _per = json['per'];
  }
  String? _quizId;
  int? _xp;
  String? _per;

  String? get quizId => _quizId;
  int? get xp => _xp;
  String? get per => _per;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quiz_id'] = _quizId;
    map['xp'] = _xp;
    map['per'] = _per;
    return map;
  }

}