import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/response/RS.dart';
import 'package:learningplatform_rb/UI/GradesSelect/SubcOneChoser.dart';
import 'package:learningplatform_rb/UI/GradesSelect/SubcTowChoser.dart';
import 'package:learningplatform_rb/UI/GradesSelect/classtypeChoser.dart';
import 'package:learningplatform_rb/providers/gradesProvider/gradeProvider.dart';
import 'package:learningplatform_rb/providers/userProvider/userProvider.dart';
import 'package:provider/provider.dart';
class SelectGrades extends StatefulWidget {
  SelectGrades({this.userProvider});
final  UserProvider userProvider;
  @override
  _SelectGradesState createState() => _SelectGradesState();
}
class _SelectGradesState extends State<SelectGrades> {
  @override
  void initState() {

    super.initState();
  }
GradeProvider gradeProvider=GradeProvider();
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('اختر صفك الدراسي'),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assets/images/profile.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: ChangeNotifierProvider<GradeProvider>(create:(BuildContext context){
          GradeProvider _gradeProvider=GradeProvider();
          _gradeProvider.getAllGrades();
          gradeProvider=_gradeProvider;
          return gradeProvider;
        } ,
          child: Consumer<GradeProvider>(
            builder: (BuildContext context,GradeProvider provider,Widget child){
              if(provider!=null)
             {
               return Stack(
                 children: [
               provider.hiddenschoolsType.length!=0?ListView(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Center(child: Container(
                       width:widget.userProvider!=null?200: 180,
                       height: 40,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                           color: Colors.deepPurpleAccent
                       ),
                       child: Center(child: Text('يرجى اختيار صفك الدراسي ${widget.userProvider!=null?"الجديد":""}',style: UiConstans.whiteText,)),
                     ),),
                   ),
                   provider.schoolchoser,
                   provider.chosedSchool!=null?ClassTypeChoser(provider):Container(),
                   provider.chosedclass!=null?SubcOneChoser(provider):Container(),
                   provider.chosedsubcone!=null?SubcTowChoser(provider):Container(),
                   provider.postServerGrade!=null?provider.loading?
                       Container(
                         height: 50,
                       child: Image.asset('Assets/images/fasting.gif'),
                       )
                       :  Center(child:RaisedButton(
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                     color: Colors.lightBlue,
                     child: Text('تحديد الصف الدراسي',style: UiConstans.whiteText,),
                     onPressed: ()async{
                       if(provider.loading){
                         Constans.toast("يجب أنتظار التحميل من الانترنت", false);
                         return;
                       }
                       if(provider.postServerGrade!=null){
                      final RS rs= await  provider.post();
                         if((rs?.check()==true)!=null){
                           widget.userProvider.refresh();
                           Navigator.pop(context);
                         }
                       }else{
                         Constans.toast("يجب اختيار مرحلة دراسية صحيحة", false);
                       }
                     },
                   ),):Container(),






                 ],
               ):Container(),
                   provider.loading?
                   LinearProgressIndicator():Container()
                 ],
               );


             }
              else{
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

