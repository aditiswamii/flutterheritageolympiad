// import 'dart:convert';
// /// quizroom : [{"quiz_room_id":2225,"is_start":"0","name":"neoaditi","id":1001,"image":"http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg","link":"cul.tre/quizroom#2225","domain":"Knowledge Traditions,Languages and Literature,Performing Arts","quiz_speed":"Quickfire","difficulty":"Beginner"}]
//
// QuizRoomResponse quizRoomResponseFromJson(String str) => QuizRoomResponse.fromJson(json.decode(str));
// String quizRoomResponseToJson(QuizRoomResponse data) => json.encode(data.toJson());
// class QuizRoomResponse {
//   QuizRoomResponse({
//       List<Quizroom>? quizroom,}){
//     _quizroom = quizroom;
// }
//
//   QuizRoomResponse.fromJson(dynamic json) {
//     if (json['quizroom'] != null) {
//       _quizroom = [];
//       json['quizroom'].forEach((v) {
//         _quizroom?.add(Quizroom.fromJson(v));
//       });
//     }
//   }
//   List<Quizroom>? _quizroom;
// QuizRoomResponse copyWith({  List<Quizroom>? quizroom,
// }) => QuizRoomResponse(  quizroom: quizroom ?? _quizroom,
// );
//   List<Quizroom>? get quizroom => _quizroom;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_quizroom != null) {
//       map['quizroom'] = _quizroom?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// quiz_room_id : 2225
// /// is_start : "0"
// /// name : "neoaditi"
// /// id : 1001
// /// image : "http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg"
// /// link : "cul.tre/quizroom#2225"
// /// domain : "Knowledge Traditions,Languages and Literature,Performing Arts"
// /// quiz_speed : "Quickfire"
// /// difficulty : "Beginner"
//
// Quizroom quizroomFromJson(String str) => Quizroom.fromJson(json.decode(str));
// String quizroomToJson(Quizroom data) => json.encode(data.toJson());
// class Quizroom {
//   Quizroom({
//       int? quizRoomId,
//       String? isStart,
//       String? name,
//       int? id,
//       String? image,
//       String? link,
//       String? domain,
//       String? quizSpeed,
//       String? difficulty,}){
//     _quizRoomId = quizRoomId;
//     _isStart = isStart;
//     _name = name;
//     _id = id;
//     _image = image;
//     _link = link;
//     _domain = domain;
//     _quizSpeed = quizSpeed;
//     _difficulty = difficulty;
// }
//
//   Quizroom.fromJson(dynamic json) {
//     _quizRoomId = json['quiz_room_id'];
//     _isStart = json['is_start'];
//     _name = json['name'];
//     _id = json['id'];
//     _image = json['image'];
//     _link = json['link'];
//     _domain = json['domain'];
//     _quizSpeed = json['quiz_speed'];
//     _difficulty = json['difficulty'];
//   }
//   int? _quizRoomId;
//   String? _isStart;
//   String? _name;
//   int? _id;
//   String? _image;
//   String? _link;
//   String? _domain;
//   String? _quizSpeed;
//   String? _difficulty;
// Quizroom copyWith({  int? quizRoomId,
//   String? isStart,
//   String? name,
//   int? id,
//   String? image,
//   String? link,
//   String? domain,
//   String? quizSpeed,
//   String? difficulty,
// }) => Quizroom(  quizRoomId: quizRoomId ?? _quizRoomId,
//   isStart: isStart ?? _isStart,
//   name: name ?? _name,
//   id: id ?? _id,
//   image: image ?? _image,
//   link: link ?? _link,
//   domain: domain ?? _domain,
//   quizSpeed: quizSpeed ?? _quizSpeed,
//   difficulty: difficulty ?? _difficulty,
// );
//   int? get quizRoomId => _quizRoomId;
//   String? get isStart => _isStart;
//   String? get name => _name;
//   int? get id => _id;
//   String? get image => _image;
//   String? get link => _link;
//   String? get domain => _domain;
//   String? get quizSpeed => _quizSpeed;
//   String? get difficulty => _difficulty;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['quiz_room_id'] = _quizRoomId;
//     map['is_start'] = _isStart;
//     map['name'] = _name;
//     map['id'] = _id;
//     map['image'] = _image;
//     map['link'] = _link;
//     map['domain'] = _domain;
//     map['quiz_speed'] = _quizSpeed;
//     map['difficulty'] = _difficulty;
//     return map;
//   }
//
// }