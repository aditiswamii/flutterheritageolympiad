import 'dart:convert';
/// status : 200
/// message : "Data found succesfully"
/// data : {"question":[{"id":1163,"question":"Which of the following has/have been accorded 'Geographical Indication' status? \n\n1) Banaras Brocade Sarees \n2) Rajasthani Daal-Bati-Churma \n3) Tirupati Laddu","question_media":null,"option1":"1 and 3","option1_media":"","option2":"1 only","option2_media":"","option3":"1, 2 and 3","option3_media":"","option4":"2 and 3 only","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1165,"question":"In which traditional art form of fabric dyeing and printing a part of the fabric is covered with wax to make it dye resistent, while the other parts are dyed to create coloured and uncoloured areas on the same cloth?","question_media":null,"option1":"Batik art","option1_media":"","option2":"Pattachitra","option2_media":"","option3":"Tanjore Art","option3_media":"","option4":"Kalamezhuthu","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1173,"question":"Carpet made from felting instead of weaving is called __________.","question_media":null,"option1":"Namda","option1_media":"","option2":"Pattu","option2_media":"","option3":"Galesha","option3_media":"","option4":"Kaleen","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1170,"question":"Who among the following did not play a role in the emergence of the Bengal School of Art?","question_media":null,"option1":"Abanindranath Tagore","option1_media":"","option2":"Raja Ravi Varma","option2_media":"","option3":"Rabindranath Tagore","option3_media":"","option4":"E.B. Havell","option4_media":"","why_right":"","right_option":2,"hint":null,"question_media_type":"0","ques_type":1},{"id":1162,"question":"Which craft involving the use of silver is popularly called Tarakshi in Odisha?","question_media":null,"option1":"Stone work","option1_media":"","option2":"Gold plating","option2_media":"","option3":"Silver filigree","option3_media":"","option4":"Pottery","option4_media":"","why_right":"","right_option":3,"hint":null,"question_media_type":"0","ques_type":1},{"id":1172,"question":"Which state of India is famous for its Kalighat painting?","question_media":null,"option1":"Bihar","option1_media":"","option2":"Orissa","option2_media":"","option3":"West Bengal","option3_media":"","option4":"Jharkhand","option4_media":"","why_right":"","right_option":3,"hint":null,"question_media_type":"0","ques_type":1},{"id":1164,"question":"What makes Sujini, a traditional form of embroidery from Bihar, unique?","question_media":"question/Y9CWomeKx7Ycd2rPJlcnwBFTn9mlV43EY5GEUEaM.jpg","option1":"The narrative element of it- women stitch their experiences on Sujuni","option1_media":"","option2":"The fabric used for embroidery","option2_media":"","option3":"The kind of thread used for embroidery","option3_media":"","option4":"Men primarily embroider","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"1","ques_type":1},{"id":1161,"question":"In Tanjore paintings, the wood of which tree was formerly used as a plank on which the canvas was painted?","question_media":null,"option1":"Jackfruit","option1_media":"","option2":"Poplar","option2_media":"","option3":"Cedar","option3_media":"","option4":"Pine","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1160,"question":"How did anti-child-labour laws affect carpet weaving in Bhadohi?","question_media":null,"option1":"led to a decrease in production","option1_media":"","option2":"led to more women taking up carpet-weaving","option2_media":"","option3":"led to more boys taking up carpet-weaving","option3_media":"","option4":"did not affect carpet-weaving at all","option4_media":"","why_right":"","right_option":2,"hint":null,"question_media_type":"0","ques_type":1},{"id":1169,"question":"The Kangra school of miniature paintings primarily depicts the legends of which god as the subject matter of its work?","question_media":null,"option1":"Krishna","option1_media":"","option2":"Shiva","option2_media":"","option3":"Ganesha","option3_media":"","option4":"Vishnu","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1171,"question":"Patuas are professional ____________.","question_media":null,"option1":"Painters","option1_media":"","option2":"Dancers","option2_media":"","option3":"Administrators","option3_media":"","option4":"Royal Servants","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1167,"question":"Match the following embroidery styles with where they're found: \n\nA. Do-rukha         1) Bihar\nB. Phulkari            2) Punjab\nC. Sujni                  3) Lucknow\nD. Chikan             4) Kashmir\nE. Kantha              5) Bengal\nF. Kasuti                6) Karnataka","question_media":null,"option1":"4 2 1 3 5 6","option1_media":"","option2":"1 3 4 5 6 2","option2_media":"","option3":"4 3 2 1 5 6","option3_media":"","option4":"2 4 1 3 5 6","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1159,"question":"The famous masks of Goa are most often made on the shells of which fruit?","question_media":null,"option1":"Coconut","option1_media":"","option2":"Cantaloupe","option2_media":"","option3":"Pumpkin ","option3_media":"","option4":"Watermelon","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1166,"question":"Name the 1993 Indian Hindi-language drama based on the short story written by famous Bengali author Mahasweta Devi. The title is a reference to a custom in certain areas of Rajasthan where women of a lower caste are hired as professional mourners upon the death of upper-caste males.","question_media":null,"option1":"Bhumika","option1_media":"","option2":"Aasoo Bane Angaarey","option2_media":"","option3":"Ankur","option3_media":"","option4":"Rudaali","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1168,"question":"Which of these are toys fashioned with soft ivory wood, teak, rubber, cedar or neem and lacquered with vibrant, natural dyes? These toys have a 200-year-old history, this place in Karnataka's Ramanagara District is GI-tagged for its dolls.","question_media":null,"option1":"Belgaum","option1_media":"","option2":"Channapatna","option2_media":"","option3":"Mysore","option3_media":"","option4":"Gulbarga","option4_media":"","why_right":"","right_option":2,"hint":null,"question_media_type":"0","ques_type":1}],"whole_quiz_time":"1","time":120,"total_question":15,"total_question_in_quiz":15}

