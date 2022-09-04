import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
class RoyalBoardDevelopingCertificate extends StatelessWidget {
  const RoyalBoardDevelopingCertificate();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=>Constans.launchURL('http://www.roy-board.com',message:null),
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Image.asset('Assets/images/RoyalBoardLogo.png', height:45,width:125,),
          SizedBox(
            width:120,
            child: const Text('تم التطوير والبرمجة بواسطة شركة رويال بورد',
              textAlign:TextAlign.center,
              style:const TextStyle(fontSize: 10,color:Colors.black54),),
          ),

        ],
      ),
    );
  }
}
