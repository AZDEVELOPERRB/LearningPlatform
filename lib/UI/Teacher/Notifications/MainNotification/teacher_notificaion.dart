import 'package:flutter/material.dart';
import 'package:learningplatform_rb/UI/Notifications/CompanyNotification/company_notification.dart';
import 'package:learningplatform_rb/providers/Teacherprovider/teacher_provider.dart';
class TeacherNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar:AppBar(
          bottom: TabBar(
            tabs:[
              Tab(child:Text('اشعارات الشركة'),),
              Tab(child:Text('الاشعارات الشخصية'),),
            ],
          ),
        ),
        body:TabBarView(
          children:[
            CompanyNotifications(TeacherProvider.instance.notificationsProvider),
            CompanyNotifications(TeacherProvider.instance.privateNotificationProvider),
          ],
        )
      ),
    );
  }
}
