import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:learningplatform_rb/Models/Students/Customer.dart';
import 'package:learningplatform_rb/Repos/userRepo.dart';
import 'package:learningplatform_rb/RoyalServices/RoyalNotification/RoyalNotification.dart';
import 'package:learningplatform_rb/UI/Anki/AnkiSubjects/anki_subjects.dart';
import 'package:learningplatform_rb/UI/BottomClasses/Home/HomeClass.dart';
import 'package:learningplatform_rb/UI/BottomClasses/InformationGame/InformationGame.dart';
import 'package:learningplatform_rb/UI/BottomClasses/Profile/Profile.dart';
import 'package:learningplatform_rb/UI/GradesSelect/GradesSelect.dart';
import 'package:learningplatform_rb/UI/Home/RoyalDrawer.dart';
import 'package:learningplatform_rb/UI/Notifications/swticher/notification_switcher.dart';
import 'package:learningplatform_rb/UI/Results/studentsResults.dart';
class HomeScreen extends StatefulWidget {
final User user;
const HomeScreen(this.user);
  @override
  HomeScreenState createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  int hindex=3;
 final Color  inactivecolor=Colors.blueGrey;
 final Color  activecolors=Colors.blue;
 final  RoyalNotification royalNotification=RoyalNotification();
 final  UserRepo repo=UserRepo();
  User user;
 bool isfirsttime=true;
  @override
  void initState() {
    super.initState();
    initialuser();
  }

  List<String> titles=[
  "نتائج الامتحانات",
    "نظام التكرار المتباعد",
    "الملف الشخصي",
    "الرئيسية",
  ];


  final List<Widget> _body=[
    StudentResults(),
    AnkiSubjects(),
    Profile(),
    HomeClass()
  ];


  @override
  Widget build(BuildContext context) {
    if(isfirsttime){
      royalNotification.initialize(context);isfirsttime=false;
    if(widget.user.grade==null){return  Scaffold(body: SelectGrades(),);}
    }
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight:70,
        backgroundColor:Colors.blue.withOpacity(0.5),
        title: Text(titles[hindex]),
        centerTitle:true,
          elevation:4,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.vertical(
              bottom: new Radius.elliptical(size.width, 56.0),
            ),
          ),
       leading:const NotificationSwitcher()
      ),
        endDrawer: RoyalDrawer(),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex:hindex,
        onItemSelected: (i){setState(() {hindex=i;});},
        items:<BottomNavyBarItem>[
          BottomNavyBarItem(icon:Icon(Icons.border_color),title:Text('الامتحانات'),inactiveColor:inactivecolor,activeColor: activecolors),
          BottomNavyBarItem(icon:Icon(Icons.book), title:Text('التكرار المتباعد'),inactiveColor:inactivecolor,activeColor: activecolors),
          BottomNavyBarItem(icon:Icon(Icons.person), title:Text('الملف الشخصي'),inactiveColor:inactivecolor,activeColor: activecolors),
          BottomNavyBarItem(icon:Icon(Icons.home), title:Text('الرئيسية'),inactiveColor:inactivecolor,activeColor: activecolors),
        ],
      ),
      body:_body[hindex]
    );
  }
  initialuser(){if(widget.user.fcm==null||widget.user.fcm==""){repo.firstfcm();}}
}