GetTournamentQuestionResponse getTournamentQuestionResponseFromJson(String str) => GetTournamentQuestionResponse.fromJson(json.decode(str));
String getTournamentQuestionResponseToJson(GetTournamentQuestionResponse data) => json.encode(data.toJson());
class GetTournamentQuestionResponse {
  GetTournamentQuestionResponse({
      int? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetTournamentQuestionResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _status;
  String? _message;
  Data? _data;
GetTournamentQuestionResponse copyWith({  int? status,
  String? message,
  Data? data,
}) => GetTournamentQuestionResponse(  status: status ?? _status,
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

/// question : [{"id":1163,"question":"Which of the following has/have been accorded 'Geographical Indication' status? \n\n1) Banaras Brocade Sarees \n2) Rajasthani Daal-Bati-Churma \n3) Tirupati Laddu","question_media":null,"option1":"1 and 3","option1_media":"","option2":"1 only","option2_media":"","option3":"1, 2 and 3","option3_media":"","option4":"2 and 3 only","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1165,"question":"In which traditional art form of fabric dyeing and printing a part of the fabric is covered with wax to make it dye resistent, while the other parts are dyed to create coloured and uncoloured areas on the same cloth?","question_media":null,"option1":"Batik art","option1_media":"","option2":"Pattachitra","option2_media":"","option3":"Tanjore Art","option3_media":"","option4":"Kalamezhuthu","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1173,"question":"Carpet made from felting instead of weaving is called __________.","question_media":null,"option1":"Namda","option1_media":"","option2":"Pattu","option2_media":"","option3":"Galesha","option3_media":"","option4":"Kaleen","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1170,"question":"Who among the following did not play a role in the emergence of the Bengal School of Art?","question_media":null,"option1":"Abanindranath Tagore","option1_media":"","option2":"Raja Ravi Varma","option2_media":"","option3":"Rabindranath Tagore","option3_media":"","option4":"E.B. Havell","option4_media":"","why_right":"","right_option":2,"hint":null,"question_media_type":"0","ques_type":1},{"id":1162,"question":"Which craft involving the use of silver is popularly called Tarakshi in Odisha?","question_media":null,"option1":"Stone work","option1_media":"","option2":"Gold plating","option2_media":"","option3":"Silver filigree","option3_media":"","option4":"Pottery","option4_media":"","why_right":"","right_option":3,"hint":null,"question_media_type":"0","ques_type":1},{"id":1172,"question":"Which state of India is famous for its Kalighat painting?","question_media":null,"option1":"Bihar","option1_media":"","option2":"Orissa","option2_media":"","option3":"West Bengal","option3_media":"","option4":"Jharkhand","option4_media":"","why_right":"","right_option":3,"hint":null,"question_media_type":"0","ques_type":1},{"id":1164,"question":"What makes Sujini, a traditional form of embroidery from Bihar, unique?","question_media":"question/Y9CWomeKx7Ycd2rPJlcnwBFTn9mlV43EY5GEUEaM.jpg","option1":"The narrative element of it- women stitch their experiences on Sujuni","option1_media":"","option2":"The fabric used for embroidery","option2_media":"","option3":"The kind of thread used for embroidery","option3_media":"","option4":"Men primarily embroider","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"1","ques_type":1},{"id":1161,"question":"In Tanjore paintings, the wood of which tree was formerly used as a plank on which the canvas was painted?","question_media":null,"option1":"Jackfruit","option1_media":"","option2":"Poplar","option2_media":"","option3":"Cedar","option3_media":"","option4":"Pine","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1160,"question":"How did anti-child-labour laws affect carpet weaving in Bhadohi?","question_media":null,"option1":"led to a decrease in production","option1_media":"","option2":"led to more women taking up carpet-weaving","option2_media":"","option3":"led to more boys taking up carpet-weaving","option3_media":"","option4":"did not affect carpet-weaving at all","option4_media":"","why_right":"","right_option":2,"hint":null,"question_media_type":"0","ques_type":1},{"id":1169,"question":"The Kangra school of miniature paintings primarily depicts the legends of which god as the subject matter of its work?","question_media":null,"option1":"Krishna","option1_media":"","option2":"Shiva","option2_media":"","option3":"Ganesha","option3_media":"","option4":"Vishnu","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1171,"question":"Patuas are professional ____________.","question_media":null,"option1":"Painters","option1_media":"","option2":"Dancers","option2_media":"","option3":"Administrators","option3_media":"","option4":"Royal Servants","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1167,"question":"Match the following embroidery styles with where they're found: \n\nA. Do-rukha         1) Bihar\nB. Phulkari            2) Punjab\nC. Sujni                  3) Lucknow\nD. Chikan             4) Kashmir\nE. Kantha              5) Bengal\nF. Kasuti                6) Karnataka","question_media":null,"option1":"4 2 1 3 5 6","option1_media":"","option2":"1 3 4 5 6 2","option2_media":"","option3":"4 3 2 1 5 6","option3_media":"","option4":"2 4 1 3 5 6","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1159,"question":"The famous masks of Goa are most often made on the shells of which fruit?","question_media":null,"option1":"Coconut","option1_media":"","option2":"Cantaloupe","option2_media":"","option3":"Pumpkin ","option3_media":"","option4":"Watermelon","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1166,"question":"Name the 1993 Indian Hindi-language drama based on the short story written by famous Bengali author Mahasweta Devi. The title is a reference to a custom in certain areas of Rajasthan where women of a lower caste are hired as professional mourners upon the death of upper-caste males.","question_media":null,"option1":"Bhumika","option1_media":"","option2":"Aasoo Bane Angaarey","option2_media":"","option3":"Ankur","option3_media":"","option4":"Rudaali","option4_media":"","why_right":"","right_option":1,"hint":null,"question_media_type":"0","ques_type":1},{"id":1168,"question":"Which of these are toys fashioned with soft ivory wood, teak, rubber, cedar or neem and lacquered with vibrant, natural dyes? These toys have a 200-year-old history, this place in Karnataka's Ramanagara District is GI-tagged for its dolls.","question_media":null,"option1":"Belgaum","option1_media":"","option2":"Channapatna","option2_media":"","option3":"Mysore","option3_media":"","option4":"Gulbarga","option4_media":"","why_right":"","right_option":2,"hint":null,"question_media_type":"0","ques_type":1}]
/// whole_quiz_time : "1"
/// time : 120
/// total_question : 15
/// total_question_in_quiz : 15

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      List<Question>? question, 
      String? wholeQuizTime, 
      int? time, 
      int? totalQuestion, 
      int? totalQuestionInQuiz,}){
    _question = question;
    _wholeQuizTime = wholeQuizTime;
    _time = time;
    _totalQuestion = totalQuestion;
    _totalQuestionInQuiz = totalQuestionInQuiz;
}

  Data.fromJson(dynamic json) {
    if (json['question'] != null) {
      _question = [];
      json['question'].forEach((v) {
        _question?.add(Question.fromJson(v));
      });
    }
    _wholeQuizTime = json['whole_quiz_time'];
    _time = json['time'];
    _totalQuestion = json['total_question'];
    _totalQuestionInQuiz = json['total_question_in_quiz'];
  }
  List<Question>? _question;
  String? _wholeQuizTime;
  int? _time;
  int? _totalQuestion;
  int? _totalQuestionInQuiz;
Data copyWith({  List<Question>? question,
  String? wholeQuizTime,
  int? time,
  int? totalQuestion,
  int? totalQuestionInQuiz,
}) => Data(  question: question ?? _question,
  wholeQuizTime: wholeQuizTime ?? _wholeQuizTime,
  time: time ?? _time,
  totalQuestion: totalQuestion ?? _totalQuestion,
  totalQuestionInQuiz: totalQuestionInQuiz ?? _totalQuestionInQuiz,
);
  List<Question>? get question => _question;
  String? get wholeQuizTime => _wholeQuizTime;
  int? get time => _time;
  int? get totalQuestion => _totalQuestion;
  int? get totalQuestionInQuiz => _totalQuestionInQuiz;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_question != null) {
      map['question'] = _question?.map((v) => v.toJson()).toList();
    }
    map['whole_quiz_time'] = _wholeQuizTime;
    map['time'] = _time;
    map['total_question'] = _totalQuestion;
    map['total_question_in_quiz'] = _totalQuestionInQuiz;
    return map;
  }

}

