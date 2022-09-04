import 'package:learningplatform_rb/Models/Image/image.dart';

abstract class RoyalGeneralModel{
  List<Image> images;
  Image firstImage;
  bool hasValueOfList(final json){
    if(json!=null&&json!='null'&&json is List && json.length>0)return true;
    return false;
  }
  
  void setImageModel(final json){
    if(json is Map&&json.containsKey("images")){
      final dynamic im=json['images'];
      if(im is List && im.isNotEmpty){
        images=[];
        for (final j in im){
          images.add(Image.fromJson(j));
        }
      }
    }
  }

  hasImages(){
    if(images!=null&&images.isNotEmpty)return true;
    return false;
  }
}