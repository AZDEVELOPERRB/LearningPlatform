import 'package:learningplatform_rb/Constans/Api.dart';

class Image{
  String path,url;
  Image({this.path});
  Image.fromJson(json){
    path=json['img_path'];
    url=Api.image+path;
  }
}