import 'dart:convert';
/// id : ""
/// name : ""
/// status : 0
/// phone : []
class PhoneContact {
  PhoneContact({
      String? id, 
      String? name, 
      int? status, 
      List<String>? phone,}){
    _id = id;
    _name = name;
    _status = status;
    _phone = phone;
}


  String? _id;
  String? _name;
  int? _status;
  List<String>? _phone;

  String? get id => _id;
  String? get name => _name;
  int? get status => _status;
  List<String>? get phone => _phone;

  set id(String? value) {
    _id = value;
  }
  set name(String? value) {
    _name = value;
  }
  set status(int? value) {
    _status = value;
  }
  set phone(List<String>? value) {
    _phone = value;
  }



}