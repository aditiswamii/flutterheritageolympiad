import 'dart:convert';
/// status : 200
/// data : {"rank":[104,105,77,0,104,110,110,104,104]}
/// message : "Success"

GetLeaderboardRank getLeaderboardRankFromJson(String str) => GetLeaderboardRank.fromJson(json.decode(str));
String getLeaderboardRankToJson(GetLeaderboardRank data) => json.encode(data.toJson());
class GetLeaderboardRank {
  GetLeaderboardRank({
      int? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetLeaderboardRank.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  int? _status;
  Data? _data;
  String? _message;
GetLeaderboardRank copyWith({  int? status,
  Data? data,
  String? message,
}) => GetLeaderboardRank(  status: status ?? _status,
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

/// rank : [104,105,77,0,104,110,110,104,104]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      List<int>? rank,}){
    _rank = rank;
}

  Data.fromJson(dynamic json) {
    _rank = json['rank'] != null ? json['rank'].cast<int>() : [];
  }
  List<int>? _rank;
Data copyWith({  List<int>? rank,
}) => Data(  rank: rank ?? _rank,
);
  List<int>? get rank => _rank;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rank'] = _rank;
    return map;
  }

}