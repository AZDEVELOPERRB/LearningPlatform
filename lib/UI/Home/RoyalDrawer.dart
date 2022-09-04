import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/RoyalServices/UIServices/RoyalNotifier.dart';
import 'package:learningplatform_rb/UI/About/about_apps.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/BestStudents/best_students.dart';
import 'package:learningplatform_rb/UI/BottomClasses/InformationGame/InformationGame.dart';
import 'package:learningplatform_rb/UI/PrivacyAndPolicy/privacy_and_policy.dart';
import 'package:learningplatform_rb/database/base_local.dart';
import 'package:learningplatform_rb/UI/FeedBacks/FeedBack.dart';
import 'package:share_plus/share_plus.dart';
class RoyalDrawer extends StatelessWidget {
  final BaseLocal baselocal=BaseLocal();
 static const TextAlign AppAlign=TextAlign.end;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration:const BoxDecoration(
              image:const DecorationImage(
                image:const AssetImage('Assets/images/skybackground.jpg'), fit: BoxFit.cover)),

            child:const Padding(
              padding:const EdgeInsets.only(top:15.0),
              child:const Text('تطبيق منصة الصف التعليمية',style: TextStyle(color: Colors.white),),
            ),
          ),

          ListTile(
            trailing:const Icon(FlutterIcons.people_mdi,color: Colors.black,),
            title: const Text('المتفوقين',textAlign:AppAlign),
            onTap:(){
              Navigator.push(context,RoyalNavigatorElasticInOut(BestStudents()));
            },
          ),
          ListTile(
            trailing:const Icon(Icons.gamepad,color: Colors.black,),
            title: const Text('لعبة المعلومات',textAlign:AppAlign),
            onTap:(){
              Navigator.push(context,RoyalNavigatorElasticInOut(Scaffold(
                appBar:AppBar(),
                body:RoyalNotifier(
                  child:InformationGame(),
                ),
              )));
            },
          ),
          ListTile(
            trailing:const Icon(Icons.messenger,color: Colors.black,),
            title: const Text('مراسلة التطبيق',textAlign:AppAlign),
            onTap:(){
              Navigator.push(context,RoyalNavigatorElasticInOut(FeedBack()));
            },
          ),
          ListTile(
            trailing:const Icon(Icons.privacy_tip_outlined,color: Colors.black,),
            title: const Text('سياسة الخصوصية',textAlign:AppAlign),
            onTap: (){Navigator.push(context,RoyalNavigatorElasticInOut(PrivacyAndPolicy(showTrigger:false,)));},),

          ListTile(
            trailing:const Icon(Icons.info_outline,color: Colors.black,),
            title: const Text('حول التطبيق',textAlign:AppAlign),
            onTap: (){Navigator.push(context,RoyalNavigatorElasticInOut(AppInformation()));},),
          ListTile(
            trailing:const Icon(Icons.logout,color: Colors.black,),
            title: const Text('تسجيل خروج',textAlign:AppAlign,style: TextStyle(color: Colors.black),),
            onTap: () { baselocal.logout();},),
          ListTile(
            trailing:const Icon(Icons.share,color: Colors.black,),
            title: const Text('مشاركة التطبيق',textAlign:AppAlign,style: TextStyle(color: Colors.black),),
            onTap: () async{
              await Share.share(Constans.shareApp());
            },),

        ],
      ),
    );
  }


}
