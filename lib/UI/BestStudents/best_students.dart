import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/Students/Customer.dart';
import 'package:learningplatform_rb/providers/BestStudentsProvider/best_students_provider.dart';
class BestStudents extends StatefulWidget {
  const BestStudents();
  @override
  _BestStudentsState createState() => _BestStudentsState();
}
class _BestStudentsState extends State<BestStudents> {
  final BestStudentsProvider provider=BestStudentsProvider();
  @override
  void initState() {
    provider.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Directionality(
      textDirection:TextDirection.rtl,
      child: Scaffold(
        appBar:UiConstans.appBar(size:size,title:const Text('افضل طلبة المرحلة')),
        body:ValueListenableBuilder<List<User>>(
          valueListenable:provider.bests,
          child:const RoyalEmptyData(message:"لا يوجد طلبة متفوقين",),
          builder:(final BuildContext context,List<User> users,final Widget _){
            if(users==null)return const Center(child: CircularProgressIndicator());
           if(users.isEmpty) return _;
            return ListView.builder(
              itemCount:users.length,
              itemBuilder:(final BuildContext context,final int index){
                return Student(
                    users[index],index+1,
                    key:UniqueKey(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class Student extends StatelessWidget {
  const Student(this.user,this.index,{Key key}):super(key:key);
  final int index;
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(8.0),
      margin:const EdgeInsets.all(4.0),
      decoration:const BoxDecoration(
          color:Colors.white,
          borderRadius:BorderRadius.all(Radius.circular(15)),
          boxShadow:[
            BoxShadow(
                color:Colors.black26,
                spreadRadius: 1.0,
                blurRadius:9.0
            )
          ]
      ),
      child:Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children:[
          Column(
            children: [
              Row(
                children: [
                  RoyalCacheProfileImage(user.image?.url??null,height:70,),
                  const SizedBox(width:10,),
                  Column(
                    children: [
                      Text(user.name,
                        style:const TextStyle(fontSize:15,color:Colors.black87,fontWeight:FontWeight.bold),),
                      Text('تسلسل الطالب  $index',
                        style:const TextStyle(fontSize:11,color:Colors.black54,fontWeight:FontWeight.bold),)
                    ],
                  )
                ],
              ),

            ],
          ),
          Text(' المعدل : ${double.parse((user.average??0).toStringAsFixed(2))}',style:const TextStyle(color:Colors.brown,
              fontWeight:FontWeight.w900),)
        ],
      ),
    );
  }
}
