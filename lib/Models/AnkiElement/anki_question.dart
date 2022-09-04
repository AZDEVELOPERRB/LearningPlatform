import 'package:learningplatform_rb/Models/AnkiElement/anki_answer.dart';
import 'package:learningplatform_rb/Models/AnkiElement/anki_element.dart';

class AnkiQuestion extends AnkiElementModel{
  String question;
  AnkiAnswer answer;
  DateTime time;
  int hours;
  AnkiQuestion.fromJson(final dynamic json){
    formId(json);
    question=json['question'];
    setImageModel(json);
    formVoice(json);
    answer=AnkiAnswer.fromJson(json['answer']);

    if(json is Map){

      if(json.containsKey("time")){
        time=DateTime.parse(json['time'].toString());
      }
      if(json.containsKey('hours'))hours=int.parse(json['hours'].toString());

    }
  }


  bool hasScheduleWright(){
    return DateTime.now().isAfter(time);
  }
  String getTimeToShow(){
   if(time==null)return '';
   int hour=time.hour>12?time.hour-12:time.hour;
   String amPm=time.hour>12?" مسائاً ":" صباحاً ";
   return "المراجعة المستحقة في "+ "${time.year.toString()+"-"+time.month.toString()+"-"+time.day.toString()}" + "\n"+
    "في الساعة "+ "${hour.toString()+amPm}"+" "+"الدقيقة " +"${time.minute}"
    ;

  }
}