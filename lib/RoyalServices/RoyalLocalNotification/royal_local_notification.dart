import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class RoyalLocalNotification{

  RoyalLocalNotification._();
  static final RoyalLocalNotification instance=RoyalLocalNotification._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings initializationSettingsAndroid =AndroidInitializationSettings('launch_background',
  );
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
    );
   InitializationSettings initializationSettings;

   init()async{
     if(initializationSettings==null){
       initializationSettings=InitializationSettings(
         android: initializationSettingsAndroid,
         iOS: initializationSettingsIOS,
       );
      await flutterLocalNotificationsPlugin.initialize(initializationSettings
      ,onSelectNotification:onClickOnNotification
      );
     }

   }


   showNotification({
    @required final String title,
     @required final String body,
     @required final String payLoad,

     String channelId="Anki",channelName="AnkiStudy",
     channelDescription="AnkiSchedulingSystem",
     final DateTime selectedDateTime
     })async{

     /// Android Notification Detail

     final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
         channelId, channelName,channelDescription,
         importance: Importance.max,
         priority: Priority.high,
         showWhen:false,
       styleInformation:BigTextStyleInformation('')
     );

     final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

     if(selectedDateTime!=null){
       final  time =tz.TZDateTime.from(selectedDateTime,tz.local);
       bool trigger=true;
       final List<PendingNotificationRequest> request=await RoyalLocalNotification.instance.flutterLocalNotificationsPlugin.pendingNotificationRequests();
       request.forEach((element) {
        if(payLoad==element.payload)trigger=false;
       });

     return trigger?await  flutterLocalNotificationsPlugin.zonedSchedule(0,
           title, body,
           time,
           platformChannelSpecifics,
           androidAllowWhileIdle:true
         , uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
     ):null;

     }

   return  await flutterLocalNotificationsPlugin.show(
         0,title,body, platformChannelSpecifics,
         payload:payLoad,);
   }

}


Future<bool> onClickOnNotification(final String payload)async{

  return true;
}

