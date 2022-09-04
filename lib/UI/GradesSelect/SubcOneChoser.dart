import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/gradesModels/ClassType.dart';
import 'package:learningplatform_rb/Models/gradesModels/SubcOne.dart';
import 'package:learningplatform_rb/providers/gradesProvider/gradeProvider.dart';
class SubcOneChoser extends StatefulWidget {
 final GradeProvider provider;

 const SubcOneChoser(this.provider);

  @override
  _SubcOneChoserState createState() => _SubcOneChoserState();
}

class _SubcOneChoserState extends State<SubcOneChoser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: GridView.count(
        crossAxisCount: 3,
          childAspectRatio: (90 / 45),
        children: List.generate(widget.provider.chosedclass.grade_childs.length, (index) {
          SubcOne subcone=widget.provider.chosedclass.grade_childs[index];
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                widget.provider.choseSubcOne(subcone);
              },
              child: Container(
                  height: 60,
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color:widget.provider.chosedsubcone!=null?widget.provider.chosedsubcone.id==subcone.id?UiConstans.ChosenWidgetColor:UiConstans.BackgroundWidgetColor:UiConstans.BackgroundWidgetColor
                  ),
                  child: Center(child: Text(subcone.name,style: UiConstans.whiteText,))),
            ),
          );
        })
      ),
    )
    ;
  }
}
