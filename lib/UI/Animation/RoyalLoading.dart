import 'package:flutter/material.dart';

class RoyalLoading{
  BuildContext loader;
   loading(BuildContext context)async{
     final Size size= MediaQuery.of(context).size;
    loader=context;
    showDialog(barrierDismissible: false,
      context:loader,
      builder:(BuildContext context){
        return Align(
          child:Material(
            color:Colors.transparent,
            child: Container(
              height:size.height/3,
              width:size.width/1.5,
              margin:const EdgeInsets.symmetric(horizontal:10.0),
              padding:const EdgeInsets.all(5.0),
              decoration:const BoxDecoration(
                color:Colors.white,
                  borderRadius:BorderRadius.all(Radius.circular(20))
              ),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('Assets/images/logo.png',height: 70,),
                  SizedBox(height: 10,),
                  const Text('يرجى الانتظار..',textDirection:TextDirection.rtl,style: TextStyle(color:Colors.black54),),
                  SizedBox(height: 10,),
                  Expanded(child:Image.asset("Assets/images/fasting.gif"))
                ],),
            ),
          ),
        );
      },
    );
  }
  cancel(){
    Navigator.pop(loader);
  }
}