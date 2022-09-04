import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/Files/File/file.dart';

class PDF extends RoyalFile{
  String path,url;
  PDF({this.path,this.url}):super(
    Api.pdf,
    path:path,
    url: url
  );
  PDF.fromJson(json):super(Api.pdf,){
    path=json['file_path'];
    url=Api.pdf+path;
  }

}