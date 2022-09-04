import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/Question/question.dart';
import 'package:learningplatform_rb/Models/RoyalGeneralModel/royal_generalModel.dart';

class AnswerModel extends RoyalGeneralModel{
  String id,title,base64,extension,questionId;
  ExamType type;
  Options selectedOption;
  ValueNotifier<int> result=ValueNotifier(null);

  AnswerModel({this.id, this.title, this.base64, this.extension, this.type,this.questionId,this.selectedOption});


  AnswerModel.fromjson(json){
    id=json['id'];
    type=ExamType.fromjson({
      "id":json['type']
    });
    if(type.id=="normal")title=json['title'];
   setImageModel(json);
    if(type.id=='select'){
      selectedOption=Options.fromjson(json['option']);
    }
    result.value=json['result'];

  }
 Map toMap(){
   return {
     "type":type?.id,
     "question":questionId,
     if(title!=null)"title":title,
     "image":base64??"no_image",
     "image_extension":extension??"no_image",
     if(selectedOption!=null)"option":selectedOption.id,};
 }

 Map correctAnswersMap(){
    return {
      "id":id,
      "result":result.value,
    };
 }

}