import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Students/Customer.dart';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';
import 'package:learningplatform_rb/providers/BestStudentsProvider/best_students_provider.dart';
class FirsterStudent extends StatefulWidget {
  const FirsterStudent();
  @override
  _FirsterStudentState createState() => _FirsterStudentState();
}

class _FirsterStudentState extends State<FirsterStudent> {
  final BestStudentsProvider provider=BestStudentsProvider();
  @override
  void initState() {
    provider.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(child:
       ValueListenableBuilder<List<User>>(
         valueListenable:provider.bests,
         child:const RoyalEmptyData(message: "لا يوجد طلبة متفوقين",),
         builder:(final BuildContext context,List<User> bests,_){
           if(bests==null)return const Center(child:CircularProgressIndicator());
           if(bests.isEmpty)return _;
           return  Stack(
             children: [
               Center(child: Image.asset('Assets/images/congratulations.gif')),
               if(bests.length>0)   Align(
                   alignment:const Alignment(0.0,-0.6),
                   child:SubWinnerUI(bests[0],"1",first:true,)
               ),
              if(bests.length>1) Align(
                   alignment:const Alignment(-0.9,0.3),
                   child:SubWinnerUI(bests[1],"2")),
               if(bests.length>2)  Align(
                   alignment:const Alignment(0.9,0.3),
                   child:SubWinnerUI(bests[2],"3")
                  ),
             ],
           );
         },
       )
    );
  }

  Future someSeconds()async{
    await Future.delayed(const Duration(seconds:4));
    return '';}
}
class SubWinnerUI extends StatelessWidget {
  const SubWinnerUI(this.user,this.number,{this.first=false});
  final User user;
  final bool first;
  final String number;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        RoyalDialog.showMessage(context,backMessage:"رجوع",
            child:Column(
              mainAxisAlignment:MainAxisAlignment.spaceAround,
              children:[
                RoyalCacheProfileImage(user.image?.url??null,height:100,),
                Text('الاسم :  ${user.name}',style:const TextStyle(color:Colors.brown,fontSize:16,fontWeight:FontWeight.bold),textAlign:TextAlign.center,),

                Text('المعدل  :  ${user.average.toStringAsFixed(2)}',style: TextStyle(color:Colors.orange.shade500,fontWeight:FontWeight.bold),
                    textAlign:TextAlign.center),

                RoyalRoundedButton(
                      "رجوع",
                      (){Navigator.pop(context);},
                      circular:20 )
              ],
            )
        );
      },
      child: Column(
        mainAxisSize:MainAxisSize.min,
        children: [
          if(first)StudentImageFrame(
            child: RoyalCacheProfileImage(
              user.image?.url??null,height:70,
            ),
          )
          else SecondStudentImageFrame(
            child:RoyalCacheProfileImage(
              user.image?.url??null,height:50,
            ),
          ),
          Row(
            mainAxisSize:MainAxisSize.min,
            children: [
              FittedBox(child: Text(user.name,style:const TextStyle(color:Colors.brown,fontSize:12),)),
              const SizedBox(width:8,),
               CirculeNumer(number:number,),
            ],
          ),
        ],
      ),
    );
  }
}

class CirculeNumer extends StatelessWidget {
  const   CirculeNumer({this.number});
  final String number;
  @override
  Widget build(BuildContext context) {
    return Container(
      height:20,
      width: 20,
      decoration: BoxDecoration(
          shape:BoxShape.circle,
          color:Colors.orange.shade200
      ),
      child:Center(child: Text(number??"1",style:const TextStyle(color:Colors.white),)),
    );
  }
}

class StudentImageFrame extends StatelessWidget {
  StudentImageFrame({this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration:const BoxDecoration(
        image:DecorationImage(
          image:AssetImage('Assets/images/fsutow.png'),fit:BoxFit.fill
        ) ,
      ),
      alignment:const Alignment(0.0,0.0),
      child:child??Container(
        height: 70,
        decoration:const BoxDecoration(
            shape:BoxShape.circle,
            image:DecorationImage(
                image:AssetImage('Assets/images/logo.png'),fit:BoxFit.cover
            )
        ),
      ),
    );
  }
}
class SecondStudentImageFrame extends StatelessWidget {
  SecondStudentImageFrame({this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration:const BoxDecoration(
        image:DecorationImage(
            image:AssetImage('Assets/images/fsu.png')
        ) ,
      ),
      alignment:const Alignment(0.0,0.0),
      child:child??Container(
        height: 50,
        decoration:const BoxDecoration(
          shape:BoxShape.circle,
          image:DecorationImage(
            image:AssetImage('Assets/images/logo.png'),fit:BoxFit.cover
          )
        ),
      ),
    );
  }
}