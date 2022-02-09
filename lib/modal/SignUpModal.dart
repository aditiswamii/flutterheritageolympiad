/// status : 200
/// profile_complete : "1"
/// message : "User updated successfully"
/// data : {"id":1,"name":"Virendra","last_name":"Singh","email":"admin@gmail.com","email_verified_at":null,"type":"2","dob":"1994-06-14","mobile":null,"is_social":"0","token":null,"app_id":null,"age":27,"mobile_verify_at":null,"created_at":null,"updated_at":"2022-02-09T06:50:15.000000Z","profile_complete":"1","state_id":"33","city_id":"3332","address":null,"username":null,"gender":null,"subscribe_newslater":"1","profile_image":null,"refrence_code":"3213","country":{"id":33,"name":"Rajasthan","country_id":"101","created_at":null,"updated_at":null,"country_name":{"id":101,"sortname":"IN","name":"India","phonecode":"91","created_at":null,"updated_at":null}}}
/// age_group : "group 4"
/// country : "India"
/// flag : "http://3.108.183.42/flags/in.png"

class SignUpModal {
  SignUpModal({
      required int status,
      required String profileComplete,
      required String message,
      required Data data,
      required String ageGroup,
      required String country,
      required String flag,}){
    _status = status;
    _profileComplete = profileComplete;
    _message = message;
    _data = data;
    _ageGroup = ageGroup;
    _country = country;
    _flag = flag;
}

  SignUpModal.fromJson(dynamic json) {
    _status = json['status'];
    _profileComplete = json['profile_complete'];
    _message = json['message'];
    _data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
    _ageGroup = json['age_group'];
    _country = json['country'];
    _flag = json['flag'];
  }
  late int _status;
  late String _profileComplete;
  late String _message;
  late Data _data;
  late  String _ageGroup;
  late  String _country;
  late  String _flag;

  int get status => _status;
  String get profileComplete => _profileComplete;
  String get message => _message;
  Data get data => _data;
  String get ageGroup => _ageGroup;
  String get country => _country;
  String get flag => _flag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['profile_complete'] = _profileComplete;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    map['age_group'] = _ageGroup;
    map['country'] = _country;
    map['flag'] = _flag;
    return map;
  }

}


class Data {
  Data({
      required int id,
      required String name,
      required String lastName,
      required String email,
      dynamic emailVerifiedAt,
      required String type,
      required String dob,
      dynamic mobile,
      required String isSocial,
      dynamic token,
      dynamic appId,
      required int age,
      dynamic mobileVerifyAt,
      dynamic createdAt,
      required String updatedAt,
      required String profileComplete,
      required String stateId,
      required String cityId,
      dynamic address,
      dynamic username,
      dynamic gender,
      required String subscribeNewslater,
      dynamic profileImage,
      required String refrenceCode,
      required Country country,}){
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
    _country = (json['country'] != null ? Country.fromJson(json['country']) : null)!;
  }
  late  int _id;
  late  String _name;
  late  String _lastName;
  late  String _email;
  late  dynamic _emailVerifiedAt;
  late  String _type;
  late  String _dob;
  late  dynamic _mobile;
  late  String _isSocial;
  late  dynamic _token;
  late   dynamic _appId;
  late  int _age;
  late  dynamic _mobileVerifyAt;
  late  dynamic _createdAt;
  late  String _updatedAt;
  late  String _profileComplete;
  late  String _stateId;
  late  String _cityId;
  late  dynamic _address;
  late  dynamic _username;
  dynamic _gender;
  late  String _subscribeNewslater;
  late  dynamic _profileImage;
  late  String _refrenceCode;
  late  Country _country;

  int get id => _id;
  String get name => _name;
  String get lastName => _lastName;
  String get email => _email;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String get type => _type;
  String get dob => _dob;
  dynamic get mobile => _mobile;
  String get isSocial => _isSocial;
  dynamic get token => _token;
  dynamic get appId => _appId;
  int get age => _age;
  dynamic get mobileVerifyAt => _mobileVerifyAt;
  dynamic get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get profileComplete => _profileComplete;
  String get stateId => _stateId;
  String get cityId => _cityId;
  dynamic get address => _address;
  dynamic get username => _username;
  dynamic get gender => _gender;
  String get subscribeNewslater => _subscribeNewslater;
  dynamic get profileImage => _profileImage;
  String get refrenceCode => _refrenceCode;
  Country get country => _country;

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
    if (_country != null) {
      map['country'] = _country.toJson();
    }
    return map;
  }

}


class Country {
  Country({
      required int id,
      required String name,
      required String countryId,
      dynamic createdAt,
      dynamic updatedAt,
      required CountryName countryName,}){
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
    _countryName = (json['country_name'] != null ? CountryName.fromJson(json['countryName']) : null)!;
  }
  late  int _id;
  late  String _name;
  late String _countryId;
  late dynamic _createdAt;
  late  dynamic _updatedAt;
  late  CountryName _countryName;

  int get id => _id;
  String get name => _name;
  String get countryId => _countryId;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  CountryName get countryName => _countryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country_id'] = _countryId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_countryName != null) {
      map['country_name'] = _countryName.toJson();
    }
    return map;
  }

}

class CountryName {
  CountryName({
      required int id,
      required String sortname,
      required String name,
      required String phonecode,
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
  late int _id;
  late String _sortname;
  late  String _name;
  late  String _phonecode;
  late  dynamic _createdAt;
  late  dynamic _updatedAt;

  int get id => _id;
  String get sortname => _sortname;
  String get name => _name;
  String get phonecode => _phonecode;
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