/// id : 1163
/// question : "Which of the following has/have been accorded 'Geographical Indication' status? \n\n1) Banaras Brocade Sarees \n2) Rajasthani Daal-Bati-Churma \n3) Tirupati Laddu"
/// question_media : null
/// option1 : "1 and 3"
/// option1_media : ""
/// option2 : "1 only"
/// option2_media : ""
/// option3 : "1, 2 and 3"
/// option3_media : ""
/// option4 : "2 and 3 only"
/// option4_media : ""
/// why_right : ""
/// right_option : 1
/// hint : null
/// question_media_type : "0"
/// ques_type : 1

Question questionFromJson(String str) => Question.fromJson(json.decode(str));
String questionToJson(Question data) => json.encode(data.toJson());
class Question {
  Question({
      int? id, 
      String? question, 
      dynamic questionMedia, 
      String? option1, 
      String? option1Media, 
      String? option2, 
      String? option2Media, 
      String? option3, 
      String? option3Media, 
      String? option4, 
      String? option4Media, 
      String? whyRight, 
      int? rightOption, 
      dynamic hint, 
      String? questionMediaType, 
      int? quesType,}){
    _id = id;
    _question = question;
    _questionMedia = questionMedia;
    _option1 = option1;
    _option1Media = option1Media;
    _option2 = option2;
    _option2Media = option2Media;
    _option3 = option3;
    _option3Media = option3Media;
    _option4 = option4;
    _option4Media = option4Media;
    _whyRight = whyRight;
    _rightOption = rightOption;
    _hint = hint;
    _questionMediaType = questionMediaType;
    _quesType = quesType;
}

