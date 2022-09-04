import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/DevelopingCertificate/developing_certificate.dart';
import 'package:learningplatform_rb/UI/About/about_apps.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/database/base_local.dart';
import 'package:learningplatform_rb/UI/FeedBacks/FeedBack.dart';
import 'package:share_plus/share_plus.dart';
class TeacherDrawer extends StatelessWidget {
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
            trailing:const Icon(Icons.info_outline,color: Colors.black,),
            title: const Text('حول التطبيق',textAlign:AppAlign),
            onTap: (){Navigator.push(context,RoyalNavigatorElasticInOut(AppInformation()));},),
          ListTile(
            trailing:const Icon(Icons.logout,color: Colors.black,),
            title: const Text('تسجيل خروج',textAlign:AppAlign,style: TextStyle(color: Colors.black),),
            onTap: () async{await baselocal.logout();},),
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
