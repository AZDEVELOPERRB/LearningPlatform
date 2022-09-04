import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Constans/settings.dart';
import 'package:learningplatform_rb/UI/RoyalTriger/AppTriger.dart';
import 'package:learningplatform_rb/main.dart';
class PrivacyAndPolicy extends StatefulWidget {
    const PrivacyAndPolicy({this.showTrigger=true});
    final bool showTrigger;
  @override
  _PrivacyAndPolicyState createState() => _PrivacyAndPolicyState();
}
class _PrivacyAndPolicyState extends State<PrivacyAndPolicy> {
  final Seen seen=Seen();
  bool read=false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    final bool readBefore=seen.privacyAndPolicy();
    if(readBefore&&widget.showTrigger)return  RoyalTriger();
    return AppDirection(
      child: Scaffold(
        appBar:AppBar(
          title:const Text('سياسة الخصوصية'),
          centerTitle:true,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.vertical(
              bottom: new Radius.elliptical(size.width, 56.0),
            ),
          ),
          toolbarHeight:70,
        ),
        body:ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('سياسة خصوصية منصة الصف التعليمية',style:const TextStyle(fontSize:17,fontWeight:FontWeight.bold,),textAlign:TextAlign.right,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(RoyalAppSettings.privacyAndPolicy,textAlign:TextAlign.right,),
            ),
            if(!readBefore)  Padding(padding:const EdgeInsets.all(0.0),
            child:Row(
              children: [

                Checkbox(

                    value:read,
                    onChanged:(value){setState(() {read=!read;});}

                    ),


                const SizedBox(width:5,),

                Text('هل قمت بقرائة سياسة الخصوصية للشركة ؟')

              ],
            ),),

           if(!readBefore) Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoyalRoundedButton(
                "اوافق",(){

                if(!read)return Constans.toast("يجب الموافقة على سياسة الخصوصية",false);

                setReadingFunction();

                },
              circular:20,
              buttoncolor:read?Colors.blue:Colors.grey.withOpacity(0.01),
              ),
            )
          ],
        ),
      ),
    );
  }


  void setReadingFunction()async{
    seen.setReadingForPrivacyAndPolicy();
    setState(() {});
  }
}
