import 'dart:convert';

/// status : 200
/// message : "Domain data"
/// data : [{"id":10,"name":"natural environment","status":"1","created_at":"2021-10-13T09:24:06.000000Z","updated_at":"2021-11-02T11:00:56.000000Z","deleted_at":null,"themes_id":"2"},{"id":9,"name":"built spaces","status":"1","created_at":"2021-10-13T09:23:59.000000Z","updated_at":"2021-11-02T11:01:26.000000Z","deleted_at":null,"themes_id":"3"},{"id":8,"name":"people","status":"1","created_at":"2021-10-13T09:23:52.000000Z","updated_at":"2021-10-13T09:23:52.000000Z","deleted_at":null,"themes_id":"1"},{"id":7,"name":"institutions","status":"1","created_at":"2021-10-13T09:23:45.000000Z","updated_at":"2021-10-13T09:23:45.000000Z","deleted_at":null,"themes_id":"1"},{"id":6,"name":"histories","status":"1","created_at":"2021-10-13T09:23:37.000000Z","updated_at":"2021-10-13T09:23:37.000000Z","deleted_at":null,"themes_id":"1"},{"id":5,"name":"visual & material arts","status":"1","created_at":"2021-10-13T09:23:31.000000Z","updated_at":"2021-11-02T11:01:39.000000Z","deleted_at":null,"themes_id":"3"},{"id":4,"name":"practices & rituals","status":"1","created_at":"2021-10-13T09:23:18.000000Z","updated_at":"2021-10-13T09:23:18.000000Z","deleted_at":null,"themes_id":"1"},{"id":3,"name":"performing arts","status":"1","created_at":"2021-10-13T09:23:10.000000Z","updated_at":"2021-10-13T09:23:10.000000Z","deleted_at":null,"themes_id":"1"},{"id":2,"name":"languages & literature","status":"1","created_at":"2021-10-13T09:23:02.000000Z","updated_at":"2021-10-13T09:23:02.000000Z","deleted_at":null,"themes_id":"1"},{"id":1,"name":"knowledge traditions","status":"1","created_at":"2021-10-13T09:22:43.000000Z","updated_at":"2021-10-13T09:22:43.000000Z","deleted_at":null,"themes_id":"1"}]

List<Data> DataFromJson(String str) =>
    List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));

String  DataToJson(List<Data> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Domains {
    int? _status;
    String? _message;
    List<Data>? _data;
  Domains({
      required int status,
      required String message,
      required List<Data> data,}){
    _status = status;
    _message = message;
    _data = data;
}

  Domains.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }


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

/// id : 10
/// name : "natural environment"
/// status : "1"
/// created_at : "2021-10-13T09:24:06.000000Z"
/// updated_at : "2021-11-02T11:00:56.000000Z"
/// deleted_at : null
/// themes_id : "2"

class Data {
  late int _id;
  late String _name;
  late String _status;
  late String _createdAt;
  late String _updatedAt;
  dynamic _deletedAt;
  late String _themesId;
  Data({
      required int id,
      required String name,
      required String status,
      required String createdAt,
      required String updatedAt,
      dynamic deletedAt, 
      required String themesId,}){
    _id = id;
    _name = name;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _themesId = themesId;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _themesId = json['themes_id'];
  }


  int get id => _id;
  String get name => _name;
  String get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  String get themesId => _themesId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['themes_id'] = _themesId;
    return map;
  }

}