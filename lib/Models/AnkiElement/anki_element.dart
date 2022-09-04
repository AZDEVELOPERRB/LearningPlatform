import 'package:learningplatform_rb/Models/Files/Voice/voice.dart';
import 'package:learningplatform_rb/Models/RoyalGeneralModel/royal_generalModel.dart';

class AnkiElementModel extends RoyalGeneralModel{
  String id;
  Voice voice;
  formId(json){
    id=json['id'];
  }
  formVoice(final dynamic json){
    if(json is Map){
      if(json.containsKey('voice')){
        final dynamic voices=json['voice'];
        if(voices is List && voices.isNotEmpty){
          try{
            voice=Voice.fromJson(voices[0]);
          }catch(e){
            return e;
          }
        }
      }
    }
  }

}