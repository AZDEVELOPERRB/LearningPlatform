import 'package:learningplatform_rb/Models/Files/PDF/pdf.dart';
import 'package:learningplatform_rb/Models/Lessons/lesson.dart';
import 'package:learningplatform_rb/Models/RoyalGeneralModel/royal_generalModel.dart';

class ChapterModel extends RoyalGeneralModel{
  String id,name,youtubeurl;
  PDF pdf;
  List<LessonModel> lessons=[];
  ChapterModel({this.id, this.name, this.youtubeurl, this.pdf});
  ChapterModel.fromJson(json){
    youtubeurl=json['youtube_url'];
    id=json['id'];
    name=json['name'];
    var file=json['pdf'];
    final lessonJson=json['royal__childs'];
    if(hasValueOfList(lessonJson)){
      for (final lesson in lessonJson){
        lessons.add(LessonModel.fromJson(lesson));
      }
    }
    
    if(hasValueOfList(file)){
      pdf=PDF.fromJson(file[0]);
    }else{setPdfNull();}
  }
  setPdfNull(){
    pdf=PDF(path:null,url:null);
  }
}