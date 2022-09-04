import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/Files/File/file.dart';

class Voice extends RoyalFile{
  String path,url;
  Voice({this.path,this.url}):super(
      Api.voice,
      path:path,
      url: url
  );
  Voice.fromJson(json):super(Api.voice,){
    path=json['file_path'];
    url=Api.voice+path;
  }
}