import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/AnkiService/anki_service.dart';
import 'package:learningplatform_rb/Models/Cart/cart.dart';
import 'package:learningplatform_rb/Models/Chapters/chapter.dart';
import 'package:learningplatform_rb/Models/Image/image.dart';
import 'package:learningplatform_rb/Models/Mission/class_type.dart';
import 'package:learningplatform_rb/Models/RoyalGeneralModel/royal_generalModel.dart';

class SubjectModel extends RoyalGeneralModel{
  String id,name;
  List<ChapterModel> chapters=[];
   Image image;
   AnkiService service;
  ClassType classType;
  Cart cart;
  SubjectModel({this.id, this.name, this.image, this.chapters});
  SubjectModel.fromJson(json){
    if(json is Map){
      id=json['id'];
      name=json['name'];
      if(json.containsKey("anki_cart")){
        cart=Cart.fromJson(json['anki_cart']);
      }
      if(hasValueOfList(json['images'])){
        image=Image.fromJson(json['images'][0]);
      }

      if( json.containsKey("class")){
        final classT=json['class'];
        classType=ClassType.fromjson(classT);
      }

      if(json.containsKey("anki")){
        service=AnkiService.fromjson(json['anki']);
      }

      if( json.containsKey("royal__childs")){
        final royalchilds=json['royal__childs'];
        if(hasValueOfList(royalchilds)){
          for (Map chapter in royalchilds){
            try{
              chapters.add(ChapterModel.fromJson(chapter));
            }catch(e){
              Constans.toast(e.toString(), false);
            }
          }
        }
      }
  }
  }
}