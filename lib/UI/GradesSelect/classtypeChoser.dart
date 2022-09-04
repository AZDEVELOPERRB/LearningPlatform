import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/gradesModels/ClassType.dart';
import 'package:learningplatform_rb/providers/gradesProvider/gradeProvider.dart';
class ClassTypeChoser extends StatefulWidget {
 final GradeProvider provider;

 const ClassTypeChoser(this.provider);

  @override
  _ClassTypeChoserState createState() => _ClassTypeChoserState();
}

class _ClassTypeChoserState extends State<ClassTypeChoser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.parse('${widget.provider.chosedSchool.grade_childs.length}')*25,
      child: GridView.count(
        crossAxisCount: 3,
          childAspectRatio: (90 / 45),

          // Generate 100 widgets that display their index in the List.
        children: List.generate(widget.provider.chosedSchool.grade_childs.length, (index) {
          ClassType classType=widget.provider.chosedSchool.grade_childs[index];
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                widget.provider.choseClass(classType);
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color:widget.provider.chosedclass!=null?widget.provider.chosedclass.id==classType.id?UiConstans.ChosenWidgetColor:UiConstans.BackgroundWidgetColor:UiConstans.BackgroundWidgetColor
                  ),
                  child: Center(child: Text(classType.name,style: UiConstans.whiteText,))),
            ),
          );
        })
      ),
    )
    ;
  }
}
