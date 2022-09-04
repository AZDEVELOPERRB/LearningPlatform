import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/RoyalServices/RoyalLocalNotification/royal_local_notification.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
class AppInit{
  const AppInit();

 Future init()async{
   initTimeZone();
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   await Hive.initFlutter();
   await initDataBase();
   await RoyalLocalNotification.instance.init();

  }

 Future initDataBase()async{
   for(final String localData in Constans.localDataBases){
     await Hive.openBox(localData);
   }
 }

  initTimeZone(){
   tz.initializeTimeZones();
  tz.timeZoneDatabase.locations;
 }
}