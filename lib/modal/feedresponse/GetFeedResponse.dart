import 'dart:convert';
/// status : 200
/// message : "Domain data"
/// last_id : 108
/// data : [{"id":113,"type":"Single Posts","tags":["Textile"," Embroidery"," Chamba rumal"," Himachal Pradesh"],
/// "title":"Have you heard of the Chamba Rumal?","description":"The Chamba Rumal or Chamba Handkerchief is an embroidered textile that developed under the patronage of the erstwhile rulers of the Chamba kingdom in Himachal Pradesh. Used and gifted on festive occasions, the typical square or rectangular Chamba Rumal was traditionally made of fine cotton or muslin and embroidered with silk thread. The themes and figures in the traditional Chamba Rumal resemble closely those of Pahari miniature paintings of the region.","external_link":"https://www.sahapedia.org/chamba-rumal-interplay-literature-and-paintings","video_link":"","placeholder_image":null,"savepost":2,"is_saved":1,"share":"http://3.108.183.42/feed/113","media_type":"0","media":["http://3.108.183.42/storage/feed/46MsAYiJL6cmVtf12JkX4I0WFFKqsrp7OvLhzCED.jpg","http://3.108.183.42/storage/feed/P08aOopm90hSr6fYM868HfyYOTcUUjRpMd4q9kdn.jpg","http://3.108.183.42/storage/feed/Yfug33IzgC8PADmFMiLktUgCFzSp6lAuUfxRepMz.jpg"]},{"id":112,"type":"Single Posts","tags":["Blockprinting"," textile"," Dabu"," Indigo"],"title":"Dabu - Mud Resist Handblock  Printing","description":"Dabu printing is a method of mud resist handblock printing that has been practised for centuries by several communities in Rajasthan, especially Udaipur.  The word ‘Dabu’ comes from the Hindi word ‘dabana’ which means ‘to press’, referring to the use of hand-carved blocks to imprint designs onto the fabric piece, thus creating unique patterns. With its main centers in Rajasthan, Gujarat and Madhya Pradesh, this craft flourishes in areas that naturally has sticky clay like soil, easily available in nearby areas. The technique is believed to have dated back to the 8th century CE, based on the oldest known Dabu textile, found in Central Asia.","external_link":"https://www.indiaheritagewalks.org/blog/dabu-printing-tradition-rajasthan","video_link":"","placeholder_image":"http://3.108.183.42/storage/","savepost":2,"is_saved":1,"share":"http://3.108.183.42/feed/112","media_type":"0","media":["http://3.108.183.42/storage/feed/iGE17J40mAhpyycNDc8a8oCc7q39YiQ3Tr4sZbIk.jpg"]},{"id":111,"type":"Single Posts","tags":["Museums"," Literature"," Mahasweta Devi"],"title":"Mahasweta Devi Sangraha Shala","description":"A museum dedicated to the notable writer Mahasweta Devi, the Sangraha Shala is located in the house where she spent the last few years of her life. Some of the personalia that can be found here includes Mahasweta Devi's handwritten letters to family and friends. The building exterior has a large portrait of hers.","external_link":"https://www.museumsofindia.org/museum/632/mahasweta-devi-sangraha-shala","video_link":"","placeholder_image":null,"savepost":0,"is_saved":0,"share":"http://3.108.183.42/feed/111","media_type":"0","media":["http://3.108.183.42/storage/feed/SxpoT8fAKvjqrKyBFsHnt7Qqv6mJn1HXDySp6Wtv.png","http://3.108.183.42/storage/feed/l0eAABzfuJO5NzVU3XeuovwC6pQjLosQc1NiVDX2.png"]},{"id":109,"type":"Single Posts","tags":["K C S Panikar"," abstract painter"," Indian artist"],"title":"Metaphysical and abstract painter from Malabar","description":"K. C. S. Paniker (1911–1977) was a metaphysical and abstract painter from Malabar District, India. He interpreted the country's age-old metaphysical and spiritual knowledge in the 1960s, when Indian art was under the influence of the Western painters. 'That was the time when a few Indian artists were trying to break out of this Western influence and establish an idiom and identity of their own,' he said. In 1976, he was awarded the highest award of the Lalit Kala Akademi, India's National Academy of Art, the Fellow of the Lalit Kala Akademi for lifetime contribution.","external_link":"https://scroll.in/magazine/842744/the-metaphysical-world-of-kcs-paniker-the-founder-of-chennais-iconic-cholamandal-artists-village","video_link":"","placeholder_image":"http://3.108.183.42/storage/","savepost":0,"is_saved":0,"share":"http://3.108.183.42/feed/109","media_type":"","media":[]},{"id":108,"type":"Single Posts","tags":["Tipu Sultan"," Tipu's Tiger"," Mysore"," British"],"title":"Tipu's Tiger","description":"'Tipu's Tiger' is an eighteenth-century automaton or mechanical toy that was made for Tipu Sultan, ruler of Mysore in South India from 1782 to 1799. The tiger, an almost life-sized wooden semi-automaton, mauls a European soldier lying on his back. Concealed inside the tiger's body, behind a hinged flap, is an organ which can be operated by turning the handle next to it. This simultaneously makes the man's arm lift up and down and produces noises intended to imitate his dying moans. The tiger was discovered in his summer palace after East India Company troops stormed Tipu's capital in 1799.","external_link":"https://www.vam.ac.uk/articles/tipus-tiger","video_link":"","placeholder_image":"http://3.108.183.42/storage/","savepost":1,"is_saved":0,"share":"http://3.108.183.42/feed/108","media_type":"0","media":["http://3.108.183.42/storage/feed/ucrwHMZhLo18LdfBbX3i4BF2kkf7v1fQVYNrRrLz.jpg","http://3.108.183.42/storage/feed/sXYInfO4bounISI07E74zrWvOg0zMKSqlAWBNWDu.jpg"]}]

