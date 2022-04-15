import 'dart:convert';
/// status : 200
/// message : "Authenticated Successfully."
/// token : "371|DONzlz0vqJQ8pCmAnejZC5A7rw9i8crwmPrNcykm"
/// profile_complete : "1"
/// age_group : "group 4"
/// user_id : 82
/// country : "India"
/// flag : "http://3.108.183.42/flags/in.png"
/// data : {"id":82,"name":"Ram","last_name":"Ram","email":"ram12@mailsac.com","email_verified_at":"2022-03-01T12:00:41.000000Z","type":"2","dob":"2000-04-14","mobile":"1234567890","is_social":"0","token":"fxEAuPygQTS4t-R-tUcxEU:APA91bGGtnPyf9DeXN3nepPckDFQYniHnjZaHRTX2dDiSjyyiQSlnxtAv9OsqeQH2bYsPvHCuQw4vunppPihToFIRp83W6FR8kvPFmx6zGj-u9hwFc4oLWw8yBWdUv0vKs04mA9H-wL3","app_id":null,"age":22,"mobile_verify_at":null,"created_at":"2022-03-01T12:00:41.000000Z","updated_at":"2022-04-15T05:26:47.000000Z","profile_complete":"1","state_id":"33","city_id":"3302","address":null,"username":"ram","gender":"male","subscribe_newslater":"1","profile_image":null,"refrence_code":"2371","device_id":"0","country":{"id":33,"name":"Rajasthan","country_id":"101","created_at":null,"updated_at":null,"country_name":{"id":101,"sortname":"IN","name":"India","phonecode":"91","created_at":null,"updated_at":null}}}

GetLoginResponse getLoginResponseFromJson(String str) => GetLoginResponse.fromJson(json.decode(str));
String getLoginResponseToJson(GetLoginResponse data) => json.encode(data.toJson());
class GetLoginResponse {
  GetLoginResponse({
      int? status, 
      String? message, 
      String? token, 
      String? profileComplete, 
      String? ageGroup, 
      int? userId, 
      String? country, 
      String? flag, 
      Data? data,}){
    _status = status;
    _message = message;
    _token = token;
    _profileComplete = profileComplete;
    _ageGroup = ageGroup;
    _userId = userId;
    _country = country;
    _flag = flag;
    _data = data;
}

  GetLoginResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _token = json['token'];
    _profileComplete = json['profile_complete'];
    _ageGroup = json['age_group'];
    _userId = json['user_id'];
    _country = json['country'];
    _flag = json['flag'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _status;
  String? _message;
  String? _token;
  String? _profileComplete;
  String? _ageGroup;
  int? _userId;
  String? _country;
  String? _flag;
  Data? _data;

  int? get status => _status;
  String? get message => _message;
  String? get token => _token;
  String? get profileComplete => _profileComplete;
  String? get ageGroup => _ageGroup;
  int? get userId => _userId;
  String? get country => _country;
  String? get flag => _flag;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['token'] = _token;
    map['profile_complete'] = _profileComplete;
    map['age_group'] = _ageGroup;
    map['user_id'] = _userId;
    map['country'] = _country;
    map['flag'] = _flag;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 82
/// name : "Ram"
/// last_name : "Ram"
/// email : "ram12@mailsac.com"
/// email_verified_at : "2022-03-01T12:00:41.000000Z"
/// type : "2"
/// dob : "2000-04-14"
/// mobile : "1234567890"
/// is_social : "0"
/// token : "fxEAuPygQTS4t-R-tUcxEU:APA91bGGtnPyf9DeXN3nepPckDFQYniHnjZaHRTX2dDiSjyyiQSlnxtAv9OsqeQH2bYsPvHCuQw4vunppPihToFIRp83W6FR8kvPFmx6zGj-u9hwFc4oLWw8yBWdUv0vKs04mA9H-wL3"
/// app_id : null
/// age : 22
/// mobile_verify_at : null
/// created_at : "2022-03-01T12:00:41.000000Z"
/// updated_at : "2022-04-15T05:26:47.000000Z"
/// profile_complete : "1"
/// state_id : "33"
/// city_id : "3302"
/// address : null
/// username : "ram"
/// gender : "male"
/// subscribe_newslater : "1"
/// profile_image : null
/// refrence_code : "2371"
/// device_id : "0"
/// country : {"id":33,"name":"Rajasthan","country_id":"101","created_at":null,"updated_at":null,"country_name":{"id":101,"sortname":"IN","name":"India","phonecode":"91","created_at":null,"updated_at":null}}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? id, 
      String? name, 
      String? lastName, 
      String? email, 
      String? emailVerifiedAt, 
      String? type, 
      String? dob, 
      String? mobile, 
      String? isSocial, 
      String? token, 
      dynamic appId, 
      int? age, 
      dynamic mobileVerifyAt, 
      String? createdAt, 
      String? updatedAt, 
      String? profileComplete, 
      String? stateId, 
      String? cityId, 
      dynamic address, 
      String? username, 
      String? gender, 
      String? subscribeNewslater, 
      dynamic profileImage, 
      String? refrenceCode, 
      String? deviceId, 
      Country? country,}){
    _id = id;
    _name = name;
    _lastName = lastName;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _type = type;
    _dob = dob;
    _mobile = mobile;
    _isSocial = isSocial;
    _token = token;
    _appId = appId;
    _age = age;
    _mobileVerifyAt = mobileVerifyAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _profileComplete = profileComplete;
    _stateId = stateId;
    _cityId = cityId;
    _address = address;
    _username = username;
    _gender = gender;
    _subscribeNewslater = subscribeNewslater;
    _profileImage = profileImage;
    _refrenceCode = refrenceCode;
    _deviceId = deviceId;
    _country = country;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _type = json['type'];
    _dob = json['dob'];
    _mobile = json['mobile'];
    _isSocial = json['is_social'];
    _token = json['token'];
    _appId = json['app_id'];
    _age = json['age'];
    _mobileVerifyAt = json['mobile_verify_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _profileComplete = json['profile_complete'];
    _stateId = json['state_id'];
    _cityId = json['city_id'];
    _address = json['address'];
    _username = json['username'];
    _gender = json['gender'];
    _subscribeNewslater = json['subscribe_newslater'];
    _profileImage = json['profile_image'];
    _refrenceCode = json['refrence_code'];
    _deviceId = json['device_id'];
    _country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }
  int? _id;
  String? _name;
  String? _lastName;
  String? _email;
  String? _emailVerifiedAt;
  String? _type;
  String? _dob;
  String? _mobile;
  String? _isSocial;
  String? _token;
  dynamic _appId;
  int? _age;
  dynamic _mobileVerifyAt;
  String? _createdAt;
  String? _updatedAt;
  String? _profileComplete;
  String? _stateId;
  String? _cityId;
  dynamic _address;
  String? _username;
  String? _gender;
  String? _subscribeNewslater;
  dynamic _profileImage;
  String? _refrenceCode;
  String? _deviceId;
  Country? _country;

  int? get id => _id;
  String? get name => _name;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get emailVerifiedAt => _emailVerifiedAt;
  String? get type => _type;
  String? get dob => _dob;
  String? get mobile => _mobile;
  String? get isSocial => _isSocial;
  String? get token => _token;
  dynamic get appId => _appId;
  int? get age => _age;
  dynamic get mobileVerifyAt => _mobileVerifyAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get profileComplete => _profileComplete;
  String? get stateId => _stateId;
  String? get cityId => _cityId;
  dynamic get address => _address;
  String? get username => _username;
  String? get gender => _gender;
  String? get subscribeNewslater => _subscribeNewslater;
  dynamic get profileImage => _profileImage;
  String? get refrenceCode => _refrenceCode;
  String? get deviceId => _deviceId;
  Country? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['email_verified_at'] = _emailVerifiedAt;
    map['type'] = _type;
    map['dob'] = _dob;
    map['mobile'] = _mobile;
    map['is_social'] = _isSocial;
    map['token'] = _token;
    map['app_id'] = _appId;
    map['age'] = _age;
    map['mobile_verify_at'] = _mobileVerifyAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['profile_complete'] = _profileComplete;
    map['state_id'] = _stateId;
    map['city_id'] = _cityId;
    map['address'] = _address;
    map['username'] = _username;
    map['gender'] = _gender;
    map['subscribe_newslater'] = _subscribeNewslater;
    map['profile_image'] = _profileImage;
    map['refrence_code'] = _refrenceCode;
    map['device_id'] = _deviceId;
    if (_country != null) {
      map['country'] = _country?.toJson();
    }
    return map;
  }

}

/// id : 33
/// name : "Rajasthan"
/// country_id : "101"
/// created_at : null
/// updated_at : null
/// country_name : {"id":101,"sortname":"IN","name":"India","phonecode":"91","created_at":null,"updated_at":null}

Country countryFromJson(String str) => Country.fromJson(json.decode(str));
String countryToJson(Country data) => json.encode(data.toJson());
class Country {
  Country({
      int? id, 
      String? name, 
      String? countryId, 
      dynamic createdAt, 
      dynamic updatedAt, 
      CountryName? countryName,}){
    _id = id;
    _name = name;
    _countryId = countryId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _countryName = countryName;
}

  Country.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _countryId = json['country_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _countryName = json['country_name'] != null ? CountryName.fromJson(json['countryName']) : null;
  }
  int? _id;
  String? _name;
  String? _countryId;
  dynamic _createdAt;
  dynamic _updatedAt;
  CountryName? _countryName;

  int? get id => _id;
  String? get name => _name;
  String? get countryId => _countryId;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  CountryName? get countryName => _countryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country_id'] = _countryId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_countryName != null) {
      map['country_name'] = _countryName?.toJson();
    }
    return map;
  }

}

/// id : 101
/// sortname : "IN"
/// name : "India"
/// phonecode : "91"
/// created_at : null
/// updated_at : null

CountryName countryNameFromJson(String str) => CountryName.fromJson(json.decode(str));
String countryNameToJson(CountryName data) => json.encode(data.toJson());
class CountryName {
  CountryName({
      int? id, 
      String? sortname, 
      String? name, 
      String? phonecode, 
      dynamic createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _sortname = sortname;
    _name = name;
    _phonecode = phonecode;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  CountryName.fromJson(dynamic json) {
    _id = json['id'];
    _sortname = json['sortname'];
    _name = json['name'];
    _phonecode = json['phonecode'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _sortname;
  String? _name;
  String? _phonecode;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;
  String? get sortname => _sortname;
  String? get name => _name;
  String? get phonecode => _phonecode;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sortname'] = _sortname;
    map['name'] = _name;
    map['phonecode'] = _phonecode;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}