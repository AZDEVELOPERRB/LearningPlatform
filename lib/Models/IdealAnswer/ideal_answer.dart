import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/Question/question.dart';
import 'package:learningplatform_rb/Models/RoyalGeneralModel/royal_generalModel.dart';

class IdealAnswer extends RoyalGeneralModel{
  String id,type,title;
  Options rightOption;
  ExamType examType;

  /// Image  To Serve Objects
  String base64,extension;

  IdealAnswer({
    this.id, this.type, this.title, this.rightOption, this.examType,
    this.base64, this.extension
});

  IdealAnswer.fromjson(json){
    if(json is Map){
      id=json['id'];
      if(json.containsKey('images'))setImageModel(json);
      title=json['title'];
    }
  }
  Map toMap(){
    return {
      "image":base64??"no_image",
      "extension":extension??"no_extension",
      "title":title??"",
    };
  }
}