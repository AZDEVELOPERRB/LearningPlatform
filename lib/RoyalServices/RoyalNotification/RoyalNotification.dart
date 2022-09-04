import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Models/Notification/Notification.dart';
import 'package:learningplatform_rb/RoyalServices/RoyalNotificationCallBack/royal_notification_call_back.dart';
import 'dart:io';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';
class RoyalNotification{
  final FirebaseMessaging _fcm=FirebaseMessaging();
  Future initialize(BuildContext context)async{
    if(Platform.isIOS){
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
   return _fcm.configure(
      onMessage: (Map <String,dynamic> message){
        NotificationSecret notification=NotificationSecret.initial(message['data']);
        return handelNotification(context,notification);
      },
      onLaunch: (Map <String,dynamic> message){
        NotificationSecret notification=NotificationSecret.initial(message['data']);
        return handelNotification(context,notification);
      },
      onResume: (Map <String,dynamic> message){
        NotificationSecret notification=NotificationSecret.initial(message['data']);
       return handelNotification(context,notification);
      },

    );

  }
  handelNotification(BuildContext context,NotificationSecret noti)async{
   await RoyalDialog.publicDialog(context,
        NotificationDialog(noti));
    return null;
  }
}
class NotificationDialog extends StatelessWidget {
const NotificationDialog(this.notification);
 final NotificationSecret notification;
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Container(
      height: size.height/4,
      width:size.width,
      decoration:const BoxDecoration(
        borderRadius:BorderRadius.all(Radius.circular(15)),
        color:Colors.white,
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          const Text('هل تريد فتح هذا الاشعار؟'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[
              RaisedButton(
                  shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
                  color:Colors.black54,
                  child:Text('خروج',style:const TextStyle(color:Colors.white),),
                  onPressed:(){Navigator.pop(context);}),
              RaisedButton(
                  shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
                  color:Colors.blue,
                  child:Text('اظهار الاشعار',style:const TextStyle(color:Colors.white),),
                  onPressed:(){RoyalNotificationCallBack.showNotification(context,notification);}),
            ],
          )
        ],
      ),
    );
  }
}
