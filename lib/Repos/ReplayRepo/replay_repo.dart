import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/RoyalRepos/royal_repo.dart';
import 'package:learningplatform_rb/database/base_local.dart';

class ReplayRepo extends RoyalRepo{
  ReplayRepo(this.commentId) : super(Api.createCommentReplay+commentId,token:BaseLocal.token());
  final String commentId;

 Future<RS> removeReplay(final String replayId)async{
   return await post({},nUrl:Api.removeCommentReplay+replayId);
 }
}