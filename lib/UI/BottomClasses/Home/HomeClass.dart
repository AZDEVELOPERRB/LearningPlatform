import 'package:flutter/material.dart';
import 'package:learningplatform_rb/UI/BottomClasses/Home/FirstersStudents/firsters_student.dart';
import 'package:learningplatform_rb/UI/BottomClasses/Home/Subjects/SubjectClass.dart';
class HomeClass extends StatefulWidget {
  @override
  _HomeClassState createState() => _HomeClassState();
}

class _HomeClassState extends State<HomeClass> {

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height:size.height/10,
          child:Center(child:Text('المواد الدراسية',style:const TextStyle(color:Colors.brown,fontWeight: FontWeight.w800,fontSize: 20),),),
        ),
        SubjectsClass(),
        Center(child:Text('الطلبة المتفوقين',textAlign:TextAlign.center,style:const TextStyle(
            color:Colors.brown,fontWeight: FontWeight.w800,fontSize: 20),),),
        const FirsterStudent()
      ],
    );

  }
}

