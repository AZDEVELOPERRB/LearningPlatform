import 'package:learningplatform_rb/Models/Pricabe/priceable.dart';

class AnkiService extends Priceable{
  String id;
  AnkiService.fromjson(final dynamic json){
    if(json is Map){
      id=json['id'];
      formPrice(json);
    }
  }
}