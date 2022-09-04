import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';

class RoyalDialog{
 static publicDialog(BuildContext context,Widget child,{final double height})async{
    showDialog(
      context: context,
      builder: (context) {
        final Size size=MediaQuery.of(context).size;
        return Scaffold(
          backgroundColor:Colors.transparent,
          body: Align(
            child: Container(
              width: size.width,
                margin:const EdgeInsets.symmetric(horizontal:10.0,vertical: 20.0),
                padding:const EdgeInsets.all(10.0),
                decoration:const BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.all(Radius.circular(15))
                ),
                child:child
            ),
          ),
        );
      },
    );
  }

  static showMessage(BuildContext context,{
    final double height,
    final double width,
    final Widget child,
    final VoidCallback onAgree,
    final String backMessage,
    final String agreeMessage="نعم",
    final String message}){
    showDialog(context:context,
        builder:(BuildContext context){
      final Size size=MediaQuery.of(context).size;
          return Align(
            child: Container(
              height:height??size.height/2,
              width:width??size.width,
              margin:const EdgeInsets.all(5.0),
              decoration:const BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color:Colors.black12,
                        blurRadius: 9.0
                    )
                  ]
              ),
              child: Material(
                color:Colors.transparent,
                child:Column(
                  children: [
                    Container(
                      height:10,
                      width:size.width,
                   decoration:const BoxDecoration(
                     color:Colors.red,
                     borderRadius:BorderRadius.vertical(top:Radius.circular(15))
                   ),
                    ),
                    Expanded(
                      child:child??Column(
                        mainAxisAlignment:MainAxisAlignment.spaceAround,
                        children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:2.0),
                              child: Center(child:  Text(message??"هل تريد حقاً فعل ذلك ؟",style:const TextStyle(fontSize:18,fontWeight:FontWeight.bold),textAlign:TextAlign.center,)),
                            ),
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceAround,
                            children: [
                              RoyalRoundedButton(backMessage??"لا",(){Navigator.pop(context);},circular:20,),
                             if(onAgree!=null)RoyalRoundedButton(agreeMessage,onAgree??(){},circular:20,),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}