  Question.fromJson(dynamic json) {
    _id = json['id'];
    _question = json['question'];
    _questionMedia = json['question_media'];
    _option1 = json['option1'];
    _option1Media = json['option1_media'];
    _option2 = json['option2'];
    _option2Media = json['option2_media'];
    _option3 = json['option3'];
    _option3Media = json['option3_media'];
    _option4 = json['option4'];
    _option4Media = json['option4_media'];
    _whyRight = json['why_right'];
    _rightOption = json['right_option'];
    _hint = json['hint'];
    _questionMediaType = json['question_media_type'];
    _quesType = json['ques_type'];
  }
  int? _id;
  String? _question;
  dynamic _questionMedia;
  String? _option1;
  String? _option1Media;
  String? _option2;
  String? _option2Media;
  String? _option3;
  String? _option3Media;
  String? _option4;
  String? _option4Media;
  String? _whyRight;
  int? _rightOption;
  dynamic _hint;
  String? _questionMediaType;
  int? _quesType;
Question copyWith({  int? id,
  String? question,
  dynamic questionMedia,
  String? option1,
  String? option1Media,
  String? option2,
  String? option2Media,
  String? option3,
  String? option3Media,
  String? option4,
  String? option4Media,
  String? whyRight,
  int? rightOption,
  dynamic hint,
  String? questionMediaType,
  int? quesType,
}) => Question(  id: id ?? _id,
  question: question ?? _question,
  questionMedia: questionMedia ?? _questionMedia,
  option1: option1 ?? _option1,
  option1Media: option1Media ?? _option1Media,
  option2: option2 ?? _option2,
  option2Media: option2Media ?? _option2Media,
  option3: option3 ?? _option3,
  option3Media: option3Media ?? _option3Media,
  option4: option4 ?? _option4,
  option4Media: option4Media ?? _option4Media,
  whyRight: whyRight ?? _whyRight,
  rightOption: rightOption ?? _rightOption,
  hint: hint ?? _hint,
  questionMediaType: questionMediaType ?? _questionMediaType,
  quesType: quesType ?? _quesType,
);
  int? get id => _id;
  String? get question => _question;
  dynamic get questionMedia => _questionMedia;
  String? get option1 => _option1;
  String? get option1Media => _option1Media;
  String? get option2 => _option2;
  String? get option2Media => _option2Media;
  String? get option3 => _option3;
  String? get option3Media => _option3Media;
  String? get option4 => _option4;
  String? get option4Media => _option4Media;
  String? get whyRight => _whyRight;
  int? get rightOption => _rightOption;
  dynamic get hint => _hint;
  String? get questionMediaType => _questionMediaType;
  int? get quesType => _quesType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['question'] = _question;
    map['question_media'] = _questionMedia;
    map['option1'] = _option1;
    map['option1_media'] = _option1Media;
    map['option2'] = _option2;
    map['option2_media'] = _option2Media;
    map['option3'] = _option3;
    map['option3_media'] = _option3Media;
    map['option4'] = _option4;
    map['option4_media'] = _option4Media;
    map['why_right'] = _whyRight;
    map['right_option'] = _rightOption;
    map['hint'] = _hint;
    map['question_media_type'] = _questionMediaType;
    map['ques_type'] = _quesType;
    return map;
  }

}