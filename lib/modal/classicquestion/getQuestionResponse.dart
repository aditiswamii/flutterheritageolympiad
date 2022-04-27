import 'dart:convert';
/// status : 200
/// message : "Quiz Speed data"
/// data : {"quiz_type":"Classic Quiz","time":60,"whole_quiz_time":"0","total_question":12,"total_question_in_quiz":15,"question":[{"id":642,"question":"Angami, Ao, Chakhesang, Chang, Konyak, Lotha and Yimchunger are some of the tribes that form the majority ethnic group in the Indian state of Nagaland. They are traditionally organized according to a strong warrior tradition. What is the term used to describe a conglomeration of all these tribes?","question_media":"","width":"","height":"","option1":"The Naga","option1_media":"","option2":"The Saga","option2_media":"","option3":"The Ahom","option3_media":"","option4":"The Naga","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":429,"question":"Name the place known for its Monolithic (created from a single rock/hill) temples?","question_media":"","width":"","height":"","option1":"Mahabalipuram","option1_media":"","option2":"Mehrauli","option2_media":"","option3":"Amaravati","option3_media":"","option4":"Sanchi","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":643,"question":"Which biosphere located in the Western Ghats is home to Kanikaran, one of the oldest surviving tribes in the world?","question_media":"","width":"","height":"","option1":"Nanda Devi Biosphere Reserve","option1_media":"","option2":"Pachmarhi Biosphere Reserve","option2_media":"","option3":"Great Nicobar Biosphere Reserve","option3_media":"","option4":"Agasthyamala Biosphere Reserve","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":673,"question":"Which of these Harappan cities demonstrates a sophisticated water management system about 5000 years ago? The site has been declared as a World Heritage Site in 2021.","question_media":"","width":"","height":"","option1":"Kalibangan","option1_media":"","option2":"Lothal","option2_media":"","option3":"Rakhigarhi","option3_media":"","option4":"Dholavira","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":627,"question":"Which 17th- century French gem merchant and traveller made six voyages to Persia and India between the year 1630 and 1668 and also visited the court of Shah Jahan and the Kingdom of Golkonda?","question_media":"","width":"","height":"","option1":"Hieun Tsang","option1_media":"","option2":"Fahsien/Faxian","option2_media":"","option3":"Al Beruni","option3_media":"","option4":"Jean-Baptiste Tavernier","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":664,"question":"Iberian Architecture, Patio houses and Baroque churches were introduced by the ___________.","question_media":"","width":"","height":"","option1":"Portuguese","option1_media":"","option2":"Dutch","option2_media":"","option3":"French","option3_media":"","option4":"Portuguese","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":641,"question":"Who among the following is not a renowned ghazal poet?","question_media":"","width":"","height":"","option1":"Rumi","option1_media":"","option2":"Mirza Ghalib","option2_media":"","option3":"Shori Mian","option3_media":"","option4":"Shori Mian","option4_media":"","right_option":3,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":416,"question":"Which Indian Queen of Kittur took to arms and led an anti-British resistance movement in the 19th Century?","question_media":"","width":"","height":"","option1":"Rani Channamma","option1_media":"","option2":"Avantibai","option2_media":"","option3":"Rani Durgavati","option3_media":"","option4":"Chand Bibi","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":640,"question":"Who was the first British governor-general of India?","question_media":"","width":"","height":"","option1":"Robert Clive","option1_media":"","option2":"Lord William Bentinck","option2_media":"","option3":"Warren Hastings","option3_media":"","option4":"Sir Thomas Metcalfe","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":672,"question":"Hoysala monuments are found in _______________.","question_media":"","width":"","height":"","option1":"Hampi and Hospet","option1_media":"","option2":"Halebidu and Belur","option2_media":"","option3":"Mysore","option3_media":"","option4":"Halebidu and Belur","option4_media":"","right_option":2,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":639,"question":"Name the great Maratha general who is credited to have expanded the Maratha kingdom beyond the Vindhyas and is known for his military campaigns against Malwa, Bundelkhand, Gujarat and the Portugese.","question_media":"","width":"","height":"","option1":"Baji Rao Ballal","option1_media":"","option2":"Banda Bahadur","option2_media":"","option3":"Shivaji","option3_media":"","option4":"Baji Rao  Ballal","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":414,"question":"Mekhela Chador is the traditional tribal women's dress of which Indian state?","question_media":"","width":"","height":"","option1":"Assam","option1_media":"","option2":"Nagaland","option2_media":"","option3":"Manipur","option3_media":"","option4":"Sikkim","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":430,"question":"Hemis, Thiksey, Shey are the names of ___________.","question_media":"","width":"","height":"","option1":"Ladakh Buddhists monasteries","option1_media":"","option2":"Local tribes","option2_media":"","option3":"Yaks","option3_media":"","option4":"Local sheep and goat","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":666,"question":"Which of the following is/are famous for Sun Temples?   1. Arasavalli  2. Amarakantak  3. Omkareshwar","question_media":"","width":"","height":"","option1":"2 and 3 only","option1_media":"","option2":"1 and 3 only","option2_media":"","option3":"1, 2, and 3","option3_media":"","option4":"1 only","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":631,"question":"Who is considered as father of Indian Cinema?","question_media":"","width":"","height":"","option1":"Dadasaheb Torne","option1_media":"","option2":"Dada Kondke","option2_media":"","option3":"Dadasaheb Phalke","option3_media":"","option4":"Dadasaheb Phalke","option4_media":"","right_option":3,"hint":null,"question_media_type":"0","why_right":"","type":"0"}]}

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
/// time : 60
/// whole_quiz_time : "0"
/// total_question : 12
/// total_question_in_quiz : 15
/// question : [{"id":642,"question":"Angami, Ao, Chakhesang, Chang, Konyak, Lotha and Yimchunger are some of the tribes that form the majority ethnic group in the Indian state of Nagaland. They are traditionally organized according to a strong warrior tradition. What is the term used to describe a conglomeration of all these tribes?","question_media":"","width":"","height":"","option1":"The Naga","option1_media":"","option2":"The Saga","option2_media":"","option3":"The Ahom","option3_media":"","option4":"The Naga","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":429,"question":"Name the place known for its Monolithic (created from a single rock/hill) temples?","question_media":"","width":"","height":"","option1":"Mahabalipuram","option1_media":"","option2":"Mehrauli","option2_media":"","option3":"Amaravati","option3_media":"","option4":"Sanchi","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":643,"question":"Which biosphere located in the Western Ghats is home to Kanikaran, one of the oldest surviving tribes in the world?","question_media":"","width":"","height":"","option1":"Nanda Devi Biosphere Reserve","option1_media":"","option2":"Pachmarhi Biosphere Reserve","option2_media":"","option3":"Great Nicobar Biosphere Reserve","option3_media":"","option4":"Agasthyamala Biosphere Reserve","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":673,"question":"Which of these Harappan cities demonstrates a sophisticated water management system about 5000 years ago? The site has been declared as a World Heritage Site in 2021.","question_media":"","width":"","height":"","option1":"Kalibangan","option1_media":"","option2":"Lothal","option2_media":"","option3":"Rakhigarhi","option3_media":"","option4":"Dholavira","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":627,"question":"Which 17th- century French gem merchant and traveller made six voyages to Persia and India between the year 1630 and 1668 and also visited the court of Shah Jahan and the Kingdom of Golkonda?","question_media":"","width":"","height":"","option1":"Hieun Tsang","option1_media":"","option2":"Fahsien/Faxian","option2_media":"","option3":"Al Beruni","option3_media":"","option4":"Jean-Baptiste Tavernier","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":664,"question":"Iberian Architecture, Patio houses and Baroque churches were introduced by the ___________.","question_media":"","width":"","height":"","option1":"Portuguese","option1_media":"","option2":"Dutch","option2_media":"","option3":"French","option3_media":"","option4":"Portuguese","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":641,"question":"Who among the following is not a renowned ghazal poet?","question_media":"","width":"","height":"","option1":"Rumi","option1_media":"","option2":"Mirza Ghalib","option2_media":"","option3":"Shori Mian","option3_media":"","option4":"Shori Mian","option4_media":"","right_option":3,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":416,"question":"Which Indian Queen of Kittur took to arms and led an anti-British resistance movement in the 19th Century?","question_media":"","width":"","height":"","option1":"Rani Channamma","option1_media":"","option2":"Avantibai","option2_media":"","option3":"Rani Durgavati","option3_media":"","option4":"Chand Bibi","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":640,"question":"Who was the first British governor-general of India?","question_media":"","width":"","height":"","option1":"Robert Clive","option1_media":"","option2":"Lord William Bentinck","option2_media":"","option3":"Warren Hastings","option3_media":"","option4":"Sir Thomas Metcalfe","option4_media":"","right_option":4,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":672,"question":"Hoysala monuments are found in _______________.","question_media":"","width":"","height":"","option1":"Hampi and Hospet","option1_media":"","option2":"Halebidu and Belur","option2_media":"","option3":"Mysore","option3_media":"","option4":"Halebidu and Belur","option4_media":"","right_option":2,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":639,"question":"Name the great Maratha general who is credited to have expanded the Maratha kingdom beyond the Vindhyas and is known for his military campaigns against Malwa, Bundelkhand, Gujarat and the Portugese.","question_media":"","width":"","height":"","option1":"Baji Rao Ballal","option1_media":"","option2":"Banda Bahadur","option2_media":"","option3":"Shivaji","option3_media":"","option4":"Baji Rao  Ballal","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":414,"question":"Mekhela Chador is the traditional tribal women's dress of which Indian state?","question_media":"","width":"","height":"","option1":"Assam","option1_media":"","option2":"Nagaland","option2_media":"","option3":"Manipur","option3_media":"","option4":"Sikkim","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":430,"question":"Hemis, Thiksey, Shey are the names of ___________.","question_media":"","width":"","height":"","option1":"Ladakh Buddhists monasteries","option1_media":"","option2":"Local tribes","option2_media":"","option3":"Yaks","option3_media":"","option4":"Local sheep and goat","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":666,"question":"Which of the following is/are famous for Sun Temples?   1. Arasavalli  2. Amarakantak  3. Omkareshwar","question_media":"","width":"","height":"","option1":"2 and 3 only","option1_media":"","option2":"1 and 3 only","option2_media":"","option3":"1, 2, and 3","option3_media":"","option4":"1 only","option4_media":"","right_option":1,"hint":null,"question_media_type":"0","why_right":"","type":"0"},{"id":631,"question":"Who is considered as father of Indian Cinema?","question_media":"","width":"","height":"","option1":"Dadasaheb Torne","option1_media":"","option2":"Dada Kondke","option2_media":"","option3":"Dadasaheb Phalke","option3_media":"","option4":"Dadasaheb Phalke","option4_media":"","right_option":3,"hint":null,"question_media_type":"0","why_right":"","type":"0"}]

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

/// id : 642
/// question : "Angami, Ao, Chakhesang, Chang, Konyak, Lotha and Yimchunger are some of the tribes that form the majority ethnic group in the Indian state of Nagaland. They are traditionally organized according to a strong warrior tradition. What is the term used to describe a conglomeration of all these tribes?"
/// question_media : ""
/// width : ""
/// height : ""
/// option1 : "The Naga"
/// option1_media : ""
/// option2 : "The Saga"
/// option2_media : ""
/// option3 : "The Ahom"
/// option3_media : ""
/// option4 : "The Naga"
/// option4_media : ""
/// right_option : 1
/// hint : null
/// question_media_type : "0"
/// why_right : ""
/// type : "0"

Question questionFromJson(String str) => Question.fromJson(json.decode(str));
String questionToJson(Question data) => json.encode(data.toJson());
class Question {
  Question({
      int? id, 
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
      String? type,}){
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
  }
  int? _id;
  String? _question;
  String? _questionMedia;
  String? _width;
  String? _height;
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
    return map;
  }

}