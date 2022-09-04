import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Models/infoGameModel/InfoGameModel.dart';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';
import 'package:learningplatform_rb/UI/BottomClasses/InformationGame/onplay/onPlayInfoGameDialog.dart';
import 'package:learningplatform_rb/providers/gamesProvider/informationGame/informationgameProvider.dart';
class SingleLevel extends StatelessWidget {
  final InfoGameLevels game;
  final InformationGameProvider provider;
  SingleLevel(this.game,this.provider);
  final double startssize=19;
 final truestar=Colors.amber;
 final falseestar=Colors.grey[500];
 final errors=Colors.red;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        RoyalDialog.publicDialog(context,
        Container(height: 210, child:OnPlayInfoGameDialog(game,provider)));},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color:game.progress==1?game.stars>0?Colors.orangeAccent:errors:falseestar,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black38),boxShadow: [BoxShadow(color: Colors.blue)]
                  ),
                  child: Center(child: Text((game.t).toString(),style: const TextStyle(color: Colors.white,fontSize: 24)))
                ),
              ),
              Positioned(top: 0,left: 0,
              child:Container(
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(8)
                 ),

                  child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(Icons.lock,color: Colors.blue[200],),
              )),)
            ],
          ),
          stars()
        ],
      ),
    );
  }
  Widget stars(){
   return Container(width: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.star,size: startssize,color: game.stars>0?truestar:falseestar,),
          Column(children: [SizedBox(height: 15,), Icon(Icons.star,size: startssize,color: game.stars>1?truestar:falseestar,)],),
          Icon(Icons.star,size: startssize,color: game.stars>2?truestar:falseestar,),
        ],
      )
    );
  }
}
