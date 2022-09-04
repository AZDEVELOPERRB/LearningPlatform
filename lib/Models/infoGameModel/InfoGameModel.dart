import 'package:learningplatform_rb/Models/infoGameModel/InfoGameAnswers.dart';

class InfoGameLevels{
  String id,question,rightanswer;
  int stars,progress,t;
  List<InfoGameAnswers> answers=[];

  InfoGameLevels({this.id, this.question, this.rightanswer, this.stars,
      this.progress, this.t});

  InfoGameLevels.fromjson(json){
    if(json['royal__childs']!=null){
      for (var answer in json['royal__childs']){
        this.answers.add(InfoGameAnswers.fromjson(answer));
    }
    }
    this.id=json['id'];
    this.question=json['question'];
    this.rightanswer=json['right_answer'];
    this.stars=json['stars'];
    this.progress=json['progress'];
    this.t=json['t'];

  }
}