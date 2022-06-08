import 'dart:convert';
/// status : 200
/// message : "Quiz Speed data"
/// data : {"quiz_type":"Classic Quiz","time":30,"whole_quiz_time":"0","total_question":1,"total_question_in_quiz":20,"question":[{"id":1240,"question":"Which river after reaching the Namcha Barwa takes a ‘U’ turn and enters India in Arunachal Pradesh through a gorge?","question_media":"","width":"","height":"","option1":"Brahmaputra","option1_media":"","option2":"Musi","option2_media":"","option3":"Betwa","option3_media":"","option4":"Ganga","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1242,"question":"Where can the bridge made of aerial roots of a living Ficus Elastica be found in India?","question_media":"http://3.108.183.42/storage/question/5hSSRi4gPXQTbwgGn42FTv3PUuf4QfUFQ2ZqRkss.jpg","width":800,"height":800,"option1":"Assam","option1_media":"","option2":"Meghalaya","option2_media":"","option3":"Mizoram","option3_media":"","option4":"Nagaland","option4_media":"","right_option":2,"hint":null,"question_media_type":"1","why_right":"","type":"1","ques_type":1},{"id":1241,"question":"Name the only remaining natural habitat of the Asiatic lion.","question_media":"","width":"","height":"","option1":"Ranthambhore","option1_media":"","option2":"Kanha","option2_media":"","option3":"Kaziranga","option3_media":"","option4":"Gir Forest","option4_media":"","right_option":3,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1234,"question":"Lac is a _______ based resin.","question_media":"","width":"","height":"","option1":"Epoxy","option1_media":"","option2":"Plant","option2_media":"","option3":"Polyester","option3_media":"","option4":"Insect","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1237,"question":"Name the largest inhabited riverine island in the world.","question_media":"","width":"","height":"","option1":"Nigiris","option1_media":"","option2":"Andaman","option2_media":"","option3":"Sunderban","option3_media":"","option4":"Majuli","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1235,"question":"Which animal is commonly found in mangrove tidal forests?","question_media":"","width":"","height":"","option1":"Red panda","option1_media":"","option2":"Snow leopard","option2_media":"","option3":"Royal Bengal Tiger","option3_media":"","option4":"Wild ass","option4_media":"","right_option":3,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1239,"question":"In which region of Gujarat do flamingoes breed?","question_media":"http://3.108.183.42/storage/question/oiaIo85tImIlTSOXTGdjr9eSwL4xVx5HN6u7xXUZ.jpg","width":800,"height":800,"option1":"North Gujarat","option1_media":"","option2":"Saurasthra","option2_media":"","option3":"Great Rann of Kutchh","option3_media":"","option4":"South Gujarat","option4_media":"","right_option":3,"hint":null,"question_media_type":"1","why_right":"","type":"1","ques_type":1},{"id":1236,"question":"The coat of which animal of the cat family turns white in winter to yellow-grey in summer?","question_media":"","width":"","height":"","option1":"White Tiger","option1_media":"","option2":"Snow Leopard","option2_media":"","option3":"Arctic Fox","option3_media":"","option4":"White Panther","option4_media":"","right_option":2,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1238,"question":"Which of the following wildlife reserves is situated in Jharkhand?(a) Hazaribagh wildlife sanctuary(b) Palamau Tiger reserve","question_media":"","width":"","height":"","option1":"(b)","option1_media":"","option2":"(a)","option2_media":"","option3":"both (a) and (b)","option3_media":"","option4":"only (a)","option4_media":"","right_option":3,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1244,"question":"The ____________ is called Ghorkhar in Kutchi language. A tough and hardy animal it can survive in extreme temperatures with little water like its subspecies in Saudi Arabia, Iraq, Jordan, Israel, Syria and Afghanistan.","question_media":"","width":"","height":"","option1":"Indian Wild Ass","option1_media":"","option2":"Snake","option2_media":"","option3":"Nilgai","option3_media":"","option4":"Camel","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1243,"question":"Which species of Antelope is the state animal of Andhra Pradesh?","question_media":"","width":"","height":"","option1":"Chital","option1_media":"","option2":"Nilgai","option2_media":"","option3":"Chinkara","option3_media":"","option4":"Black buck","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1245,"question":"By what name is the endangered lion-tailed macaque also known?","question_media":"http://3.108.183.42/storage/question/Eq3qBPKNlZmHjYknfw5nzLhgSGUe53sXQFH7E6LO.jpg","width":800,"height":800,"option1":"Wanderoo","option1_media":"","option2":"Mandrill","option2_media":"","option3":"Langur","option3_media":"","option4":"Baboon","option4_media":"","right_option":1,"hint":null,"question_media_type":"1","why_right":"","type":"1","ques_type":1},{"id":1246,"question":"<p>In the Brahma Purāna, which tree is known as the king of trees?</p>","question_media":"","width":"","height":"","option1":"Parijata","option1_media":"","option2":"Banyan","option2_media":"","option3":"Pipal","option3_media":"","option4":"Kalpavrksa","option4_media":"","right_option":3,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1247,"question":"Which UNESCO World Heritage Site was included on the World Heritage Danger List in 1992 when it was invaded by militants of the Bodo tribe in Assam?","question_media":"","width":"","height":"","option1":"Nameri National Park and Forest Reserve","option1_media":"","option2":"Kaziranga National Park","option2_media":"","option3":"Sunderbans National Park","option3_media":"","option4":"Manas Wildlife Sanctuary","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1}]}

