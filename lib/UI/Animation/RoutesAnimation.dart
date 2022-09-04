import 'package:flutter/material.dart';
class RoyalNavigatorElasticInOut extends PageRouteBuilder{
 final Widget widget;
 RoyalNavigatorElasticInOut(this.widget):super(
      transitionDuration:const Duration(milliseconds: 300),
      transitionsBuilder: ( BuildContext context,Animation<double> animation,Animation<double> second,Widget child){

        animation=CurvedAnimation(parent: animation,curve: Curves.easeInToLinear);
        return ScaleTransition(
            alignment: Alignment.center,
            child: child,
            scale: animation);
      },
      pageBuilder:
          ( BuildContext context,Animation<double> animation,Animation<double> second){
        return widget;

      }
  );
}