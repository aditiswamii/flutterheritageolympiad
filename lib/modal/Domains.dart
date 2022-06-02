import 'dart:convert';
/// domain : [{"id":10,"name":"Natural Environment","issel":true}]

Domains domainsFromJson(String str) => Domains.fromJson(json.decode(str));
String domainsToJson(Domains data) => json.encode(data.toJson());
class Domains {
  Domains({
      List<Domain>? domain,}){
    _domain = domain;
}

  Domains.fromJson(dynamic json) {
    if (json['domain'] != null) {
      _domain = [];
      json['domain'].forEach((v) {
        _domain?.add(Domain.fromJson(v));
      });
    }
  }
  List<Domain>? _domain;
Domains copyWith({  List<Domain>? domain,
}) => Domains(  domain: domain ?? _domain,
);
  List<Domain>? get domain => _domain;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_domain != null) {
      map['domain'] = _domain?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 10
/// name : "Natural Environment"
/// issel : true

Domain domainFromJson(String str) => Domain.fromJson(json.decode(str));
String domainToJson(Domain data) => json.encode(data.toJson());
class Domain {
  Domain(int? id, String? name, bool? issel,){
    _id = id;
    _name = name;
    _issel = issel;
}

  Domain.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _issel = json['issel'];
  }
  int? _id;
  String? _name;
  bool? _issel;

  int? get id => _id;
  String? get name => _name;
  bool? get issel => _issel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['issel'] = _issel;
    return map;
  }
  set issel(bool? value) {
    _issel = value;
  }
}