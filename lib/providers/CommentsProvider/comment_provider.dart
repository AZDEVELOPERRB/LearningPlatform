import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Models/Comment/comment.dart';
import 'package:learningplatform_rb/Models/Paginate/paginate_model.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/CommentsRepo/comment_repo.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';
import 'package:learningplatform_rb/database/base_local.dart';
import 'package:learningplatform_rb/providers/PaginationProvider/pagination_provider.dart';
class CommentProvider extends PaginationProvider{
  CommentProvider(this.lessonId,{final String newUrl}):super(url:(newUrl??Api.allLessonComments)+lessonId,token:BaseLocal.token());
  final String lessonId;
  final ValueNotifier<List<CommentModel>> commentNotifier=ValueNotifier(null);
  final CommentsRepo _commentsRepo=CommentsRepo();
  final RoyalLoading loadingBuilding=RoyalLoading();
  running(){
    dataBase();
    internet();
  }
   dataBase(){
    final Pagination p=local();
    if(p!=null){
      syncNotifier(p);
    }
   }
   internet()async{
    final Pagination p=await api();
    if(p!=null){
      syncNotifier(p);
    }
   }
   syncNotifier(final Pagination pagination){
    if(pagination.current==1){
      commentNotifier.value=List.from([]);
    }
    final dynamic data=pagination.data;
    if(data is List ){
      data.forEach((json){
     commentNotifier.value=List.from(commentNotifier.value)..add(CommentModel.fromjson(json));
      });
    }
   }


   commentLike(final bool like,final String commentId)async{
    final Map body={
      "id":commentId,
      'like':like?1:0
    };
    final RS response=await _commentsRepo.likeComment(body);
    if(response.check()) {
      final Pagination p = local();
      dynamic data = p.data;
      if (data is List) {
        data.forEach((element) {
          if (element['id'] == commentId) {
            if (like) {
              element['likes_count']++;
              element['liked'] = 1;
            }
            else {
              element['likes_count']--;
              element['liked'] = 0;
            }
          }
        });
        p.data = data;
        save(p.toMap());
      }
    }
   }

   saveNewComment(final data){
     final Pagination p = local();
     dynamic pData = p.data;
     if(pData is List)pData.insert(0,data);
      final CommentModel commentModelc=CommentModel.fromjson(data);
      print(commentModelc.comment);
      print(commentModelc.creator.name);
      commentNotifier.value=List.from(commentNotifier.value)..insert(0,CommentModel.fromjson(data));

   }

   deleteComment(final int index,BuildContext context)async{
    final CommentModel model=commentNotifier.value[index];
    final Map body={"id":model.id};
    loadingBuilding.loading(context);
    final RS rs=await _commentsRepo.deleteComment(body);
    loadingBuilding.cancel();
    if(rs.check()){
      final Pagination p = local();
      dynamic pData = p.data;
      if(pData is List){
       for(int i=0;i<pData.length;i++){
         final Map element=pData[i];
         if(element['id']==model.id){
           pData.removeAt(i);
         }
       }
       p.data=pData;
       save(p.toMap());
      }
      commentNotifier.value=List.from(commentNotifier.value)..removeAt(index);
    }

   }

    lookAtComment(final String id)async{
    await _commentsRepo.lookAtComment({'id':id});
   }
}