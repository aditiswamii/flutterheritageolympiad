import 'dart:convert';
/// status : 200
/// message : "Feed data"
/// last_id : 93
/// data : [{"id":52,"type":"Single Posts","tags":["Calico Museum"," Textile"," Gujarat"," Ahmedabad"," Sarabhai"," Ananda Coomaraswamy"," Jawahar Lal Nehru"],"title":"Calico Museum of Textiles","description":"The Calico Museum of Textiles houses one of the most important collections of textiles in the country - ranging from ancient textiles, carpets, and tents to costumes, Kalamkari prints, tie and dye, pichwais, and sarees. It also holds an assemblage of bronzes, Jain art objects, and Indian miniature paintings acquired from the Sarabhai Foundation. This museum was inspired by the pioneering art historian and philosopher Dr. Ananda Coomaraswamy. It was his suggestion to Gautam Sarabhai, chairman of the Calico Mills of Ahmedabad, that a textile museum and an institute be founded in the city, as it had been one of India’s leading textile production and trade centers since the 15th century. In 1949, the textile museum was founded by Gautam Sarabhai with the assistance of his sister Gira Sarabhai, and was inaugurated by Jawaharlal Nehru, India’s first prime minister.","external_link":"https://www.museumsofindia.org/museum/218/calico-m","video_link":"","placeholder_image":"http://3.108.183.42/storage/","savepost":0,"is_saved":0,"share":"http://3.108.183.42/feed/52","media_type":"0","media":["http://3.108.183.42/storage/feed/rINk5SB8IMV8Oj1eDB60WmwHS6cWnB04nyF3ro4i.png","http://3.108.183.42/storage/feed/cNzH6cb1pMligFPvyadNvl6nQHUMnx6tWPbPkPHv.png"]},{"id":93,"type":"Single Posts","tags":["Textiles"," Block Printing"," Dyeing"," Ajrakh"," Patterns"],"title":"Motif-making method for traditional textiles","description":"In traditional dyeing and printing, a 'mordant' (or absorbing agent) is applied to receive colour, and a 'resist' (or blocking agent) to repel it. Sometimes, mordant and resist processes are repeated several times to produce a complex, layered pattern of many colours, for example in Ajrakh, or in double or triple Dabu, the mud-resist technique.","external_link":"https://www.sahapedia.org/mapping-indian-textiles-printed","video_link":"","placeholder_image":null,"savepost":0,"is_saved":0,"share":"http://3.108.183.42/feed/93","media_type":"0","media":["http://3.108.183.42/storage/feed/qxxZlg8FlDRRb83WTDAUshLHTlZmZIMElILKMmRv.jpg","http://3.108.183.42/storage/feed/DNMumaxuOK3mOUrSApXaGyvO5YOvwqwZY7ghgf62.jpg","http://3.108.183.42/storage/feed/fDUD7MbWvbUpSHIuwYh6SxbVIdzhJ8PYNrXzcczj.jpg","http://3.108.183.42/storage/feed/9qAESrnzzDCpdDPt1krkJAf1upbbIP4w2fsZh8UT.jpg","http://3.108.183.42/storage/feed/RNq6coloY3pIja8aJeCdiPx1ep5EJMQiNCEeHdz6.jpg"]}]

GetTagFilterResponse getTagFilterResponseFromJson(String str) => GetTagFilterResponse.fromJson(json.decode(str));
String getTagFilterResponseToJson(GetTagFilterResponse data) => json.encode(data.toJson());
class GetTagFilterResponse {
  GetTagFilterResponse({
      int? status, 
      String? message, 
      int? lastId, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _lastId = lastId;
    _data = data;
}

  GetTagFilterResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _lastId = json['last_id'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _status;
  String? _message;
  int? _lastId;
  List<Data>? _data;

  int? get status => _status;
  String? get message => _message;
  int? get lastId => _lastId;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['last_id'] = _lastId;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 52
/// type : "Single Posts"
/// tags : ["Calico Museum"," Textile"," Gujarat"," Ahmedabad"," Sarabhai"," Ananda Coomaraswamy"," Jawahar Lal Nehru"]
/// title : "Calico Museum of Textiles"
/// description : "The Calico Museum of Textiles houses one of the most important collections of textiles in the country - ranging from ancient textiles, carpets, and tents to costumes, Kalamkari prints, tie and dye, pichwais, and sarees. It also holds an assemblage of bronzes, Jain art objects, and Indian miniature paintings acquired from the Sarabhai Foundation. This museum was inspired by the pioneering art historian and philosopher Dr. Ananda Coomaraswamy. It was his suggestion to Gautam Sarabhai, chairman of the Calico Mills of Ahmedabad, that a textile museum and an institute be founded in the city, as it had been one of India’s leading textile production and trade centers since the 15th century. In 1949, the textile museum was founded by Gautam Sarabhai with the assistance of his sister Gira Sarabhai, and was inaugurated by Jawaharlal Nehru, India’s first prime minister."
/// external_link : "https://www.museumsofindia.org/museum/218/calico-m"
/// video_link : ""
/// placeholder_image : "http://3.108.183.42/storage/"
/// savepost : 0
/// is_saved : 0
/// share : "http://3.108.183.42/feed/52"
/// media_type : "0"
/// media : ["http://3.108.183.42/storage/feed/rINk5SB8IMV8Oj1eDB60WmwHS6cWnB04nyF3ro4i.png","http://3.108.183.42/storage/feed/cNzH6cb1pMligFPvyadNvl6nQHUMnx6tWPbPkPHv.png"]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? id, 
      String? type, 
      List<String>? tags, 
      String? title, 
      String? description, 
      String? externalLink, 
      String? videoLink, 
      String? placeholderImage, 
      int? savepost, 
      int? isSaved, 
      String? share, 
      String? mediaType, 
      List<String>? media,}){
    _id = id;
    _type = type;
    _tags = tags;
    _title = title;
    _description = description;
    _externalLink = externalLink;
    _videoLink = videoLink;
    _placeholderImage = placeholderImage;
    _savepost = savepost;
    _isSaved = isSaved;
    _share = share;
    _mediaType = mediaType;
    _media = media;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    _title = json['title'];
    _description = json['description'];
    _externalLink = json['external_link'];
    _videoLink = json['video_link'];
    _placeholderImage = json['placeholder_image'];
    _savepost = json['savepost'];
    _isSaved = json['is_saved'];
    _share = json['share'];
    _mediaType = json['media_type'];
    _media = json['media'] != null ? json['media'].cast<String>() : [];
  }
  int? _id;
  String? _type;
  List<String>? _tags;
  String? _title;
  String? _description;
  String? _externalLink;
  String? _videoLink;
  String? _placeholderImage;
  int? _savepost;
  int? _isSaved;
  String? _share;
  String? _mediaType;
  List<String>? _media;

  int? get id => _id;
  String? get type => _type;
  List<String>? get tags => _tags;
  String? get title => _title;
  String? get description => _description;
  String? get externalLink => _externalLink;
  String? get videoLink => _videoLink;
  String? get placeholderImage => _placeholderImage;
  int? get savepost => _savepost;
  int? get isSaved => _isSaved;
  String? get share => _share;
  String? get mediaType => _mediaType;
  List<String>? get media => _media;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['tags'] = _tags;
    map['title'] = _title;
    map['description'] = _description;
    map['external_link'] = _externalLink;
    map['video_link'] = _videoLink;
    map['placeholder_image'] = _placeholderImage;
    map['savepost'] = _savepost;
    map['is_saved'] = _isSaved;
    map['share'] = _share;
    map['media_type'] = _mediaType;
    map['media'] = _media;
    return map;
  }

}