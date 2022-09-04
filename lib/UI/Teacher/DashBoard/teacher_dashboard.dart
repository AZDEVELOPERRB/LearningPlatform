import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/Teacher/BottomNavigationBar/Profile/teacher_profile.dart';
import 'package:learningplatform_rb/UI/Teacher/DashBoard/Drawer/teacher_drawer.dart';
import 'package:learningplatform_rb/UI/Teacher/Missions/teacher_missions.dart';
import 'package:learningplatform_rb/UI/Teacher/Notifications/MainNotification/teacher_notificaion.dart';
import 'package:learningplatform_rb/providers/Teacherprovider/teacher_provider.dart';
class TeacherDashboard extends StatefulWidget {
  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}
class _TeacherDashboardState extends State<TeacherDashboard> {
  int _selectedPage=1;
  final List<String> titles=[
    "الحساب الشخصي",
    "المواد المكلفة اليك",
  ];
  final List<Widget> _body=<Widget>[
    TeacherProfileHandler(),
    TeacherMissions(),
  ];
  @override
  void initState() {
    TeacherProvider.instance.getUser();
    TeacherProvider.instance.teacherHandleFCM();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      endDrawer: TeacherDrawer(),
      appBar: AppBar(
        title:Text(titles[_selectedPage]),
          toolbarHeight:70,
          backgroundColor:Colors.blue.withOpacity(0.5),
          centerTitle:true,
          elevation:4,
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.vertical(
              bottom:Radius.elliptical(size.width, 56.0),
            ),
          ),
        leading:IconButton(icon:Icon(Icons.notifications_active),color:Colors.amber,onPressed:(){
          Navigator.push(context, RoyalNavigatorElasticInOut(TeacherNotification()));
        },),
      ),
      bottomNavigationBar:BottomNavyBar(
        selectedIndex:_selectedPage,
        onItemSelected: (i){setState(() {_selectedPage=i;});},
        items:<BottomNavyBarItem>[
          BottomNavyBarItem(icon:Icon(Icons.person), title:Text('الملف الشخصي')),
          BottomNavyBarItem(icon:Icon(Icons.home), title:Text('الرئيسية'),),
        ],
      ),

      body:_body[_selectedPage]
    );
  }
}
