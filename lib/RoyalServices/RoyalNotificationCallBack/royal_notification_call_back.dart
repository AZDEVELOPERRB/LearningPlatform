import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Models/Notification/Notification.dart';
import 'package:learningplatform_rb/Models/Notification/company_notification.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/Notifications/SingleNotificationDialog/single_notification_dialog.dart';
import 'package:learningplatform_rb/UI/Notifications/all_notification/all_notification.dart';
class RoyalNotificationCallBack{
  const RoyalNotificationCallBack();
  static showNotification(BuildContext context,NotificationSecret notification){
    if(notification!=null&&notification.secret=="company_notification"){
     messageNotification(context, notification);
    }

  }



  static messageNotification(BuildContext context,NotificationSecret notification){
    CompanyNotificationModel model;
    final data=jsonDecode(notification.data);
    if(data!=null && data is Map){
      try{
        model=CompanyNotificationModel.fromjson(data);
        if(model!=null){
          showDialog(context:context,builder:(BuildContext context){return SingleNotificationDialog(model);});
          return null;
        }
      }catch(e){
        print(e.toString());
      }

    }
    Navigator.push(context,RoyalNavigatorElasticInOut(AllNotificaion()));

  }
}