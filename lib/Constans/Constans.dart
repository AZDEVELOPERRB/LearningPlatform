import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learningplatform_rb/Constans/Countries.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Constans/locals_constans.dart';
import 'package:url_launcher/url_launcher.dart';

class Constans{
static const bool royalDebug=false;


static const List<Map>  contries=CIS.Countries;
static const modelerror="يوجد خطأ في التحديثات الجديدة للتطبيق يرجى اعادة التسجيل الدخول";
static const String imagePath="Assets/images/";
static const String logoPath="Assets/images/logo.png";




static const List<String> localDataBases=[
  Local_Constans.painationDataBase,
  Local_Constans.ankiSchedule,
  Local_Constans.grades_local,
  Local_Constans.infogame_local,
  Local_Constans.local_user_info,
  Local_Constans.Countries,
  Local_Constans.seen,
  Local_Constans.subjectsBox,
  Local_Constans.royalGeneralProvider,
  Local_Constans.teachersMissions,
  Local_Constans.pagination,
];






static jumpTo(BuildContext context,Widget child){
  Navigator.push(context,MaterialPageRoute(builder:(BuildContext context)=>AppDirection(child:child)));
}



  /// Scheduling
 static int ankiSchedulingHours({@required int hours,oldHours}){
    oldHours??=0;
    return hours+(oldHours*2);
  }


static bool isEmail(String em) {

  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}


static toast(String m,bool s){
  Fluttertoast.showToast(msg: m,backgroundColor:s?Colors.green:Colors.red);

}
static ctoast(String m,{Color color}){
  Fluttertoast.showToast(msg: m,backgroundColor:color??Colors.grey);

}
royaltoast(String m,bool s){
  Fluttertoast.showToast(msg: m,backgroundColor: s?Colors.green:Colors.red);
}

bool passwordconfirm(String password,confirmpassword){
  if(password==confirmpassword){
    return true;
  }
  royaltoast("كلمات السر غير متطابقة", false);
  return false;
}

static iniNoti(){
  final FirebaseMessaging _fcm = FirebaseMessaging();

  if (Platform.isIOS) {
    _fcm.requestNotificationPermissions(const IosNotificationSettings());
  }

  _fcm.configure(
      onMessage: (msg) async{
      },
      onLaunch: (msg)async {
      },
      onResume: (msg) async{
        print(msg);}, onBackgroundMessage:   null);
  _fcm.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true,alert: true,badge: true
      )
  );
}

static String shareApp(){
  return 'مرحبا صديقي اذا بعدك مامحمل هذا التطبيق الدراسي العظيم فانت جاي تخسر وقت حمله باسرع وقت وشوف الامتحانات والدراسة شلون حلوة بيه'
      '\n'
      'رابط تحميل التطبيق'
      '\n'
      'https://play.google.com/store/apps/details?id=com.royalboardcompany.learningplatform_rb';
}

static launchURL(String url,{final String message='لا يمكن فتح هذا الرابط'}) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
   if(message!=null)toast(message,false);
  }
}
static fcm<String>()async{
  FirebaseMessaging _fcm=FirebaseMessaging();
  _fcm.configure();
  return await _fcm.getToken().then((value){
    return value.toString();
  });

}

static const String AppDescription="قال تعالى (( وقل ربي زدني علما )) طه 114 "
    "\n"
    "منصة الصف التعليمية هي منصة عراقية مجانية"
    "\n"
    "نسعى لتقديم التعليم بتجربة فريدة للجميع"
    "\n"

    "." "بعيداً عن الاحتكار بأسلوب حديث ومدروس "
    "\n"

     "الدروس مصورة ولكافة المراحل الدراسية ويقدمها نخبة من اساتذة العراق "
    "بشكل مقاطع فيديو وامتحانات الكترونية وملخصات لكل درس وامتحانات شاملة تصحح"
    " بواسطة أساتذة متخصصين في المادة"
    "\n"
    "نتمنى لكم التوفيق والنجاح"
;

static const founder="المؤسس أ.أحمد فرحان العكيلي";

static final List<ExamType> examTypes=[
  ExamType(id: 'select',name: 'سؤال اختيارات'),
  ExamType(id: 'normal',name: 'سؤال نصي'),
];


  static bool checkTextInputs(final List<TextEditingController> all,{final String message}){
    for(TextEditingController single in all){
      if(single==null||single.text.isEmpty){
        toast(message??"جميع الحقول مطلوبة",false);
        return false;
      }
    }
    return true;
  }
  static bool isNumeric(final String data){
    if(data==null)return false;
    return double.tryParse(data)!=null;
  }
static bool isInteger(final String data){
  if(data==null)return false;
  return int.tryParse(data)!=null;
}
 static Future futureDebug()async{
  return await Future.delayed(const Duration(seconds:1));
 }
}

class ExamType{
   String id;
   String name;
  ExamType({this.id, this.name});
  ExamType.fromjson(final json){
    id=json['id'];
    if(id=="select")name="سؤال اختيارات";
    if(id=="normal")name="سؤال نصي";
  }
}