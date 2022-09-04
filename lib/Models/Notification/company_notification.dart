class CompanyNotificationModel{
  String id,title,body,url;

  CompanyNotificationModel({this.id, this.title, this.body});
  CompanyNotificationModel.fromjson(json){
    id=json['id'];
    title=json['title'];
    body=json['body'];
    url=json['url'];
  }
}