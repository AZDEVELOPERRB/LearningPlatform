import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/Lessons/lesson.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/RoyalRepos/royal_repo.dart';
import 'package:learningplatform_rb/database/base_local.dart';
class LessonHandler{
  LessonHandler(this.lessonModel);
  final LessonModel lessonModel;
  final LessonAcessoriesRepo repo=LessonAcessoriesRepo();
  /// Post Api Function
  postLike(final bool like)async{
   await repo.postLike({"id":lessonModel.id, "like":like?1:0});
  }

  postRating(final double rating)async{
  await repo.postRating({"id":lessonModel.id, "rating":rating});
  }
  

  

}
class LessonAcessoriesRepo extends RoyalRepo{
  LessonAcessoriesRepo():super(Api.like,token:BaseLocal.token());
 Future<RS> postLike(final Map body)async{
    return await post(body);
  }
  Future<RS> postRating(final Map body)async{
    return await post(body,nUrl:Api.rating);
  }
}