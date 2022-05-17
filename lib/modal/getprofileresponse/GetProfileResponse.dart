import 'dart:convert';
/// status : 200
/// data : {"first_name":"neoaditi","last_name":"neo","image":"http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg","email":"testtingho@mailsac.com","mobile":"1234567890","country":"Armenia","country_id":"11","state":"Shirak","state_id":"238","city":"Artik","city_id":"6542","gender":"female","dob":"01-09-1996"}
/// message : "User profile."

GetProfileResponse getProfileResponseFromJson(String str) => GetProfileResponse.fromJson(json.decode(str));
String getProfileResponseToJson(GetProfileResponse data) => json.encode(data.toJson());
class GetProfileResponse {
  GetProfileResponse({
      int? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetProfileResponse.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  int? _status;
  Data? _data;
  String? _message;

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

/// first_name : "neoaditi"
/// last_name : "neo"
/// image : "http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg"
/// email : "testtingho@mailsac.com"
/// mobile : "1234567890"
/// country : "Armenia"
/// country_id : "11"
/// state : "Shirak"
/// state_id : "238"
/// city : "Artik"
/// city_id : "6542"
/// gender : "female"
/// dob : "01-09-1996"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? firstName, 
      String? lastName, 
      String? image, 
      String? email, 
      String? mobile, 
      String? country, 
      String? countryId, 
      String? state, 
      String? stateId, 
      String? city, 
      String? cityId, 
      String? gender, 
      String? dob,}){
    _firstName = firstName;
    _lastName = lastName;
    _image = image;
    _email = email;
    _mobile = mobile;
    _country = country;
    _countryId = countryId;
    _state = state;
    _stateId = stateId;
    _city = city;
    _cityId = cityId;
    _gender = gender;
    _dob = dob;
}

  Data.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _image = json['image'];
    _email = json['email'];
    _mobile = json['mobile'];
    _country = json['country'];
    _countryId = json['country_id'];
    _state = json['state'];
    _stateId = json['state_id'];
    _city = json['city'];
    _cityId = json['city_id'];
    _gender = json['gender'];
    _dob = json['dob'];
  }
  String? _firstName;
  String? _lastName;
  String? _image;
  String? _email;
  String? _mobile;
  String? _country;
  String? _countryId;
  String? _state;
  String? _stateId;
  String? _city;
  String? _cityId;
  String? _gender;
  String? _dob;

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get image => _image;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get country => _country;
  String? get countryId => _countryId;
  String? get state => _state;
  String? get stateId => _stateId;
  String? get city => _city;
  String? get cityId => _cityId;
  String? get gender => _gender;
  String? get dob => _dob;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['image'] = _image;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['country'] = _country;
    map['country_id'] = _countryId;
    map['state'] = _state;
    map['state_id'] = _stateId;
    map['city'] = _city;
    map['city_id'] = _cityId;
    map['gender'] = _gender;
    map['dob'] = _dob;
    return map;
  }

}