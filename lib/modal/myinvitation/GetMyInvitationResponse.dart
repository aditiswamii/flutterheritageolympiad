import 'dart:convert';
/// status : 200
/// data : {"quizroom_start":[],"accept":[{"id":2209}],"dual":[],"quizroom":[],"contact":[]}
/// message : "Data"

GetMyInvitationResponse getMyInvitationResponseFromJson(String str) => GetMyInvitationResponse.fromJson(json.decode(str));
String getMyInvitationResponseToJson(GetMyInvitationResponse data) => json.encode(data.toJson());
class GetMyInvitationResponse {
  GetMyInvitationResponse({
      int? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetMyInvitationResponse.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  int? _status;
  Data? _data;
  String? _message;
GetMyInvitationResponse copyWith({  int? status,
  Data? data,
  String? message,
}) => GetMyInvitationResponse(  status: status ?? _status,
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

/// quizroom_start : []
/// accept : [{"id":2209}]
/// dual : []
/// quizroom : []
/// contact : []

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      List<dynamic>? quizroomStart, 
      List<Accept>? accept, 
      List<dynamic>? dual, 
      List<dynamic>? quizroom, 
      List<dynamic>? contact,}){
    _quizroomStart = quizroomStart;
    _accept = accept;
    _dual = dual;
    _quizroom = quizroom;
    _contact = contact;
}

  Data.fromJson(dynamic json) {
    if (json['quizroom_start'] != null) {
      _quizroomStart = [];
      json['quizroom_start'].forEach((v) {
        _quizroomStart?.add(Dynamic.fromJson(v));
      });
    }
    if (json['accept'] != null) {
      _accept = [];
      json['accept'].forEach((v) {
        _accept?.add(Accept.fromJson(v));
      });
    }
    if (json['dual'] != null) {
      _dual = [];
      json['dual'].forEach((v) {
        _dual?.add(Dynamic.fromJson(v));
      });
    }
    if (json['quizroom'] != null) {
      _quizroom = [];
      json['quizroom'].forEach((v) {
        _quizroom?.add(Dynamic.fromJson(v));
      });
    }
    if (json['contact'] != null) {
      _contact = [];
      json['contact'].forEach((v) {
        _contact?.add(Dynamic.fromJson(v));
      });
    }
  }
  List<dynamic>? _quizroomStart;
  List<Accept>? _accept;
  List<dynamic>? _dual;
  List<dynamic>? _quizroom;
  List<dynamic>? _contact;
Data copyWith({  List<dynamic>? quizroomStart,
  List<Accept>? accept,
  List<dynamic>? dual,
  List<dynamic>? quizroom,
  List<dynamic>? contact,
}) => Data(  quizroomStart: quizroomStart ?? _quizroomStart,
  accept: accept ?? _accept,
  dual: dual ?? _dual,
  quizroom: quizroom ?? _quizroom,
  contact: contact ?? _contact,
);
  List<dynamic>? get quizroomStart => _quizroomStart;
  List<Accept>? get accept => _accept;
  List<dynamic>? get dual => _dual;
  List<dynamic>? get quizroom => _quizroom;
  List<dynamic>? get contact => _contact;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_quizroomStart != null) {
      map['quizroom_start'] = _quizroomStart?.map((v) => v.toJson()).toList();
    }
    if (_accept != null) {
      map['accept'] = _accept?.map((v) => v.toJson()).toList();
    }
    if (_dual != null) {
      map['dual'] = _dual?.map((v) => v.toJson()).toList();
    }
    if (_quizroom != null) {
      map['quizroom'] = _quizroom?.map((v) => v.toJson()).toList();
    }
    if (_contact != null) {
      map['contact'] = _contact?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2209

Accept acceptFromJson(String str) => Accept.fromJson(json.decode(str));
String acceptToJson(Accept data) => json.encode(data.toJson());
class Accept {
  Accept({
      int? id,}){
    _id = id;
}

  Accept.fromJson(dynamic json) {
    _id = json['id'];
  }
  int? _id;
Accept copyWith({  int? id,
}) => Accept(  id: id ?? _id,
);
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    return map;
  }

}