import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/Answer/answer_model.dart';
import 'package:learningplatform_rb/Models/IdealAnswer/ideal_answer.dart';
import 'package:learningplatform_rb/Models/Question/question.dart';
import 'package:learningplatform_rb/Models/RoyalGeneralModel/royal_generalModel.dart';

class QuestionModel extends RoyalGeneralModel{
  String id,title,marks;
  ExamType type;
  List<Options> options=[];
  ValueNotifier<AnswerModel> answer=ValueNotifier(null);
  IdealAnswer idealAnswer;

  QuestionModel({this.id, this.type, this.title});

  QuestionModel.fromjson(json){
    setImageModel(json);
    id=json['id'];
    title=json['title'].toString();
    marks=json['marks'].toString();
    type=ExamType.fromjson({"id":json['type']});
    if(json is Map && json.containsKey('options')){
      final op=json['options'];
      for(final j in op){
        options.add(Options.fromjson(j));
      }
    }
    if(json is Map &&json.containsKey("answer")){
      answer.value=AnswerModel.fromjson(json['answer']);
    }
    if(json is Map && json.containsKey('idealanswers')){
      idealAnswer=IdealAnswer.fromjson(json['idealanswers']);
    }
  }
}
