import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/RoyalRepos/royal_repo.dart';
import 'package:learningplatform_rb/database/base_local.dart';

class CommentsRepo extends RoyalRepo{
  CommentsRepo() : super(Api.like,token:BaseLocal.token());


 Future<RS> postComment(final Map body)async{
    return await post(body,nUrl:Api.lessonPostComment);
  }

  Future<RS> likeComment(final Map body)async{
   return await post(body,nUrl:Api.commentLike);
  }
  Future<RS> deleteComment(final Map body)async{
    return await post(body,nUrl:Api.deleteComment);
  }
  Future<RS> lookAtComment(final Map body)async{
    return await post(body,nUrl:Api.lookAtComment);
  }
}