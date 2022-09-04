import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Handler/AnswerHandler/answer_handler.dart';
import 'package:learningplatform_rb/Models/ExamModel/exam_model.dart';
// ignore: must_be_immutable
class ExamTime extends StatefulWidget {
  ExamTime(this.examModel,this.answerHandler,{Key key}):super(key: key);
  final ExamModel examModel;
 final  AnswerHandler answerHandler;
  @override
  _ExamTimerState createState() => _ExamTimerState();
}

class _ExamTimerState extends State<ExamTime> {
  Timer timer;
  int minutes;
  int seconds=60;
  @override
  void initState() {
   minutes=widget.examModel.minutes;
   runTimer();
    super.initState();
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  runTimer(){
    timer=Timer.periodic(const Duration(seconds:1), (timer) {
      if(seconds==0){
        minutes--;
        seconds=60;
      }
      else if(minutes==0){
        Navigator.pop(context);
        widget.answerHandler.reFormat();
        Constans.toast("تم انتهاء وقت الامتحان",false);
      }
      else{
        seconds--;
      }
      setState(() {

      });
    });
  }


  @override
  Widget build(BuildContext context) {
  return Container(
    padding:const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color:Colors.red.shade300,
      borderRadius:const BorderRadius.all(Radius.circular(15)),
      boxShadow: const [
        BoxShadow(
          color:Colors.black12,
          blurRadius:9.0,
        )
      ]
    ),
    child: Row(
      mainAxisAlignment:MainAxisAlignment.center,
      mainAxisSize:MainAxisSize.min,
      children: [
        Text(minutes.toString()+" دقيقة ",textAlign:TextAlign.right,style:const TextStyle(color:Colors.white),),
        const SizedBox(width:5,),
        Text(seconds.toString()+" ثانية ",textAlign:TextAlign.right,style:const TextStyle(color:Colors.white),),

      ],
    ),
  );
  }
}
