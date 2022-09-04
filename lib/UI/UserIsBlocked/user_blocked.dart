import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/database/base_local.dart';
class UserisBlocked extends StatelessWidget {
  const UserisBlocked();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          image:DecorationImage(
            image:AssetImage('Assets/images/profile.jpg'),
            fit:BoxFit.cover
          )
        ),
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children:[
            const Center(
              child:Text('هذا المستخدم محظور يرجى التواصل مع الشركة لفتح الحظر عن حسابك !',
              textAlign:TextAlign.center,),
            ),
            RoyalRoundedButton("تسجيل خروج",(){
              BaseLocal().logout();
            },circular:15,)
          ],
        ),
      ),
    );
  }
}
