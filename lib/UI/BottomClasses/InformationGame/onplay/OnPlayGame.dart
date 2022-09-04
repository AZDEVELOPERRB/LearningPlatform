import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/infoGameModel/InfoGameAnswers.dart';
import 'package:learningplatform_rb/Models/infoGameModel/InfoGameModel.dart';
import 'package:learningplatform_rb/providers/gamesProvider/informationGame/informationgameProvider.dart';
class OnPlayGame extends StatelessWidget {
  final InfoGameLevels game;
  final InformationGameProvider provider;
  const OnPlayGame(this.game,this.provider);
  static const space=UiConstans.space50;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: UiConstans.Royabluebackground,
        child: Column(
          children: [
            space,
            Text(game.question,style: const TextStyle(fontSize: 20,color: Colors.brown),),
            Container(
              height: size.height/2.4,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (95 / 45),
                children: List.generate(game.answers.length, (index) =>Answer(game.answers[index],provider)
                ),
              ),
            ),
            Container(
              height: 50,
              width: 150,
              color: Colors.transparent,
              child: Container(
                height: 40,
                child: Stack(
                  children: [
                    Container(
                      child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child:Center(child: GameTimer(context))
                      ),
                    ),
                    Align(alignment:Alignment.centerLeft,child:Container(height:40,child:Image.asset("Assets/images/timer_icon.png")))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class Answer extends StatefulWidget {
  final InfoGameAnswers answer;
  final InformationGameProvider provider;
  const Answer(this.answer,this.provider);

  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  Color _color=Colors.grey[200];

  onpressed()async{
    widget.provider.postanswer(widget.answer.id);
    setState(() {
      _color=Colors.blue;
    });
      if(widget.answer.isright==1){
      Constans.toast("مبروك الاجابة صحيحة",true);
    }else{
        Constans.toast("اجابة خاطئة",false);
      }
    Navigator.pop(context);
   await Future.delayed(Duration(seconds: 2)).then((value) =>  Constans.ctoast("يجب ان تحافظ على الاتصال بالانترنت"));
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onpressed,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration:  BoxDecoration(
              color:_color,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Center(child: Text(widget.answer.answer),),
        ),
      ),
    );
  }
}
class GameTimer extends StatefulWidget {
  final BuildContext context;
  const GameTimer(this.context);
  @override
  _GameTimerState createState() => _GameTimerState();
}
class _GameTimerState extends State<GameTimer> {
  int time=30;
   Timer timer;
  @override
  void initState() {
    timer=
    Timer.periodic(Duration(seconds: 1), (timer) {
     if(time!=0){
       setState(() {
         time--;
       });
     }else{
       Constans.toast("لقد انتهى وقت ", false);
       Navigator.pop(widget.context);
     }
    });
    super.initState();
  }
  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return   Text("00 : $time",style:const TextStyle(fontSize: 18,color: Colors.orangeAccent));
  }
}

