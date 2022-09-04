import 'dart:ui';
import 'package:flutter/material.dart';
class RoyalLiquidWidget extends StatefulWidget {
  @override
  _RoyalLiquidWidgetState createState() => _RoyalLiquidWidgetState();
}
class _RoyalLiquidWidgetState extends State<RoyalLiquidWidget>with SingleTickerProviderStateMixin{
  AnimationController animationController;
  @override
  void initState() {
    animationController=AnimationController(vsync: this,duration: const Duration(seconds:2));
    super.initState();
    animateNow();
  }
  void animateNow()async{
    animationController.forward();
    // await Future.delayed(const Duration(milliseconds: 0)).then((value) => animationController.forward());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child:CustomPaint(
        painter:RoyalLiquidPainter(animation:animationController.view),
      ),
    );
  }
}
class RoyalLiquidPainter extends CustomPainter{
  RoyalLiquidPainter({Animation<double> animation}):
        blueAnimation=CurvedAnimation(parent: animation, curve: Curves.elasticInOut, reverseCurve: Curves.bounceOut),
        liquidAnimation=CurvedAnimation(parent: animation, curve: Curves.elasticInOut, reverseCurve: Curves.bounceOut),
        orangeAnimation=CurvedAnimation(parent: animation, curve: Curves.elasticInOut, reverseCurve: Curves.bounceOut),
        super(repaint: animation,);


  final bluePaint=Paint()..color=Colors.lightBlue..style=PaintingStyle.fill;
  final orangePaint=Paint()..color=Colors.black54..style=PaintingStyle.fill;
  final thirdPaint=Paint()..color=Colors.white..style=PaintingStyle.fill;


  final Animation<double> blueAnimation;
  final Animation<double> orangeAnimation;
  final  Animation<double> liquidAnimation;
  @override
  void paint(Canvas canvas,Size size){
    paintSecondPath(canvas, size);
    paintThirdPath(canvas, size);
    paintForthPath(canvas, size);
  }
  void paintForthPath(Canvas canvas,Size size){
    final Path path=Path();
    final double x=size.width;
    final double y=size.height;
    path.moveTo(0,0);
    path.lineTo(x,0);
    path.lineTo(x,y/11);
    _addPointsQuarder(path,
        [
          Point(x-80,0),
          Point(x/3,lerpDouble(y/3,y/3.1,orangeAnimation.value)),
          Point(0,lerpDouble(y/4,y/3.1,orangeAnimation.value))
        ]);
    canvas.drawPath(path,thirdPaint);
  }
  void paintThirdPath(Canvas canvas,Size size){
    final Path path=Path();
    final double x=size.width;
    final double y=size.height;
    path.moveTo(0,0);
    path.lineTo(x,0);
    path.lineTo(x,y/11);
    _addPointsQuarder(path,
        [
          Point(x-80,0),
          Point(x/3,lerpDouble(y/3,y/2.8,orangeAnimation.value)),
          Point(0,lerpDouble(y/4,y/2.8,orangeAnimation.value))
        ]);
    canvas.drawPath(path,bluePaint);
  }

  void paintSecondPath(Canvas canvas,Size size){
    final Path path=Path();
    final double x=size.width;
    final double y=size.height;
    path.moveTo(0,0);
    path.lineTo(x,0);
    path.lineTo(x,y/11);
    _addPointsQuarder(path,
        [
          Point(x-80,0),
          Point(x/3,y/2.3),
          Point(0,lerpDouble(y/4,y/2.35,orangeAnimation.value))
        ]);
    canvas.drawPath(path,orangePaint);
  }



  void _addPointsQuarder(Path path,List<Point> points){
    for(int i=0;i<points.length-2;i++){
      final double x=points[i].x;
      final double y=points[i].y;
      final double xc=(points[i].x+points[i+1].x)/2;
      final double yc=(points[i].y+points[i+1].y)/2;
      path.quadraticBezierTo(x,y,xc,yc);
    }
    path.quadraticBezierTo(
      points[points.length-2].x,
      points[points.length-2].y,
      points[points.length-1].x,
      points[points.length-1].y,
    );
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
class Point{
  double x;
  double y;
  Point(this.x, this.y);
}

