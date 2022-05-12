import 'dart:convert';
/// status : 200
/// message : "Domain data"
/// data : [{"id":1,"type":"Single Posts","tags":["#rigveda"," # Knowledge Traditions"],"title":"The Rigveda","description":"The Rigveda is the oldest extant Vedic text. It is a collection of 1,028 Vedic Sanskrit hymns and 10,600 verses in all, organized into ten books (Sanskrit: mandalas). The hymns are dedicated to Rigvedic deities.","external_link":"https://www.google.co.in/","video_link":"","placeholder_image":"http://3.108.183.42/storage/","savepost":2,"is_saved":1,"share":"http://3.108.183.42/feed/1","media_type":"","media":[]},{"id":106,"type":"Single Posts","tags":["Kutch"," Textile"," Gujarat"," Blockprinting"," Ajrakh"," Indigo"," Handloom"," Handblock printing"],"title":"Ajrakh - A Unique Form of Block Printing","description":"Ajrakh is a form of traditional hand block printing and resist dyeing using indigo, madder and printed mordants. Ajrakh production is limited to very few places in the world, namely Sindh in Pakistan, Kachchh or Kutch in Gujarat, India, and Barmer in Rajasthan, India. Produced by the Khatri community of dyers and printers, Ajrakh is the most complex of their many textile products. Ajrakh designs are easily recognisable by their bold geometric repeats, in combinations of centre field and border designs. These symmetrical patterns are printed and dyed in natural red and black, with the white cloth resisted on a dark indigo blue background. a unique and technically advanced feature of ajrakh is the use of bipuri or double-sided printing.","external_link":"https://strandofsilk.com/journey-map/gujarat/ajrak-printing/history","video_link":"","placeholder_image":"http://3.108.183.42/storage/","savepost":1,"is_saved":1,"share":"http://3.108.183.42/feed/106","media_type":"0","media":["http://3.108.183.42/storage/feed/v475tpdKcjdkOdDdJY92AGVHlK2GDF3Txk56bagE.jpg"]},{"id":112,"type":"Single Posts","tags":["Blockprinting"," textile"," Dabu"," Indigo"],"title":"Dabu - Mud Resist Handblock  Printing","description":"Dabu printing is a method of mud resist handblock printing that has been practised for centuries by several communities in Rajasthan, especially Udaipur.  The word ‘Dabu’ comes from the Hindi word ‘dabana’ which means ‘to press’, referring to the use of hand-carved blocks to imprint designs onto the fabric piece, thus creating unique patterns. With its main centers in Rajasthan, Gujarat and Madhya Pradesh, this craft flourishes in areas that naturally has sticky clay like soil, easily available in nearby areas. The technique is believed to have dated back to the 8th century CE, based on the oldest known Dabu textile, found in Central Asia.","external_link":"https://www.indiaheritagewalks.org/blog/dabu-printing-tradition-rajasthan","video_link":"","placeholder_image":"http://3.108.183.42/storage/","savepost":2,"is_saved":1,"share":"http://3.108.183.42/feed/112","media_type":"0","media":["http://3.108.183.42/storage/feed/iGE17J40mAhpyycNDc8a8oCc7q39YiQ3Tr4sZbIk.jpg"]},{"id":113,"type":"Single Posts","tags":["Textile"," Embroidery"," Chamba rumal"," Himachal Pradesh"],"title":"Have you heard of the Chamba Rumal?","description":"The Chamba Rumal or Chamba Handkerchief is an embroidered textile that developed under the patronage of the erstwhile rulers of the Chamba kingdom in Himachal Pradesh. Used and gifted on festive occasions, the typical square or rectangular Chamba Rumal was traditionally made of fine cotton or muslin and embroidered with silk thread. The themes and figures in the traditional Chamba Rumal resemble closely those of Pahari miniature paintings of the region.","external_link":"https://www.sahapedia.org/chamba-rumal-interplay-literature-and-paintings","video_link":"","placeholder_image":null,"savepost":2,"is_saved":1,"share":"http://3.108.183.42/feed/113","media_type":"0","media":["http://3.108.183.42/storage/feed/46MsAYiJL6cmVtf12JkX4I0WFFKqsrp7OvLhzCED.jpg","http://3.108.183.42/storage/feed/P08aOopm90hSr6fYM868HfyYOTcUUjRpMd4q9kdn.jpg","http://3.108.183.42/storage/feed/Yfug33IzgC8PADmFMiLktUgCFzSp6lAuUfxRepMz.jpg"]}]

GetSavePostResponse getSavePostResponseFromJson(String str) => GetSavePostResponse.fromJson(json.decode(str));
String getSavePostResponseToJson(GetSavePostResponse data) => json.encode(data.toJson());
class GetSavePostResponse {
  GetSavePostResponse({
      int? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetSavePostResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _status;
  String? _message;
  List<Data>? _data;

  int? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// type : "Single Posts"
/// tags : ["#rigveda"," # Knowledge Traditions"]
/// title : "The Rigveda"
/// description : "The Rigveda is the oldest extant Vedic text. It is a collection of 1,028 Vedic Sanskrit hymns and 10,600 verses in all, organized into ten books (Sanskrit: mandalas). The hymns are dedicated to Rigvedic deities."
/// external_link : "https://www.google.co.in/"
/// video_link : ""
/// placeholder_image : "http://3.108.183.42/storage/"
/// savepost : 2
/// is_saved : 1
/// share : "http://3.108.183.42/feed/1"
/// media_type : ""
/// media : []

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
      List<dynamic>? media,}){
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
  List<dynamic>? _media;

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
  List<dynamic>? get media => _media;

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
    if (_media != null) {
      map['media'] = _media?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}