import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/ExamModel/exam_model.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';
import 'package:learningplatform_rb/UI/SingleExam/single_exam.dart';
import 'package:learningplatform_rb/UI/Teacher/Correct/AllAnswers/all_answers.dart';
import 'package:learningplatform_rb/providers/ExamProvider/AllExamsProvider/all_exams_provider.dart';
class AllExams extends StatefulWidget {
   AllExams(this.subject):provider=AllExamsProvider(id:subject);
  final String subject;
  final AllExamsProvider provider;
  @override
  _AllExamsState createState() => _AllExamsState();
}

class _AllExamsState extends State<AllExams> {
  @override
  void initState() {
    widget.provider.initialize();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:70,
        backgroundColor:Colors.blue.withOpacity(0.5),
        centerTitle:true,
        elevation:4,
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.vertical(
            bottom:Radius.elliptical(size.width, 56.0),
          ),
        ),
      ),
      body:Stack(
        children: [
          ListView(
            children: [
              const  SizedBox(height:10,),
              ValueListenableBuilder<List<ExamModel>>(valueListenable:widget.provider.exams,
                  builder:(BuildContext context,List<ExamModel> exams,_){
                if(exams==null) return const SizedBox();
                return Directionality(
                  textDirection:TextDirection.rtl,
                  child: ListView.builder(
                    itemCount:exams.length,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder:(BuildContext context,final int index){
                      final ExamModel exam=exams[index];
                      return Container(
                        margin:const EdgeInsets.all(8.0),
                        padding:const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color:Colors.white,
                          boxShadow:[
                            BoxShadow(
                              color:Colors.black26,
                              blurRadius:9.0,
                              spreadRadius:1.0
                            )
                          ],
                          borderRadius:BorderRadius.all(Radius.circular(15))
                        ),
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height:10,),
                            Text(exam.name,style:const TextStyle(color:Colors.brown,fontSize:18,fontWeight: FontWeight.w900),),
                            const SizedBox(height:25,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children:[
                                RoyalRoundedButton('تصحيح الاجوبة',(){
                                  Navigator.push(context,RoyalNavigatorElasticInOut(AllAnswers(exam)));
                                },circular:25,
                                  buttoncolor:Colors.blue,),
                                RoyalRoundedButton('رؤية الاسئلة',(){
                                  Navigator.push(context,RoyalNavigatorElasticInOut(SingleExam(exam,answersHint:true,)));
                                },circular:25,
                                  buttoncolor:Colors.deepOrange.shade400,),
                                RoyalRoundedButton('حذف الامتحان',(){
                                RoyalDialog.showMessage(context,
                                    height:size.height/3,
                                    message:'هل تريد فعلاً حذف هذا الامتحان ؟',
                                    onAgree:(){
                                  Navigator.pop(context);
                                 widget.provider.deleteExam(index,context);
                                });
                                },circular:25,
                                  buttoncolor:Colors.red.shade400,)
                              ]),
                            const SizedBox(height:20,),
                          ],
                        ),
                      );
                    },
                  ),
                );
                  }),
             const  SizedBox(height:25,),
            ],
          ),
          ValueListenableBuilder<bool>(valueListenable:widget.provider.loading,
              child:const SizedBox(),
              builder:(BuildContext context,bool load,child){
            if(load==true) return  const RoyalLoadingLinear();
            if(load==false&&widget.provider?.pagination?.next!=null)return  Align(
              alignment:const Alignment(-0.9,0.95),
              child: RoyalRoundedButton("تحميل المزيد",(){widget.provider.initialize();},circular:35,),);
              return child;
              })
        ],
      ),
    );
  }
}
