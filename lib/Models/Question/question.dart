import 'dart:convert';

import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/IdealAnswer/ideal_answer.dart';
import 'package:learningplatform_rb/Models/RoyalGeneralModel/royal_generalModel.dart';

class Question extends RoyalGeneralModel{
String title;
String marks;
ExamType type;
String base64;
String extension;
List<Options> options;
IdealAnswer idealAnswer;
Question({this.type, this.title,this.options});

Map toMap(){
   return {
     'title':title??"",
    if(marks!=null) 'marks':marks,
     'type':type?.id??"",
     "image":base64??"no_image",
     "image_extension":extension??"no_extension",
     if(options!=null &&options.length>=2)"options":jsonEncode([
       for(Options op in options)op.toMap()
     ]),
     "ideal":idealAnswer?.toMap()??'no_ideal'
   };
 }
}

class Options{
  String id;
  String option;
  bool right;
  Options({this.option,this.right});
 Map toMap(){
   return {
     "option":option,
     "right":right?1:0
   };
 }
 Options.fromjson(json){
   id=json['id'];
   option=json['option'];
   right=json['right']==1?true:false;
 }
}