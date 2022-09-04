import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/Notification/company_notification.dart';
import 'package:learningplatform_rb/Models/Paginate/paginate_model.dart';
import 'package:learningplatform_rb/Repos/NotificationRepo/notifications_repo.dart';
import 'package:learningplatform_rb/database/Notifications/CompanyNotification/company_notification.dart';
class NotificationsProvider{
  final String url;
  final ValueNotifier<bool> loading=ValueNotifier(false);
  NotificationRepo apiService;
   DBCompanyNotification db;
  bool next=false;
  List<CompanyNotificationModel> list=[];
   ValueNotifier<List<CompanyNotificationModel>> notifier=ValueNotifier([]);
  Pagination pagination;
  NotificationsProvider(this.url){
    apiService=NotificationRepo(url);
    db=DBCompanyNotification(url);
    init();
  }
  dataDB(){
    final data=db.get();
    if(data !=null && data is List){
      notifier.value=[];
      buildDataModel(data);
    }
  }
  init(){
    dataDB();
    internet();
  }
  Future internet()async{
     Pagination pg;
    if(pagination==null){
      loading.value=true;
      await Future.delayed(const Duration(seconds:1));
    pg=await apiService.get();
      loading.value=false;
    }else if(pagination.next!=null){
      loading.value=true;
      await Future.delayed(const Duration(seconds:1));
      pg=await apiService.get(nextUrl:pagination.next);
      loading.value=false;
    } else{Constans.toast('لا يوجد المزيد',false);
    return;
    }
    setPagination(pg);
  }


  setPagination(Pagination p)async{
    if(p!=null){
      final dynamic data=p.data;
      if(p?.current==1){list=[];notifier.value=[];db.insert(data);}
      pagination=p;
      buildDataModel(data);
    }
    else{
      // need to develop
    // await Future.delayed(const Duration(seconds: 3)).then((value) =>internet());
    }
  }
  buildDataModel(final data){
    if(data is List){
      for(final notification in data){
        notifier.value=List.from(notifier.value)..add(CompanyNotificationModel.fromjson(notification));
      }}
  }




}