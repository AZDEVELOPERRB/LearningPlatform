import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Mission/mission.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/BottomClasses/Home/Subjects/SingleSubjectView.dart';
import 'package:learningplatform_rb/UI/Teacher/Exams/AllExams/all_exams.dart';
import 'package:learningplatform_rb/UI/Teacher/Exams/CreateExam/create_exam.dart';
import 'package:learningplatform_rb/providers/TeachersMissions/teacher_missions.dart';
  class TeacherMissions extends StatefulWidget {
  @override
  _TeacherMissionsState createState() => _TeacherMissionsState();
}

class _TeacherMissionsState extends State<TeacherMissions> {
    final TeacherMissionsProvider provider=TeacherMissionsProvider();
    @override
  void initState() {
    provider.init();
    super.initState();
  }
    @override
    Widget build(BuildContext context) {
      final Size size=MediaQuery.of(context).size;
    return  Stack(
      children: [
        ValueListenableBuilder<List<Mission>>(valueListenable:provider.missions,
            child:const SizedBox(),
            builder:(BuildContext context,List<Mission> value,child){
          if(value==null) return child;
          return ListView.builder(
            itemCount:value.length,
            itemBuilder:(context,index){
              final Mission mission=value[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(child:
                Container(
                  width: size.width,
                  decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(30),
                    color:Colors.white,
                    boxShadow:[
                      BoxShadow(
                        color:Colors.black26,
                        blurRadius:9.0,
                        spreadRadius:1.0
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                    children: [
                     if(mission.subject?.image?.url!=null)CachedNetworkImage(
                         imageUrl:mission.subject.image.url,height:130,),
                      Text('مادة ${mission.subject.name}',style:const TextStyle(color:Colors.black,fontSize:22,fontWeight:FontWeight.bold),textAlign:TextAlign.center,),
                      Text('الصف ${mission.subject.classType.name}',style:const TextStyle(color:Colors.black54,fontWeight:FontWeight.bold),textAlign:TextAlign.center,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RoyalRoundedButton("جميع الامتحانات",(){
                            Navigator.push(context,RoyalNavigatorElasticInOut(AllExams(mission?.subject?.id)));
                          },buttoncolor:Colors.deepOrange.shade300,circular:25,),
                          RoyalRoundedButton("انشاء امتحان",(){
                           Navigator.push(context,RoyalNavigatorElasticInOut(CreateExam(mission?.subject?.id)));
                          },buttoncolor:Colors.blue,circular:25,),
                        ],
                      ),
                      const SizedBox(height:10,),
                     Padding(
                       padding:const EdgeInsets.all(8.0),
                       child:RoyalRoundedButton(
                         "فصول المادة",(){
                           Navigator.push(context,RoyalNavigatorElasticInOut(SingleSubjectClass(mission.subject,isStudent:false,)));
                       },
                         circular:15,
                         buttoncolor:Colors.brown.shade300,
                       ),
                     )
                    ],
                  ),
                ),),
              );
            },
          );
            }),

        ValueListenableBuilder<bool>(valueListenable:provider.loading,
            child:const SizedBox(),
            builder:(BuildContext context,bool load,child){
              if(load==true) return  const RoyalLoadingLinear();
              return child;})
      ],
    );
    }
}
