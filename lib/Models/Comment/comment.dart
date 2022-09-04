import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:learningplatform_rb/Models/Students/Customer.dart';

class CommentModel{
  String id,comment,createdAt;
  int likes,views;
  ValueNotifier<bool> liked;
  User creator;
  CommentModel({this.id, this.creator, this.comment});
  CommentModel.fromjson(final json){
    if(json is Map){
      id=json['id'];
      comment=json['comment'];
      creator=User.fromjson(json['creator']);
      if(json.containsKey('likes_count'))likes=json['likes_count'];
      if(json.containsKey('views_count'))views=json['views_count'];
      if(json.containsKey('liked'))liked=ValueNotifier(json['liked']==1?true:false);
      if(json.containsKey('createdAt')){
        createdAt=DateFormat('yyyy-MM-dd').format(DateTime.parse(json['createdAt']));
      }

    }
  }
}

class Replay {
  String id,creator,comment;
  Replay({this.id, this.creator, this.comment});
}