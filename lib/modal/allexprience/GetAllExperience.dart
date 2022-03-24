import 'dart:convert';
/// status : 200
/// message : "Experince Found"
/// data : [{"name":"Exp1","price":"₹ 100","description":"This Is Description For Exp 1","link":"Https://ap-south-1.console.aws.amazon.com/","images":["http://3.108.183.42/storage/exp/ZkQqiIR2sHkiC5NEnigzKRGCWPHUKz5XFQQIuzXi.png","http://3.108.183.42/storage/exp/YkZKSjhgN2SXgVdX3VmrKdc7sDBq59ipFvjAc7lx.png","http://3.108.183.42/storage/exp/RTkcbmcoVpkmP4Zam2jGX5dts1kyelYtHvGS2r40.png"]}]

GetAllExperience getAllExperienceFromJson(String str) => GetAllExperience.fromJson(json.decode(str));
String getAllExperienceToJson(GetAllExperience data) => json.encode(data.toJson());
class GetAllExperience {
  GetAllExperience({
      int? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetAllExperience.fromJson(dynamic json) {
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

/// name : "Exp1"
/// price : "₹ 100"
/// description : "This Is Description For Exp 1"
/// link : "Https://ap-south-1.console.aws.amazon.com/"
/// images : ["http://3.108.183.42/storage/exp/ZkQqiIR2sHkiC5NEnigzKRGCWPHUKz5XFQQIuzXi.png","http://3.108.183.42/storage/exp/YkZKSjhgN2SXgVdX3VmrKdc7sDBq59ipFvjAc7lx.png","http://3.108.183.42/storage/exp/RTkcbmcoVpkmP4Zam2jGX5dts1kyelYtHvGS2r40.png"]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? name, 
      String? price, 
      String? description, 
      String? link, 
      List<String>? images,}){
    _name = name;
    _price = price;
    _description = description;
    _link = link;
    _images = images;
}

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _price = json['price'];
    _description = json['description'];
    _link = json['link'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  String? _name;
  String? _price;
  String? _description;
  String? _link;
  List<String>? _images;

  String? get name => _name;
  String? get price => _price;
  String? get description => _description;
  String? get link => _link;
  List<String>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['price'] = _price;
    map['description'] = _description;
    map['link'] = _link;
    map['images'] = _images;
    return map;
  }

}