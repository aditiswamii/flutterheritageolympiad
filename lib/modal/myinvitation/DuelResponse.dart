// import 'dart:convert';
// /// dual : [{"dual_id":2224,"name":"neoaditi","id":1000,"image":"http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg","link":"cul.tre/duel#2224","domain":"Knowledge Traditions,Languages and Literature,Performing Arts,Practices and Rituals,Visual and Material Arts,Histories,Institutions,People,Built Spaces,Natural Environment","quiz_speed":"Quickfire","difficulty":"Beginner"}]
//
// DuelResponse duelResponseFromJson(String str) => DuelResponse.fromJson(json.decode(str));
// String duelResponseToJson(DuelResponse data) => json.encode(data.toJson());
// class DuelResponse {
//   DuelResponse({
//       List<Dual>? dual,}){
//     _dual = dual;
// }
//
//   DuelResponse.fromJson(dynamic json) {
//     if (json['dual'] != null) {
//       _dual = [];
//       json['dual'].forEach((v) {
//         _dual?.add(Dual.fromJson(v));
//       });
//     }
//   }
//   List<Dual>? _dual;
// DuelResponse copyWith({  List<Dual>? dual,
// }) => DuelResponse(  dual: dual ?? _dual,
// );
//   List<Dual>? get dual => _dual;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_dual != null) {
//       map['dual'] = _dual?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// dual_id : 2224
// /// name : "neoaditi"
// /// id : 1000
// /// image : "http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg"
// /// link : "cul.tre/duel#2224"
// /// domain : "Knowledge Traditions,Languages and Literature,Performing Arts,Practices and Rituals,Visual and Material Arts,Histories,Institutions,People,Built Spaces,Natural Environment"
// /// quiz_speed : "Quickfire"
// /// difficulty : "Beginner"
//
// Dual dualFromJson(String str) => Dual.fromJson(json.decode(str));
// String dualToJson(Dual data) => json.encode(data.toJson());
// class Dual {
//   Dual({
//       int? dualId,
//       String? name,
//       int? id,
//       String? image,
//       String? link,
//       String? domain,
//       String? quizSpeed,
//       String? difficulty,}){
//     _dualId = dualId;
//     _name = name;
//     _id = id;
//     _image = image;
//     _link = link;
//     _domain = domain;
//     _quizSpeed = quizSpeed;
//     _difficulty = difficulty;
// }
//
//   Dual.fromJson(dynamic json) {
//     _dualId = json['dual_id'];
//     _name = json['name'];
//     _id = json['id'];
//     _image = json['image'];
//     _link = json['link'];
//     _domain = json['domain'];
//     _quizSpeed = json['quiz_speed'];
//     _difficulty = json['difficulty'];
//   }
//   int? _dualId;
//   String? _name;
//   int? _id;
//   String? _image;
//   String? _link;
//   String? _domain;
//   String? _quizSpeed;
//   String? _difficulty;
// Dual copyWith({  int? dualId,
//   String? name,
//   int? id,
//   String? image,
//   String? link,
//   String? domain,
//   String? quizSpeed,
//   String? difficulty,
// }) => Dual(  dualId: dualId ?? _dualId,
//   name: name ?? _name,
//   id: id ?? _id,
//   image: image ?? _image,
//   link: link ?? _link,
//   domain: domain ?? _domain,
//   quizSpeed: quizSpeed ?? _quizSpeed,
//   difficulty: difficulty ?? _difficulty,
// );
//   int? get dualId => _dualId;
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
//     map['dual_id'] = _dualId;
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
