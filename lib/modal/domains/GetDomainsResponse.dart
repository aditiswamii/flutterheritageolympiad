import 'dart:convert';
/// status : 200
/// message : "Domain data"
/// data : [{"id":10,"name":"Natural Environment","status":"1","created_at":"2021-10-13T09:24:06.000000Z","updated_at":"2022-04-16T06:07:22.000000Z","deleted_at":null,"themes_id":"2"},{"id":9,"name":"Built Spaces","status":"1","created_at":"2021-10-13T09:23:59.000000Z","updated_at":"2022-04-15T12:34:27.000000Z","deleted_at":null,"themes_id":"3"},{"id":8,"name":"People","status":"1","created_at":"2021-10-13T09:23:52.000000Z","updated_at":"2022-04-15T12:34:46.000000Z","deleted_at":null,"themes_id":"1"},{"id":7,"name":"Institutions","status":"1","created_at":"2021-10-13T09:23:45.000000Z","updated_at":"2022-04-15T12:34:58.000000Z","deleted_at":null,"themes_id":"1"},{"id":6,"name":"Histories","status":"1","created_at":"2021-10-13T09:23:37.000000Z","updated_at":"2022-04-15T12:35:07.000000Z","deleted_at":null,"themes_id":"1"},{"id":5,"name":"Visual and Material Arts","status":"1","created_at":"2021-10-13T09:23:31.000000Z","updated_at":"2022-04-15T12:35:23.000000Z","deleted_at":null,"themes_id":"3"},{"id":4,"name":"Practices and Rituals","status":"1","created_at":"2021-10-13T09:23:18.000000Z","updated_at":"2022-04-15T12:35:47.000000Z","deleted_at":null,"themes_id":"1"},{"id":3,"name":"Performing Arts","status":"1","created_at":"2021-10-13T09:23:10.000000Z","updated_at":"2022-04-15T12:36:07.000000Z","deleted_at":null,"themes_id":"1"},{"id":2,"name":"Languages and Literature","status":"1","created_at":"2021-10-13T09:23:02.000000Z","updated_at":"2022-04-15T12:36:23.000000Z","deleted_at":null,"themes_id":"1"},{"id":1,"name":"Knowledge Traditions","status":"1","created_at":"2021-10-13T09:22:43.000000Z","updated_at":"2022-04-15T12:36:38.000000Z","deleted_at":null,"themes_id":"1"}]

GetDomainsResponse getDomainsResponseFromJson(String str) => GetDomainsResponse.fromJson(json.decode(str));
String getDomainsResponseToJson(GetDomainsResponse data) => json.encode(data.toJson());
class GetDomainsResponse {
  GetDomainsResponse({
      int? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetDomainsResponse.fromJson(dynamic json) {
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

/// id : 10
/// name : "Natural Environment"
/// status : "1"
/// created_at : "2021-10-13T09:24:06.000000Z"
/// updated_at : "2022-04-16T06:07:22.000000Z"
/// deleted_at : null
/// themes_id : "2"

Data datadomainFromJson(String str) => Data.fromJson(json.decode(str));
String datadomainToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? id, 
      String? name, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      String? themesId,}){
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
  int? _id;
  String? _name;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  String? _themesId;

  int? get id => _id;
  String? get name => _name;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  String? get themesId => _themesId;

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