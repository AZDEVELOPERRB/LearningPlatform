import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/UI/Animation/RoyalLoading.dart';
import 'package:learningplatform_rb/UI/RoyalTriger/AppTriger.dart';
import 'package:learningplatform_rb/providers/Teacherprovider/teacher_provider.dart';

class TeacherAuthScreen extends StatelessWidget {
  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();
  final RoyalLoading loading=RoyalLoading();
  final String emailTest="ahmedhasnawi@gmail.com";
  final String passwordTest="12345678";
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      body:ListView(
        children: [
          const SizedBox(height:25,),
          Center(child:Image.asset("Assets/images/logo.png",height:size.height/5,),),
          SizedBox(height:size.height/6,),
          RoyalInputTextField("البريد الالكتروني",email),
          RoyalInputTextField("كلمة السر",password,password:true,),
          const SizedBox(height:25,),
          Align(
            child: RoyalRoundedButton("تسجيل دخول", ()async{
             if(!Constans.royalDebug)if(!Constans.checkTextInputs([email,password]))return;
              loading.loading(context);
             try{
               final RS response= await TeacherProvider.instance.login({
                 "email":Constans.royalDebug?"ahmedhasnawi@gmail.com":email.text,
                 "password":Constans.royalDebug?"12345678":password.text
               });
               if(response.check()){moveToDashboard(context);}
             }catch(e){
               print(e.toString());
             }
              loading.cancel();
            },buttoncolor:Colors.blue,circular: 15,),),
          Align(
            child: RoyalRoundedButton("هل انت طالب مدرسي ؟", ()async{
             moveToDashboard(context);
            },circular:25,),
          ),

        ],
      ),
    );
  }
  void moveToDashboard(BuildContext context){
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(context)=>RoyalTriger()),(route) => false);
  });
  }
}
