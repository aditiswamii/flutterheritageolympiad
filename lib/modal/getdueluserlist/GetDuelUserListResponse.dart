import 'dart:convert';
/// status : 200
/// message : "all users"
/// data : [{"id":3,"name":"Tanishka","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Online","request":"0","image":""},{"id":74,"name":"Neoaditi","age_group":"Group 4","country":"Armenia","flag_icon":"http://3.108.183.42/flags/am.png","status":"Online","request":"0","image":"http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg"},{"id":75,"name":"Neo","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Online","request":"0","image":"http://3.108.183.42/storage/images/O6aa2UMYgRlkE8eXtaV1NerehMBnnqbprao7ewwd.jpg"},{"id":77,"name":"Tariq","age_group":"Group 3","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Online","request":"0","image":""},{"id":79,"name":"Amrita","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Online","request":"0","image":""},{"id":82,"name":"Ram","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Online","request":"0","image":""},{"id":116,"name":"Tinkerbell","age_group":"Group 4","country":"Argentina","flag_icon":"http://3.108.183.42/flags/ar.png","status":"Online","request":"0","image":"http://3.108.183.42/storage/images/IhFqlvUbMEyYLAHEu96ZCjubNjwQv64E9d7XFs5k.jpg"},{"id":125,"name":"Nimisha","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Online","request":"0","image":"http://3.108.183.42/storage/images/WUaWWzVeiGjHDFn6hHBjkrUKywumUfUuY43NCwmu.jpg"},{"id":130,"name":"Story","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Online","request":"0","image":"http://3.108.183.42/storage/images/PZ0dzwsrj52i6bKVZ6E7OSViizHWBYYPM8iSgqNm.jpg"},{"id":131,"name":"Tariq","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Busy","request":"0","image":"http://3.108.183.42/storage/images/Gl3Nodx2D4goVOmQ4xA41mX3FwZCqmZPMeXTQ38t.jpg"},{"id":134,"name":"Chandler","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Busy","request":"0","image":"http://3.108.183.42/storage/images/uDYrmZFcLJazKwLk2vdtH4yaP6eKTNeuYBfAf9TT.jpg"},{"id":136,"name":"Prerna","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Online","request":"0","image":"http://3.108.183.42/storage/images/saPKvSIaaNbvxlRovKtB99V0yXSYy1oa2QFxUAGH.jpg"},{"id":137,"name":"Tanu","age_group":"Group 4","country":"India","flag_icon":"http://3.108.183.42/flags/in.png","status":"Online","request":"0","image":"http://3.108.183.42/storage/images/s5ORlTioyV7yylcur4BjedxWatNAgfds3ZlJHa3d.jpg"}]

GetDuelUserListResponse getDuelUserListResponseFromJson(String str) => GetDuelUserListResponse.fromJson(json.decode(str));
String getDuelUserListResponseToJson(GetDuelUserListResponse data) => json.encode(data.toJson());
class GetDuelUserListResponse {
  GetDuelUserListResponse({
      int? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetDuelUserListResponse.fromJson(dynamic json) {
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

/// id : 3
/// name : "Tanishka"
/// age_group : "Group 4"
/// country : "India"
/// flag_icon : "http://3.108.183.42/flags/in.png"
/// status : "Online"
/// request : "0"
/// image : ""

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
      String? request, 
      String? image,}){
    _id = id;
    _name = name;
    _ageGroup = ageGroup;
    _country = country;
    _flagIcon = flagIcon;
    _status = status;
    _request = request;
    _image = image;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _ageGroup = json['age_group'];
    _country = json['country'];
    _flagIcon = json['flag_icon'];
    _status = json['status'];
    _request = json['request'];
    _image = json['image'];
  }
  int? _id;
  String? _name;
  String? _ageGroup;
  String? _country;
  String? _flagIcon;
  String? _status;
  String? _request;
  String? _image;

  int? get id => _id;
  String? get name => _name;
  String? get ageGroup => _ageGroup;
  String? get country => _country;
  String? get flagIcon => _flagIcon;
  String? get status => _status;
  String? get request => _request;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['age_group'] = _ageGroup;
    map['country'] = _country;
    map['flag_icon'] = _flagIcon;
    map['status'] = _status;
    map['request'] = _request;
    map['image'] = _image;
    return map;
  }

}