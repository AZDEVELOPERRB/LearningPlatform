import 'package:learningplatform_rb/Models/Paginate/paginate_model.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/RoyalServices/ApiServices/RoyalApiServices.dart';
import 'package:learningplatform_rb/database/base_local.dart';
class NotificationRepo{
  final String url;
  NotificationRepo(this.url);
  Future<Pagination> get({String nextUrl})async{
    final RS rs=await RoyalApiServices.get(nextUrl??url,token:BaseLocal.token());
    if(rs?.data is Map && rs.data.containsKey('current_page')){
      try{
       final Pagination pagination=Pagination.fromjson(rs.data);
       return pagination;
      }catch(e){
        return null;
      }
    }
     return null;
  }


}