GetFeedResponse getFeedResponseFromJson(String str) => GetFeedResponse.fromJson(json.decode(str));
String getFeedResponseToJson(GetFeedResponse data) => json.encode(data.toJson());
class GetFeedResponse {
  GetFeedResponse({
      int? status, 
      String? message, 
      int? lastId, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _lastId = lastId;
    _data = data;
}

  GetFeedResponse.fromJson(dynamic json) {
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

/// id : 113
/// type : "Single Posts"
/// tags : ["Textile"," Embroidery"," Chamba rumal"," Himachal Pradesh"]
/// title : "Have you heard of the Chamba Rumal?"
/// description : "The Chamba Rumal or Chamba Handkerchief is an embroidered textile that developed under the patronage of the erstwhile rulers of the Chamba kingdom in Himachal Pradesh. Used and gifted on festive occasions, the typical square or rectangular Chamba Rumal was traditionally made of fine cotton or muslin and embroidered with silk thread. The themes and figures in the traditional Chamba Rumal resemble closely those of Pahari miniature paintings of the region."
/// external_link : "https://www.sahapedia.org/chamba-rumal-interplay-literature-and-paintings"
/// video_link : ""
/// placeholder_image : null
/// savepost : 2
/// is_saved : 1
/// share : "http://3.108.183.42/feed/113"
/// media_type : "0"
/// media : ["http://3.108.183.42/storage/feed/46MsAYiJL6cmVtf12JkX4I0WFFKqsrp7OvLhzCED.jpg","http://3.108.183.42/storage/feed/P08aOopm90hSr6fYM868HfyYOTcUUjRpMd4q9kdn.jpg","http://3.108.183.42/storage/feed/Yfug33IzgC8PADmFMiLktUgCFzSp6lAuUfxRepMz.jpg"]

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
      dynamic placeholderImage, 
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
  dynamic _placeholderImage;
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
  dynamic get placeholderImage => _placeholderImage;
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