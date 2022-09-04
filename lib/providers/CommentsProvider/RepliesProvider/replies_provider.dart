
  import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/Comment/comment.dart';
import 'package:learningplatform_rb/Models/Paginate/paginate_model.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/ReplayRepo/replay_repo.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';
import 'package:learningplatform_rb/database/base_local.dart';
import 'package:learningplatform_rb/providers/PaginationProvider/pagination_provider.dart';

class RepliesProvider extends PaginationProvider{
  RepliesProvider(this.commentId):
        replayRepo=ReplayRepo(commentId),
        super(url:Api.commentReplies+commentId,token:BaseLocal.token());
  final String commentId;
  final ReplayRepo replayRepo;

  final RoyalLoading _royalLoading=RoyalLoading();
  final ValueNotifier<List<CommentModel>> commentNotifier=ValueNotifier(null);


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


  /// new Replay Section
  final TextEditingController replayController=TextEditingController();
  postNewReplay(final BuildContext context)async{
    if(Constans.checkTextInputs([replayController])){
      final Map body={
        "replay":replayController.text
      };
      _royalLoading.loading(context);
    final RS response= await replayRepo.post(body);
    _royalLoading.cancel();
    if(response.check()){
      replayController.clear();
      final dynamic backedModel=response.data;
      if(backedModel is Map){
        final Pagination p=local();
        if(p!=null){
          final dynamic localCache=p?.data;
          if(localCache!=null && localCache is List){
            localCache.insert(0, backedModel);
          }
        }
       final CommentModel commentModel=CommentModel.fromjson(backedModel);
        commentNotifier.value=List.from(commentNotifier.value)..insert(0,commentModel);
      }
    }
    }
  }

  deleteReplay(final int index,final BuildContext context)async{
    final CommentModel replay=commentNotifier.value[index];
    _royalLoading.loading(context);
    final RS rs=await replayRepo.removeReplay(replay.id);
    _royalLoading.cancel();
    if(rs.check()){
      final Pagination p=local();
      if(p!=null){
        final dynamic localCache=p?.data;
        if(localCache!=null && localCache is List){
         for(int i=0;i<localCache.length;i++){
           final singleLocalReplay=localCache[i];
           if(singleLocalReplay['id']==replay.id){
             localCache.removeAt(i);
           }
         }
        }
      }
      commentNotifier.value=List.from(commentNotifier.value)..removeAt(index);
    }
  }
}