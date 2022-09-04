import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/UIConstans.dart';
import 'package:learningplatform_rb/UI/RoyalDialogs/RoyalPublicDialog.dart';
class CardItem extends StatelessWidget {
  const CardItem(this.icon,this.color,this.main,this.second,this.input,this.function,{Key key,this.height,this.sfunction}):super(key: key);
final icon;
final color;
final String main;
final String second;
final Widget input;
final Function function;
final double height;
final Function sfunction;
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 21.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(onPressed: () {}, icon: Icon(icon,size: 40,color: color,)),

                  SizedBox(width: 24.0),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Text(
                        second,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: color
                        ),
                      ),
                      SizedBox(height: 4.0),
                      SizedBox(
                        width:size.width/2.2,
                        child: Text(
                          main,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(icon:Icon( Icons.edit),onPressed:sfunction??()async {
              RoyalDialog.publicDialog(context,
              Container(
               height: height??220,
                width: 140,
                child: Column(
                  children: [
                    Container(
                      height:60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('Assets/images/logo.png'),
                        )
                      ),
                    ),
                    SizedBox(height: 15,),
                    input,
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            color: Colors.blue,
                            child: Text('تحديث',style: UiConstans.whiteText,),
                            onPressed:()async{Navigator.pop(context);function();}
                            ),

                        RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            color: Colors.red,
                            child: Text('الغاء',style: UiConstans.whiteText,),
                            onPressed:(){Navigator.pop(context);}
                        ),
                      ],
                    )
                  ],
                ),
              )
              );
              }
            ),
          ],
        ),
      ),
    );
  }

}