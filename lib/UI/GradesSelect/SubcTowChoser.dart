import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/gradesModels/SubcTow.dart';
import 'package:learningplatform_rb/providers/gradesProvider/gradeProvider.dart';
class SubcTowChoser extends StatefulWidget {
 final GradeProvider provider;

 const SubcTowChoser(this.provider);

  @override
  _SubcTowChoserState createState() => _SubcTowChoserState();
}

class _SubcTowChoserState extends State<SubcTowChoser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: GridView.count(

        crossAxisCount: 3,
          childAspectRatio: (90 / 45),
        // Generate 100 widgets that displady their index in the List.
        children: List.generate(widget.provider.chosedsubcone.grade_childs.length, (index) {
          SubcTow subcTow=widget.provider.chosedsubcone.grade_childs[index];
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                widget.provider.choseSubcTow(subcTow);
              },
              child: Container(
                  height: 40,
                  width: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color:widget.provider.chosedsubctow!=null?widget.provider.chosedsubctow.id==subcTow.id?UiConstans.ChosenWidgetColor:UiConstans.BackgroundWidgetColor:UiConstans.BackgroundWidgetColor
                  ),
                  child: Center(child: Text(subcTow.name,style: UiConstans.whiteText))),

            ),
          );
        })
      ),
    )
    ;
  }
}
