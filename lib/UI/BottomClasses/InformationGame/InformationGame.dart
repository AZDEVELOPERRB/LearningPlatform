import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/UI/BottomClasses/InformationGame/singleLevel.dart';
import 'package:learningplatform_rb/providers/gamesProvider/informationGame/informationgameProvider.dart';
import 'package:provider/provider.dart';
class InformationGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      height:size.height ,
      width: size.width,
      decoration: UiConstans.Royabluebackground,
      child:Consumer(
        builder: (BuildContext context,InformationGameProvider provider,_){
       if(provider!=null){
         if(provider.isLoading||provider.questions==null){return const Center(child:const CircularProgressIndicator(),);}
         return  GridView.count(
           shrinkWrap: true,
           crossAxisCount: 3,
           childAspectRatio: (30 / 38),
           children:List.generate(provider.questions.length,(index) => SingleLevel(provider.questions[index],provider)),
         );
       }else{
         return Container();
       }
      },
      )
    );
  }
}

