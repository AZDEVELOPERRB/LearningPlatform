import 'package:learningplatform_rb/Models/AnkiElement/anki_element.dart';

class AnkiAnswer extends AnkiElementModel{
  String answer;
  AnkiAnswer.fromJson(final dynamic json){
    formId(json);
    answer=json['answer'];
    setImageModel(json);
    formVoice(json);
  }
}