GetQuestionResponse getQuestionResponseFromJson(String str) => GetQuestionResponse.fromJson(json.decode(str));
String getQuestionResponseToJson(GetQuestionResponse data) => json.encode(data.toJson());
class GetQuestionResponse {
  GetQuestionResponse({
      int? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetQuestionResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _status;
  String? _message;
  Data? _data;
GetQuestionResponse copyWith({  int? status,
  String? message,
  Data? data,
}) => GetQuestionResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  int? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// quiz_type : "Classic Quiz"
/// time : 30
/// whole_quiz_time : "0"
/// total_question : 1
/// total_question_in_quiz : 20
/// question : [{"id":1240,"question":"Which river after reaching the Namcha Barwa takes a ‘U’ turn and enters India in Arunachal Pradesh through a gorge?","question_media":"","width":"","height":"","option1":"Brahmaputra","option1_media":"","option2":"Musi","option2_media":"","option3":"Betwa","option3_media":"","option4":"Ganga","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1242,"question":"Where can the bridge made of aerial roots of a living Ficus Elastica be found in India?","question_media":"http://3.108.183.42/storage/question/5hSSRi4gPXQTbwgGn42FTv3PUuf4QfUFQ2ZqRkss.jpg","width":800,"height":800,"option1":"Assam","option1_media":"","option2":"Meghalaya","option2_media":"","option3":"Mizoram","option3_media":"","option4":"Nagaland","option4_media":"","right_option":2,"hint":null,"question_media_type":"1","why_right":"","type":"1","ques_type":1},{"id":1241,"question":"Name the only remaining natural habitat of the Asiatic lion.","question_media":"","width":"","height":"","option1":"Ranthambhore","option1_media":"","option2":"Kanha","option2_media":"","option3":"Kaziranga","option3_media":"","option4":"Gir Forest","option4_media":"","right_option":3,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1234,"question":"Lac is a _______ based resin.","question_media":"","width":"","height":"","option1":"Epoxy","option1_media":"","option2":"Plant","option2_media":"","option3":"Polyester","option3_media":"","option4":"Insect","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1237,"question":"Name the largest inhabited riverine island in the world.","question_media":"","width":"","height":"","option1":"Nigiris","option1_media":"","option2":"Andaman","option2_media":"","option3":"Sunderban","option3_media":"","option4":"Majuli","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1235,"question":"Which animal is commonly found in mangrove tidal forests?","question_media":"","width":"","height":"","option1":"Red panda","option1_media":"","option2":"Snow leopard","option2_media":"","option3":"Royal Bengal Tiger","option3_media":"","option4":"Wild ass","option4_media":"","right_option":3,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1239,"question":"In which region of Gujarat do flamingoes breed?","question_media":"http://3.108.183.42/storage/question/oiaIo85tImIlTSOXTGdjr9eSwL4xVx5HN6u7xXUZ.jpg","width":800,"height":800,"option1":"North Gujarat","option1_media":"","option2":"Saurasthra","option2_media":"","option3":"Great Rann of Kutchh","option3_media":"","option4":"South Gujarat","option4_media":"","right_option":3,"hint":null,"question_media_type":"1","why_right":"","type":"1","ques_type":1},{"id":1236,"question":"The coat of which animal of the cat family turns white in winter to yellow-grey in summer?","question_media":"","width":"","height":"","option1":"White Tiger","option1_media":"","option2":"Snow Leopard","option2_media":"","option3":"Arctic Fox","option3_media":"","option4":"White Panther","option4_media":"","right_option":2,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1238,"question":"Which of the following wildlife reserves is situated in Jharkhand?(a) Hazaribagh wildlife sanctuary(b) Palamau Tiger reserve","question_media":"","width":"","height":"","option1":"(b)","option1_media":"","option2":"(a)","option2_media":"","option3":"both (a) and (b)","option3_media":"","option4":"only (a)","option4_media":"","right_option":3,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1244,"question":"The ____________ is called Ghorkhar in Kutchi language. A tough and hardy animal it can survive in extreme temperatures with little water like its subspecies in Saudi Arabia, Iraq, Jordan, Israel, Syria and Afghanistan.","question_media":"","width":"","height":"","option1":"Indian Wild Ass","option1_media":"","option2":"Snake","option2_media":"","option3":"Nilgai","option3_media":"","option4":"Camel","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1243,"question":"Which species of Antelope is the state animal of Andhra Pradesh?","question_media":"","width":"","height":"","option1":"Chital","option1_media":"","option2":"Nilgai","option2_media":"","option3":"Chinkara","option3_media":"","option4":"Black buck","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1245,"question":"By what name is the endangered lion-tailed macaque also known?","question_media":"http://3.108.183.42/storage/question/Eq3qBPKNlZmHjYknfw5nzLhgSGUe53sXQFH7E6LO.jpg","width":800,"height":800,"option1":"Wanderoo","option1_media":"","option2":"Mandrill","option2_media":"","option3":"Langur","option3_media":"","option4":"Baboon","option4_media":"","right_option":1,"hint":null,"question_media_type":"1","why_right":"","type":"1","ques_type":1},{"id":1246,"question":"<p>In the Brahma Purāna, which tree is known as the king of trees?</p>","question_media":"","width":"","height":"","option1":"Parijata","option1_media":"","option2":"Banyan","option2_media":"","option3":"Pipal","option3_media":"","option4":"Kalpavrksa","option4_media":"","right_option":3,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1},{"id":1247,"question":"Which UNESCO World Heritage Site was included on the World Heritage Danger List in 1992 when it was invaded by militants of the Bodo tribe in Assam?","question_media":"","width":"","height":"","option1":"Nameri National Park and Forest Reserve","option1_media":"","option2":"Kaziranga National Park","option2_media":"","option3":"Sunderbans National Park","option3_media":"","option4":"Manas Wildlife Sanctuary","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0","ques_type":1}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? quizType, 
      int? time, 
      String? wholeQuizTime, 
      int? totalQuestion, 
      int? totalQuestionInQuiz, 
      List<Question>? question,}){
    _quizType = quizType;
    _time = time;
    _wholeQuizTime = wholeQuizTime;
    _totalQuestion = totalQuestion;
    _totalQuestionInQuiz = totalQuestionInQuiz;
    _question = question;
}

