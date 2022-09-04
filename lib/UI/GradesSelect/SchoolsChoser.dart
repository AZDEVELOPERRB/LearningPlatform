import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/Models/gradesModels/schoolType.dart';
import 'package:learningplatform_rb/providers/gradesProvider/gradeProvider.dart';
class SchoolsTypeChoser extends StatefulWidget {
  SchoolsTypeChoser(this.schoolType,{this.provider});
 List<SchoolType> schoolType;
 GradeProvider provider;
  @override
  _SchoolsTypeChoserState createState() => _SchoolsTypeChoserState();
}

class _SchoolsTypeChoserState extends State<SchoolsTypeChoser> {
  int choosen;

  chose(int ch){
    setState(() {
      choosen=ch;
      widget.provider.chose(widget.schoolType[ch]);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i=0;i<widget.schoolType.length;i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  chose(i);
                },
                child: Container(
                  height: 60,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color:choosen==null?UiConstans.BackgroundWidgetColor:choosen==i?UiConstans.ChosenWidgetColor:UiConstans.BackgroundWidgetColor
                    ),
                    child: Center(child: Text(widget.schoolType[i].name,style: UiConstans.whiteText,))),
              ),
            )
        ],
      ),
    );
  }
}
