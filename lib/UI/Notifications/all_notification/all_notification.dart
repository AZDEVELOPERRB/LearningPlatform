import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Api.dart';
import 'package:learningplatform_rb/UI/Notifications/CompanyNotification/company_notification.dart';
import 'package:learningplatform_rb/providers/NotificationProvider/notification_provider.dart';
class AllNotificaion extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}
class ProfilePageState extends State<AllNotificaion> {
  final NotificationsProvider companyNotificationProvider=NotificationsProvider(Api.companyNotification);
  final NotificationsProvider schoolNotification=NotificationsProvider(Api.schoolNotification);
  final NotificationsProvider gradeNotification=NotificationsProvider(Api.gradeNotification);
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height:size.height/6,
              child: AppBar(
                backgroundColor:Colors.blue.withOpacity(0.5),
                bottom: const TabBar(

                  indicatorColor:Colors.blue,
                  tabs:const [
                    Tab(
                     child:const Text('اشعارات الشركة'),
                    ),
                    Tab(
                      child:const Text('اشعارات الدراسة'),
                    ),
                    Tab(
                      child:const Text( 'اشعارات المرحلة'),
                    ),

                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  CompanyNotifications(companyNotificationProvider),
                  CompanyNotifications(schoolNotification),
                  CompanyNotifications(gradeNotification),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}