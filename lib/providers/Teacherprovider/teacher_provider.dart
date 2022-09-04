import 'package:flutter/cupertino.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/Students/Customer.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/Repos/TeacherRepo/teacher_repo.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';
import 'package:learningplatform_rb/database/base_local.dart';
import 'package:learningplatform_rb/providers/NotificationProvider/notification_provider.dart';
class TeacherProvider{
  ValueNotifier<User> userNotifier=ValueNotifier(null);
  final TeacherRepo teacherRepo=TeacherRepo();
  NotificationsProvider notificationsProvider=NotificationsProvider(Api.teacherCompanyNotification);
  NotificationsProvider privateNotificationProvider=NotificationsProvider(Api.getGradeNotifications);
  final RoyalLoading loading=RoyalLoading();
  login(Map body)async{
    teacherRepo.token=null;
    final RS rs= await teacherRepo.tLogin(body);
    try {
      userNotifier.value=User.fromjson(rs.data);
      return rs;
    }catch(e){}return null;}


    getUser(){
    if(userNotifier.value==null){
      setUser();
     }return userNotifier.value;}

     teacherHandleFCM()async{
    await Future.delayed(const Duration(seconds:3));
    final String fcm=await Constans.fcm();
    if(userNotifier.value!=null&&userNotifier.value?.fcm!=null&&userNotifier.value.fcm!=fcm){
      teacherRepo.token=userNotifier.value.token;
      return await teacherRepo.updateFcm({"fcm":fcm});
    }
     }


      setUser()async{
        try{
          final User localUser= BaseLocal().userModel();
          userNotifier.value=localUser;
          teacherRepo.token=localUser.token;
          return localUser;
        }catch(e){
          /// must Call The Logout Method
          print(e.toString());
        }
      }



  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      /// Teacher information Text Controller
        TextEditingController nameController=TextEditingController();
        TextEditingController emailController=TextEditingController();
        TextEditingController phoneController=TextEditingController();
        TextEditingController passwordController=TextEditingController();
        TextEditingController confirmPasswordController=TextEditingController();


  initTextEditingController(){
    nameController=TextEditingController(text:userNotifier.value.name);
    emailController=TextEditingController(text:userNotifier.value.email);
    phoneController=TextEditingController(text:userNotifier.value.phone);
  }
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


     /// Teacher Update Functions
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  updatePassword(BuildContext context)async{
    if(passwordController.text.isEmpty){Constans.toast("كلمة السر مطلوبة",false);return;}
    if(passwordController.text!=confirmPasswordController.text){Constans.toast("كلمات السر غير متطابقة",false);return;}
    final Map body={"password":passwordController.text,'confirmPassword':confirmPasswordController.text};
    loading.loading(context);
    await debugTimer();
    await teacherRepo.updatePassword(body);
    loading.cancel();
  }
  refresh()async{
    teacherRepo.token=BaseLocal.token();
   await teacherRepo.refresh();
  }
  update(BuildContext context)async{
    final Map body={"name":nameController.text, "phone":phoneController.text, "email":emailController.text,};
    loading.loading(context);
    await debugTimer();
    final RS response=await teacherRepo.updateTeacher(body);
    loading.cancel();
    if(response.saveAuth()){setUser();}
  }
  debugTimer()async{
    await Future.delayed(const Duration(seconds: 2));
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static final TeacherProvider instance=TeacherProvider._();
  TeacherProvider._();
}