import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Models/ExamModel/exam_model.dart';
import 'package:learningplatform_rb/Models/Files/PDF/pdf.dart';
import 'package:learningplatform_rb/Models/RoyalGeneralModel/royal_generalModel.dart';

class LessonModel extends RoyalGeneralModel{
  String id,name,youtubeurl;
  PDF pdf;
  ExamModel exam;
  ValueNotifier<double> rating=ValueNotifier(0);
  LessonModel({this.id, this.name, this.youtubeurl, this.pdf});
  final ValueNotifier<bool> likeProperty=ValueNotifier(null);

  LessonModel.fromJson(json){
    if(json is Map){
      id=json['id'];
      name=json['name'];
      youtubeurl=json['youtube_url'];
      if(hasValueOfList(json['pdf'])){
        pdf=PDF.fromJson(json['pdf'][0]);
      }else{
        pdf=PDF(path:null,url:null);
      }
      if(json.containsKey('quick_exam')){
        if(json['quick_exam']!=null){
          exam=ExamModel.fromjson(json['quick_exam']);
        }

      }
      if(json.containsKey('rating')){
        rating.value=double.parse("${json['rating']}");
      }
      if(json.containsKey('like')){
       if(json['like']!=null){
        if(json['like']['like']!=null){
          if(json['like']['like']==1){
            likeProperty.value=true;
          }
          else{
            likeProperty.value=false;

          }
        }
       }
      }
    }

  }

}