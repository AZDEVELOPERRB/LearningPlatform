import 'package:flutter/material.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/Notifications/all_notification/all_notification.dart';
class NotificationSwitcher extends StatefulWidget {
  const NotificationSwitcher();
  @override
  _NotificationSwitcherState createState() => _NotificationSwitcherState();
}
class _NotificationSwitcherState extends State<NotificationSwitcher> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(child: IconButton(icon: Icon(Icons.notifications_active,color:Colors.amber.shade500,), onPressed:_onNotificationClick,iconSize:25,));
  }

void _onNotificationClick()async{
    Navigator.push(context,RoyalNavigatorElasticInOut(AllNotificaion()));
}
}
