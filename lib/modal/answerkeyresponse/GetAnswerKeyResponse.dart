import 'dart:convert';
/// status : 200
/// message : "Result show"
/// data : [{"question":"What are the body gestures called in dance?","right_option":"Angika","your_option":"Angika","question_id":1130},{"question":"Odissi derives its themes mainly from which text?","right_option":"Gita Govinda","your_option":"Ramayana","question_id":1129},{"question":"Which book first recorded the 12 rashis or zodiac signs?","right_option":"Yavanajataka","your_option":"Rigveda","question_id":1111},{"question":"Name the instrument played\nin 'Sufiana Maushiqi' that combines the\ninfluence of Indian as well as Persian\nmusic and is connected with the Sufi\nspiritual tradition of Kashmir?","right_option":"Santoor","your_option":"Sarod","question_id":1134},{"question":"Thang Ta is the martial art form of which state?","right_option":"Manipur","your_option":"not attempt","question_id":1108},{"question":"Name the novel by Bibhuti Bhushan Bandopadhyay, which was later adapted into a 1955 film of the same name.","right_option":"Pather Panchali","your_option":"Jalsaghar","question_id":1127},{"question":"Epigraphy is a study of _________.","right_option":"Inscriptions","your_option":"Stars & constellations","question_id":1106},{"question":"Which medical text contains an oath taken at the time of inititation into medical studies?","right_option":"Charaka Samhita","your_option":"Bṛhat Saṃhitā","question_id":1104},{"question":"The standard dialect of which language is Vicholi?","right_option":"Sindhi","your_option":"Kutchi","question_id":1124},{"question":"Which of the following is not correctly matched?","right_option":"Kundhei - Rod Puppet","your_option":"Pavakoothu - Glove Puppet","question_id":1141},{"question":"Which of the following is the first surviving Indian text of astronomy?","right_option":"Vedānga Jyotisa","your_option":"Vedānga Jyotisa","question_id":1103},{"question":"Celebrated for infamous ‘Lihaaf’ (The Quilt, 1941), this author also wrote essays on variety of subjects, on social movements, issues of marriage, and on people including Saadat Hassan Manto. She was a part of the Progressive Writers’ Movement. Identify the author.","right_option":"Ismat Chughtai","your_option":"not attempt","question_id":1123},{"question":"Which one of these was a Harappan technology?","right_option":"Bead bleaching","your_option":"Glass manufacture","question_id":1101},{"question":"Which sect of hinduism led to the creation of the Sattriya dance?","right_option":"Vaisnavism","your_option":"Bhakti","question_id":1107},{"question":"What name is given to the unique style in which Teejan Bai from Chhattisgarh narrates the tales from the epics?","right_option":"Pandvani","your_option":"Bharthari","question_id":1133},{"question":"Where did Thumri musical compositions of Hindustani music begin?","right_option":"Uttar Pradesh","your_option":"Maharashtra","question_id":1136},{"question":"In which state of India is Tulu mainly spoken?","right_option":"Karnataka","your_option":"Karnataka","question_id":1122},{"question":"In Vedic texts, which metal is referred to as 'shyama'?","right_option":"Iron","your_option":"Silver","question_id":1117},{"question":"In which folk dance of Assam can you see traditional attire, dhoti, gamocha and chadar and mekhala?","right_option":"Bihu","your_option":"not attempt","question_id":1137},{"question":"Which of these is the earliest-known script used for writing Sanskrit?","right_option":"Brahmi script","your_option":"Brahmi script","question_id":1118}]

GetAnswerKeyResponse getAnswerKeyResponseFromJson(String str) => GetAnswerKeyResponse.fromJson(json.decode(str));
String getAnswerKeyResponseToJson(GetAnswerKeyResponse data) => json.encode(data.toJson());
class GetAnswerKeyResponse {
  GetAnswerKeyResponse({
      int? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetAnswerKeyResponse.fromJson(dynamic json) {
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

/// question : "What are the body gestures called in dance?"
/// right_option : "Angika"
/// your_option : "Angika"
/// question_id : 1130

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? question, 
      String? rightOption, 
      String? yourOption, 
      int? questionId,}){
    _question = question;
    _rightOption = rightOption;
    _yourOption = yourOption;
    _questionId = questionId;
}

  Data.fromJson(dynamic json) {
    _question = json['question'];
    _rightOption = json['right_option'];
    _yourOption = json['your_option'];
    _questionId = json['question_id'];
  }
  String? _question;
  String? _rightOption;
  String? _yourOption;
  int? _questionId;

  String? get question => _question;
  String? get rightOption => _rightOption;
  String? get yourOption => _yourOption;
  int? get questionId => _questionId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = _question;
    map['right_option'] = _rightOption;
    map['your_option'] = _yourOption;
    map['question_id'] = _questionId;
    return map;
  }

}