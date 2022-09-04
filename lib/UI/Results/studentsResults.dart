import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/CustomerAnswer/customer_answer.dart';
import 'package:learningplatform_rb/UI/Animation/RoutesAnimation.dart';
import 'package:learningplatform_rb/UI/SingleExam/single_exam.dart';
import 'package:learningplatform_rb/providers/StudentResultsProvider/student_result_provider.dart';
class StudentResults extends StatefulWidget {
  @override
  _StudentResultsState createState() => _StudentResultsState();
}
class _StudentResultsState extends State<StudentResults> {
  final StudentResultsProvider provider=StudentResultsProvider();

  @override
  void initState() {
    provider.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Stack(
      children:[
        ValueListenableBuilder<List<CustomerAnswer>>(valueListenable:provider.allAnswers,
            child:const RoyalEmptyData(message: "لا توجد نتائج ",),
            builder:(BuildContext context,List<CustomerAnswer> answers,child){
              if(answers==null)return const SizedBox();
              if(answers.isEmpty)return child;
              return ListView.builder(
                itemCount:answers.length,
                itemBuilder:(BuildContext context,final int index){
                  final CustomerAnswer result=answers[index];
                  return Align(
                    child: Container(
                      width: size.width,
                      height: size.height/3,
                      margin: const EdgeInsets.symmetric(vertical:8.0,horizontal:4.0),
                      decoration:const BoxDecoration(
                          color:Colors.white,
                          image: DecorationImage(
                            image: AssetImage('Assets/images/profile.jpg'),
                            fit:BoxFit.cover
                          ),
                          borderRadius:BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color:Colors.black26,
                                blurRadius:9.0,
                                spreadRadius: 1.0
                            )
                          ]
                      ),
                      child:Stack(
                        children: [
                          Column(
                            children: [
                              space,
                              Center(child: Text(result.exam.name.contains(" امتحان ")?"":" امتحان "+result.exam.name,textDirection:TextDirection.rtl,
                              style:const TextStyle(fontWeight:FontWeight.w900,fontSize:17),
                              )),
                              space,
                             if(result.exam.subject?.name!=null)Text(" مادة "+ (result.exam.subject.name??""),textDirection:TextDirection.rtl,),
                              space,
                              Text(" عدد الاسئلة = "+result.exam.questions.length.toString(),textDirection:TextDirection.rtl,
                              textAlign:TextAlign.center,),
                              space,
                              space,
                              space,
                              RoyalRoundedButton("تفاصيل الامتحان",(){
                                Navigator.push(context, RoyalNavigatorElasticInOut(SingleExam(result.exam)));
                              },circular:20,buttoncolor:Colors.deepOrangeAccent,)
                            ],
                          ),

                          Align(
                            alignment:Alignment.bottomRight,
                            child:Container(
                              height:80,
                              width: 80,
                              decoration: BoxDecoration(
                                color:Colors.pink.shade300,
                                borderRadius:BorderRadius.only(topLeft:Radius.circular(100),
                                bottomRight:Radius.circular(15)
                                )
                              ),
                              child:Align(
                                alignment:const Alignment(0.25,0.2),
                                child:Text(result.result.toString()+" درجة ",
                              textAlign:TextAlign.center,
                              textDirection:TextDirection.rtl,
                              style: const TextStyle(
                                fontSize:14,
                                color:Colors.white,
                                fontWeight:FontWeight.bold
                              ),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
        ValueListenableBuilder<bool>(valueListenable:provider.loading,
            child:const SizedBox(),
            builder:(BuildContext context,bool load,child){
              if(load==true) return  const RoyalLoadingLinear();
              if(load==false&&provider?.pagination?.next!=null)return  Align(
                alignment:const Alignment(-0.9,0.95),
                child: RoyalRoundedButton("تحميل المزيد",(){provider.init();},circular:35,),);
              return child;})
      ],
    );
  }
  final SizedBox space=const SizedBox(height:10,);
}
