import 'dart:convert';
/// status : 200
/// creator_id : 5
/// data : [{"id":5,"name":"Hurican","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Online","image":"http://3.108.183.42/storage/images/WwBKslklIn3UspsyegV0LRNuUU9amA96KqJQl57p.jpg"}]
/// message : "Quiz room users list"

Getroomuserlist getroomuserlistFromJson(String str) => Getroomuserlist.fromJson(json.decode(str));
String getroomuserlistToJson(Getroomuserlist data) => json.encode(data.toJson());
class Getroomuserlist {
  Getroomuserlist({
      int? status, 
      int? creatorId, 
      List<Data>? data, 
      String? message,}){
    _status = status;
    _creatorId = creatorId;
    _data = data;
    _message = message;
}

  Getroomuserlist.fromJson(dynamic json) {
    _status = json['status'];
    _creatorId = json['creator_id'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _message = json['message'];
  }
  int? _status;
  int? _creatorId;
  List<Data>? _data;
  String? _message;
Getroomuserlist copyWith({  int? status,
  int? creatorId,
  List<Data>? data,
  String? message,
}) => Getroomuserlist(  status: status ?? _status,
  creatorId: creatorId ?? _creatorId,
  data: data ?? _data,
  message: message ?? _message,
);
  int? get status => _status;
  int? get creatorId => _creatorId;
  List<Data>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['creator_id'] = _creatorId;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// id : 5
/// name : "Hurican"
/// age_group : "Group 4"
/// country : "India"
/// flag_icon : "http://3.108.183.42/flags/in.png"
/// status : "Online"
/// image : "http://3.108.183.42/storage/images/WwBKslklIn3UspsyegV0LRNuUU9amA96KqJQl57p.jpg"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? id, 
      String? name, 
      String? ageGroup, 
      String? country, 
      String? flagIcon, 
      String? status, 
      String? image,}){
    _id = id;
    _name = name;
    _ageGroup = ageGroup;
    _country = country;
    _flagIcon = flagIcon;
    _status = status;
    _image = image;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _ageGroup = json['age_group'];
    _country = json['country'];
    _flagIcon = json['flag_icon'];
    _status = json['status'];
    _image = json['image'];
  }
  int? _id;
  String? _name;
  String? _ageGroup;
  String? _country;
  String? _flagIcon;
  String? _status;
  String? _image;
Data copyWith({  int? id,
  String? name,
  String? ageGroup,
  String? country,
  String? flagIcon,
  String? status,
  String? image,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  ageGroup: ageGroup ?? _ageGroup,
  country: country ?? _country,
  flagIcon: flagIcon ?? _flagIcon,
  status: status ?? _status,
  image: image ?? _image,
);
  int? get id => _id;
  String? get name => _name;
  String? get ageGroup => _ageGroup;
  String? get country => _country;
  String? get flagIcon => _flagIcon;
  String? get status => _status;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['age_group'] = _ageGroup;
    map['country'] = _country;
    map['flag_icon'] = _flagIcon;
    map['status'] = _status;
    map['image'] = _image;
    return map;
  }

}