import 'package:learningplatform_rb/Constans/Api.dart';

class RoyalFile{
  String path,url;
   String urlPath;
  RoyalFile(this.urlPath,{this.path,this.url});
  formElements(json){
    path=json['file_path'];
    url=urlPath+path;
  }
}