  Data.fromJson(dynamic json) {
    _quizType = json['quiz_type'];
    _time = json['time'];
    _wholeQuizTime = json['whole_quiz_time'];
    _totalQuestion = json['total_question'];
    _totalQuestionInQuiz = json['total_question_in_quiz'];
    if (json['question'] != null) {
      _question = [];
      json['question'].forEach((v) {
        _question?.add(Question.fromJson(v));
      });
    }
  }
  String? _quizType;
  int? _time;
  String? _wholeQuizTime;
  int? _totalQuestion;
  int? _totalQuestionInQuiz;
  List<Question>? _question;
Data copyWith({  String? quizType,
  int? time,
  String? wholeQuizTime,
  int? totalQuestion,
  int? totalQuestionInQuiz,
  List<Question>? question,
}) => Data(  quizType: quizType ?? _quizType,
  time: time ?? _time,
  wholeQuizTime: wholeQuizTime ?? _wholeQuizTime,
  totalQuestion: totalQuestion ?? _totalQuestion,
  totalQuestionInQuiz: totalQuestionInQuiz ?? _totalQuestionInQuiz,
  question: question ?? _question,
);
  String? get quizType => _quizType;
  int? get time => _time;
  String? get wholeQuizTime => _wholeQuizTime;
  int? get totalQuestion => _totalQuestion;
  int? get totalQuestionInQuiz => _totalQuestionInQuiz;
  List<Question>? get question => _question;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quiz_type'] = _quizType;
    map['time'] = _time;
    map['whole_quiz_time'] = _wholeQuizTime;
    map['total_question'] = _totalQuestion;
    map['total_question_in_quiz'] = _totalQuestionInQuiz;
    if (_question != null) {
      map['question'] = _question?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1240
/// question : "Which river after reaching the Namcha Barwa takes a ‘U’ turn and enters India in Arunachal Pradesh through a gorge?"
/// question_media : ""
/// width : ""
/// height : ""
/// option1 : "Brahmaputra"
/// option1_media : ""
/// option2 : "Musi"
/// option2_media : ""
/// option3 : "Betwa"
/// option3_media : ""
/// option4 : "Ganga"
/// option4_media : ""
/// right_option : 4
/// hint : null
/// question_media_type : "0"
/// why_right : ""
/// type : "0"
/// ques_type : 1

Question questionFromJson(String str) => Question.fromJson(json.decode(str));
String questionToJson(Question data) => json.encode(data.toJson());
class Question {
  Question({
      int? id, 
      String? question, 
      String? questionMedia, 
      dynamic width,
      dynamic height,
      String? option1, 
      String? option1Media, 
      String? option2, 
      String? option2Media, 
      String? option3, 
      String? option3Media, 
      String? option4, 
      String? option4Media, 
      int? rightOption, 
      dynamic hint, 
      String? questionMediaType, 
      String? whyRight, 
      String? type, 
      int? quesType,}){
    _id = id;
    _question = question;
    _questionMedia = questionMedia;
    _width = width;
    _height = height;
    _option1 = option1;
    _option1Media = option1Media;
    _option2 = option2;
    _option2Media = option2Media;
    _option3 = option3;
    _option3Media = option3Media;
    _option4 = option4;
    _option4Media = option4Media;
    _rightOption = rightOption;
    _hint = hint;
    _questionMediaType = questionMediaType;
    _whyRight = whyRight;
    _type = type;
    _quesType = quesType;
}

  Question.fromJson(dynamic json) {
    _id = json['id'];
    _question = json['question'];
    _questionMedia = json['question_media'];
    _width = json['width'];
    _height = json['height'];
    _option1 = json['option1'];
    _option1Media = json['option1_media'];
    _option2 = json['option2'];
    _option2Media = json['option2_media'];
    _option3 = json['option3'];
    _option3Media = json['option3_media'];
    _option4 = json['option4'];
    _option4Media = json['option4_media'];
    _rightOption = json['right_option'];
    _hint = json['hint'];
    _questionMediaType = json['question_media_type'];
    _whyRight = json['why_right'];
    _type = json['type'];
    _quesType = json['ques_type'];
  }
  int? _id;
  String? _question;
  String? _questionMedia;
  dynamic _width;
  dynamic _height;
  String? _option1;
  String? _option1Media;
  String? _option2;
  String? _option2Media;
  String? _option3;
  String? _option3Media;
  String? _option4;
  String? _option4Media;
  int? _rightOption;
  dynamic _hint;
  String? _questionMediaType;
  String? _whyRight;
  String? _type;
  int? _quesType;
Question copyWith({  int? id,
  String? question,
  String? questionMedia,
  String? width,
  String? height,
  String? option1,
  String? option1Media,
  String? option2,
  String? option2Media,
  String? option3,
  String? option3Media,
  String? option4,
  String? option4Media,
  int? rightOption,
  dynamic hint,
  String? questionMediaType,
  String? whyRight,
  String? type,
  int? quesType,
}) => Question(  id: id ?? _id,
  question: question ?? _question,
  questionMedia: questionMedia ?? _questionMedia,
  width: width ?? _width,
  height: height ?? _height,
  option1: option1 ?? _option1,
  option1Media: option1Media ?? _option1Media,
  option2: option2 ?? _option2,
  option2Media: option2Media ?? _option2Media,
  option3: option3 ?? _option3,
  option3Media: option3Media ?? _option3Media,
  option4: option4 ?? _option4,
  option4Media: option4Media ?? _option4Media,
  rightOption: rightOption ?? _rightOption,
  hint: hint ?? _hint,
  questionMediaType: questionMediaType ?? _questionMediaType,
  whyRight: whyRight ?? _whyRight,
  type: type ?? _type,
  quesType: quesType ?? _quesType,
);
  int? get id => _id;
  String? get question => _question;
  String? get questionMedia => _questionMedia;
  String? get width => _width;
  String? get height => _height;
  String? get option1 => _option1;
  String? get option1Media => _option1Media;
  String? get option2 => _option2;
  String? get option2Media => _option2Media;
  String? get option3 => _option3;
  String? get option3Media => _option3Media;
  String? get option4 => _option4;
  String? get option4Media => _option4Media;
  int? get rightOption => _rightOption;
  dynamic get hint => _hint;
  String? get questionMediaType => _questionMediaType;
  String? get whyRight => _whyRight;
  String? get type => _type;
  int? get quesType => _quesType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['question'] = _question;
    map['question_media'] = _questionMedia;
    map['width'] = _width;
    map['height'] = _height;
    map['option1'] = _option1;
    map['option1_media'] = _option1Media;
    map['option2'] = _option2;
    map['option2_media'] = _option2Media;
    map['option3'] = _option3;
    map['option3_media'] = _option3Media;
    map['option4'] = _option4;
    map['option4_media'] = _option4Media;
    map['right_option'] = _rightOption;
    map['hint'] = _hint;
    map['question_media_type'] = _questionMediaType;
    map['why_right'] = _whyRight;
    map['type'] = _type;
    map['ques_type'] = _quesType;
    return map;
  }

}