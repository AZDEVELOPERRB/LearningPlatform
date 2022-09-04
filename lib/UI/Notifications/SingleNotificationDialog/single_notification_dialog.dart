import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Models/Notification/company_notification.dart';
class SingleNotificationDialog extends StatelessWidget {
  final  CompanyNotificationModel model;
  SingleNotificationDialog(this.model);

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Material(
      color:Colors.transparent,
      child:Center(
        child: Container(
          height:size.height/1.7,
          width:size.width,
          margin:const EdgeInsets.all(8),
          decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(15),
              color:Colors.white
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize:MainAxisSize.max,
            children:[
              const Icon(Icons.notifications_active,color:Colors.amber,size:30,),
              Text(model.title,style:const TextStyle(fontWeight:FontWeight.bold,fontSize:18),),
              Container(
                height:size.height/3,
                padding: const EdgeInsets.all(14.0),
                alignment:Alignment.center,
                child:   SingleChildScrollView(
                  scrollDirection:Axis.vertical,
                  child: Center(
                    child: Text(model.body,textAlign:TextAlign.center,
                      style:const TextStyle(color:Colors.black54),
                      overflow:TextOverflow.visible,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceAround,
                children:[
                  ///Back Button

                  RaisedButton(
                    onPressed:()=>Navigator.pop(context), color:Colors.brown,
                    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)
                    ), child:const Text('رجوع',style:const TextStyle(color:Colors.white)),),

                /// URL Launcher Button

                if(model.url!=null&&model.url!='')RaisedButton(
                      shape:RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(20)
                      ),
                      child:const Text('اظهار الرابط',style:const TextStyle(color:Colors.white),),
                      color:Colors.blue,
                      onPressed:()=>Constans.launchURL(model.url)),



                ],)
            ],
          ),

        ),
      ),
    );
  }

}