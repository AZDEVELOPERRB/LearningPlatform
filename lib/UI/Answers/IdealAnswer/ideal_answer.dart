import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/IdealAnswer/ideal_answer.dart';
class IdealAnswerTeacher extends StatelessWidget {
  IdealAnswerTeacher(this.answer);
  final IdealAnswer answer;
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize:MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 10,),
          const Text('الجواب النموذجي',style:TextStyle(fontWeight:FontWeight.bold,fontSize: 18,color:Colors.pinkAccent),),
          const SizedBox(height: 10,),
         if(answer.images?.first?.url!=null) RoyalCacheImage(answer.images?.first?.url??"",
            width:size.width,
           fit:BoxFit.fill,
         takeRequiredSpace:true,),
          const SizedBox(height: 20,),
          if(answer.title!=null)Text(answer.title,style:const TextStyle(color:Colors.brown),textAlign:TextAlign.right,),
        ],
      ),
    );
  }
}
