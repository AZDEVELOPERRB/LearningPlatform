import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/infoGameModel/InfoGameModel.dart';
import 'package:learningplatform_rb/UI/BottomClasses/InformationGame/onplay/OnPlayGame.dart';
import 'package:learningplatform_rb/providers/gamesProvider/informationGame/informationgameProvider.dart';
class OnPlayInfoGameDialog extends StatelessWidget {
  final InfoGameLevels game;
  final InformationGameProvider provider;
  const OnPlayInfoGameDialog(this.game,this.provider);
 static const space=UiConstans.space25;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('اسئلة عامة عن العراق',style: TextStyle(color: Colors.orangeAccent,fontSize: 22),),
        space,
        Container(
          height: 50,
          child: Container(
            height: 40,
            child: Stack(
              children: [
                Container(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child:const Center(child: Text("00 : 30",
                      style:const TextStyle(fontSize: 18,color: Colors.orangeAccent)))
                  ),
                ),
                Align(alignment:Alignment.centerLeft,child:Container(height:40,child:Image.asset("Assets/images/timer_icon.png")))
              ],
            ),
          ),
        ),
        space,
        InkWell(
          onTap: (){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (ctx)=>OnPlayGame(game,provider)));
          },
          child: Container(
            height: 50,
            width: 55,
            decoration: BoxDecoration(color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.amberAccent,width:3)
            ),
            child: Icon(Icons.play_arrow,color: Colors.white,size: 35,),
          ),
        )
      ],
    );
  }
}



