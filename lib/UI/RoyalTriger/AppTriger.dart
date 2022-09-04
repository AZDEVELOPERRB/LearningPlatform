import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Models/Students/Customer.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/RoyalServices/UIServices/RoyalNotifier.dart';
import 'package:learningplatform_rb/UI/Auth/Login.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learningplatform_rb/Constans/locals_constans.dart';
import 'package:learningplatform_rb/UI/Home/Home_Screen.dart';
import 'package:learningplatform_rb/UI/Teacher/DashBoard/teacher_dashboard.dart';
import 'package:learningplatform_rb/UI/UserIsBlocked/user_blocked.dart';
class RoyalTriger extends StatelessWidget {
  final String localDatabase=Local_Constans.local_user_info;
  final LoginScreen login =const LoginScreen();
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
          future: Hive.openBox(localDatabase),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ValueListenableBuilder(
                valueListenable: Hive.box(localDatabase).listenable(),
                builder: (context ,Box box, _){
                  if(box.values.isEmpty){
                    return login;
                  }
                  else{
                  final  RS royalresponse=author(box);
                    if(royalresponse.Auth()==true){
                     try{
                       User user=User.fromjson(royalresponse.data);
                       if(user.status==0)return const UserisBlocked();
                       if(user.isTeacher==false){
                         return RoyalNotifier(child: HomeScreen(user));
                       }else if(user.isTeacher==true){
                          return TeacherDashboard();
                       }
                     }catch (e){
                     }
                    }
                    return login;
                  }
                  },
              );
            }
            else{
              return const SizedBox();
            }});
  }
  author(Box box){
    final data=box.get(Local_Constans.local_user_key);
    RS _rs=RS.fromJson(data);
    return _rs;
  }
}

