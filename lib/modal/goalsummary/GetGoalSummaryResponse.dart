import 'dart:convert';
/// status : 200
/// message : "Goal set succesfully"
/// data : {"total":10,"play":28,"type":"monthly"}

GetGoalSummaryResponse getGoalSummaryResponseFromJson(String str) => GetGoalSummaryResponse.fromJson(json.decode(str));
String getGoalSummaryResponseToJson(GetGoalSummaryResponse data) => json.encode(data.toJson());
class GetGoalSummaryResponse {
  GetGoalSummaryResponse({
      int? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetGoalSummaryResponse.fromJson(dynamic json) {
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

/// total : 10
/// play : 28
/// type : "monthly"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? total, 
      int? play, 
      String? type,}){
    _total = total;
    _play = play;
    _type = type;
}

  Data.fromJson(dynamic json) {
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