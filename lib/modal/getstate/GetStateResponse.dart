import 'dart:convert';
/// states : [{"name":"Andaman and Nicobar Islands","id":1},{"name":"Andhra Pradesh","id":2},{"name":"Arunachal Pradesh","id":3},{"name":"Assam","id":4},{"name":"Bihar","id":5},{"name":"Chandigarh","id":6},{"name":"Chhattisgarh","id":7},{"name":"Dadra and Nagar Haveli","id":8},{"name":"Daman and Diu","id":9},{"name":"Delhi","id":10},{"name":"Goa","id":11},{"name":"Gujarat","id":12},{"name":"Haryana","id":13},{"name":"Himachal Pradesh","id":14},{"name":"Jammu and Kashmir","id":15},{"name":"Jharkhand","id":16},{"name":"Karnataka","id":17},{"name":"Kenmore","id":18},{"name":"Kerala","id":19},{"name":"Lakshadweep","id":20},{"name":"Madhya Pradesh","id":21},{"name":"Maharashtra","id":22},{"name":"Manipur","id":23},{"name":"Meghalaya","id":24},{"name":"Mizoram","id":25},{"name":"Nagaland","id":26},{"name":"Narora","id":27},{"name":"Natwar","id":28},{"name":"Odisha","id":29},{"name":"Paschim Medinipur","id":30},{"name":"Pondicherry","id":31},{"name":"Punjab","id":32},{"name":"Rajasthan","id":33},{"name":"Sikkim","id":34},{"name":"Tamil Nadu","id":35},{"name":"Telangana","id":36},{"name":"Tripura","id":37},{"name":"Uttar Pradesh","id":38},{"name":"Uttarakhand","id":39},{"name":"Vaishali","id":40},{"name":"West Bengal","id":41}]

GetStateResponse getStateResponseFromJson(String str) => GetStateResponse.fromJson(json.decode(str));
String getStateResponseToJson(GetStateResponse data) => json.encode(data.toJson());
class GetStateResponse {
  GetStateResponse({
      List<States>? states,}){
    _states = states;
}

  GetStateResponse.fromJson(dynamic json) {
    if (json['states'] != null) {
      _states = [];
      json['states'].forEach((v) {
        _states?.add(States.fromJson(v));
      });
    }
  }
  List<States>? _states;

  List<States>? get states => _states;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_states != null) {
      map['states'] = _states?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Andaman and Nicobar Islands"
/// id : 1

States statesFromJson(String str) => States.fromJson(json.decode(str));
String statesToJson(States data) => json.encode(data.toJson());
class States {
  States({
      String? name, 
      int? id,}){
    _name = name;
    _id = id;
}

  States.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
  }
  String? _name;
  int? _id;

  String? get name => _name;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    return map;
  }

}