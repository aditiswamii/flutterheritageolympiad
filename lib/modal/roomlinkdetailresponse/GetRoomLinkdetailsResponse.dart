import 'dart:convert';
/// status : 200
/// data : {"quiz_room_id":2324,"domain":"Knowledge Traditions,Languages and Literature,Performing Arts","quiz_speed":"Quickfire","difficulty":"Beginner","link":"cul.tre/quizroom#2324","image":"http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg","name":"neoaditi","created_date":"27-May-2022"}
/// message : "Dual data"

GetRoomLinkdetailsResponse getRoomLinkdetailsResponseFromJson(String str) => GetRoomLinkdetailsResponse.fromJson(json.decode(str));
String getRoomLinkdetailsResponseToJson(GetRoomLinkdetailsResponse data) => json.encode(data.toJson());
class GetRoomLinkdetailsResponse {
  GetRoomLinkdetailsResponse({
      int? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetRoomLinkdetailsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  int? _status;
  Data? _data;
  String? _message;
GetRoomLinkdetailsResponse copyWith({  int? status,
  Data? data,
  String? message,
}) => GetRoomLinkdetailsResponse(  status: status ?? _status,
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

/// quiz_room_id : 2324
/// domain : "Knowledge Traditions,Languages and Literature,Performing Arts"
/// quiz_speed : "Quickfire"
/// difficulty : "Beginner"
/// link : "cul.tre/quizroom#2324"
/// image : "http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg"
/// name : "neoaditi"
/// created_date : "27-May-2022"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? quizRoomId, 
      String? domain, 
      String? quizSpeed, 
      String? difficulty, 
      String? link, 
      String? image, 
      String? name, 
      String? createdDate,}){
    _quizRoomId = quizRoomId;
    _domain = domain;
    _quizSpeed = quizSpeed;
    _difficulty = difficulty;
    _link = link;
    _image = image;
    _name = name;
    _createdDate = createdDate;
}

  Data.fromJson(dynamic json) {
    _quizRoomId = json['quiz_room_id'];
    _domain = json['domain'];
    _quizSpeed = json['quiz_speed'];
    _difficulty = json['difficulty'];
    _link = json['link'];
    _image = json['image'];
    _name = json['name'];
    _createdDate = json['created_date'];
  }
  int? _quizRoomId;
  String? _domain;
  String? _quizSpeed;
  String? _difficulty;
  String? _link;
  String? _image;
  String? _name;
  String? _createdDate;
Data copyWith({  int? quizRoomId,
  String? domain,
  String? quizSpeed,
  String? difficulty,
  String? link,
  String? image,
  String? name,
  String? createdDate,
}) => Data(  quizRoomId: quizRoomId ?? _quizRoomId,
  domain: domain ?? _domain,
  quizSpeed: quizSpeed ?? _quizSpeed,
  difficulty: difficulty ?? _difficulty,
  link: link ?? _link,
  image: image ?? _image,
  name: name ?? _name,
  createdDate: createdDate ?? _createdDate,
);
  int? get quizRoomId => _quizRoomId;
  String? get domain => _domain;
  String? get quizSpeed => _quizSpeed;
  String? get difficulty => _difficulty;
  String? get link => _link;
  String? get image => _image;
  String? get name => _name;
  String? get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quiz_room_id'] = _quizRoomId;
    map['domain'] = _domain;
    map['quiz_speed'] = _quizSpeed;
    map['difficulty'] = _difficulty;
    map['link'] = _link;
    map['image'] = _image;
    map['name'] = _name;
    map['created_date'] = _createdDate;
    return map;
  }

}