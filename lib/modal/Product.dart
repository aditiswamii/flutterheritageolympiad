/// status : 200
/// message : "no product found."
/// data : []

class Product {
  Product({
      required int status,
      required String message,
      required List<dynamic> data,}){
    _status = status;
    _message = message;
    _data = data;
}

  Product.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(Product.fromJson(v));
      });
    }
  }
  late int _status;
  late String _message;
  late List<dynamic> _data;

  int get status => _status;
  String get message => _message;
  List<dynamic> get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}