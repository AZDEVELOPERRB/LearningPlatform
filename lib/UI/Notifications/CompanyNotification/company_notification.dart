import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Notification/company_notification.dart';
import 'package:learningplatform_rb/UI/Notifications/SingleNotificationDialog/single_notification_dialog.dart';
import 'package:learningplatform_rb/providers/NotificationProvider/notification_provider.dart';
class CompanyNotifications extends StatelessWidget {
  final NotificationsProvider provider;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        ValueListenableBuilder<List<CompanyNotificationModel>>(valueListenable:provider.notifier,
            builder:(BuildContext context,List<CompanyNotificationModel> value,_){
          if(value.isEmpty&&provider.loading.value==false)return const RoyalEmptyData();
              return ListView.builder(
                  itemCount:provider.notifier.value.length,
                  itemBuilder:(BuildContext context,index){
                  final  CompanyNotificationModel model=value[index];
                    return Container(
                      margin:const EdgeInsets.only(top:4,left:2,right:2),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:Colors.white,
                        border:Border.all(color:Colors.black12),
                        borderRadius:BorderRadius.circular(19),
                        boxShadow:[
                          BoxShadow(
                            color:Colors.black.withOpacity(0.2),
                            spreadRadius:0.3,
                            blurRadius:12.0,
                          )
                        ]
                      ),
                      child: ListTile(
                        onTap:(){showDialog(context:context,builder:(BuildContext context){return SingleNotificationDialog(model);});},
                        leading:const Icon(Icons.notifications_active,color:Colors.amber),
                        trailing:Text(value[index].title,textAlign:TextAlign.right,),
                      ),
                    );
                  });
            }),

        ValueListenableBuilder<bool>(valueListenable:provider.loading,
            child:Align(
                alignment:const Alignment(0.0,0.95),
                child: const LinearProgressIndicator()),
            builder:(BuildContext context,bool value,child){
              if(value)return child;
              return const SizedBox();
            }),
        ValueListenableBuilder<bool>(valueListenable:provider.loading,
            child:Align(
                alignment:const Alignment(0.0,0.95),
                child: const LinearProgressIndicator()),
            builder:(BuildContext context,bool value,child){
          if(provider.pagination!=null&&provider.pagination.next==null||provider.pagination==null)return const SizedBox();
              return   Align(
                alignment:const Alignment(-0.98,0.92),
                child:RaisedButton(
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(!value?'المزيد':'جاري التحميل',style:const TextStyle(color:Colors.white),),
                  color:Colors.lightBlueAccent,
                  onPressed:()=>!value?provider.internet():Constans.toast('جاري التحميل يرجى الانتظار',true),
                ),
              );
            }),

      ],
    );
  }

  CompanyNotifications(this.provider);
}

