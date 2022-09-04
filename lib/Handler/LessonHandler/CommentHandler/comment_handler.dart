import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/Lessons/lesson.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/CommentsRepo/comment_repo.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';
import 'package:learningplatform_rb/providers/CommentsProvider/comment_provider.dart';

class CommentHandler{
  CommentHandler(this.lessonModel,{final String newUrl}):
  provider=CommentProvider(lessonModel.id,newUrl:newUrl);
  final LessonModel lessonModel;
  final RoyalLoading loading=RoyalLoading();
  final CommentsRepo repo=CommentsRepo();
  final CommentProvider provider;
  final TextEditingController commentController=TextEditingController();

  /// Posting New Comment
  postNewComment(BuildContext context,{bool isQuestion=true})async{
    if(Constans.checkTextInputs([commentController],message:"يجب كتابة شيئاً ما")){
      final Map body={
        "id":lessonModel.id,
        "comment":commentController.text,
       "type":isQuestion==false?"comment":"question"
      };
       loading.loading(context);
      final RS rs=await repo.postComment(body);
      if(rs.check()){
        commentController.clear();
        /// Sync New Comment
        provider.saveNewComment(rs.data);
      }
      loading.cancel();
    }
  }

}