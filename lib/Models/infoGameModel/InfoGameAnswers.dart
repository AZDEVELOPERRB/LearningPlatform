class InfoGameAnswers{
  String id,answer,t;
  int isright;
  InfoGameAnswers({this.id, this.answer, this.t, this.isright});
  InfoGameAnswers.fromjson(json){
    this.id=json['id'];
    this.answer=json['answer'];
    this.t=json['t'];
    this.isright=json['isright'];
  }
}