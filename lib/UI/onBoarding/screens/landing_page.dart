import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningplatform_rb/UI/onBoarding/constants/constants.dart';
import 'package:learningplatform_rb/UI/onBoarding/ui_view/slider_layout_view.dart';
import 'package:learningplatform_rb/UI/onBoarding/widgets/custom_font.dart';
class LandingPage extends StatefulWidget {
  const LandingPage();
  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: onBordingBody(),
    );
  }

  Widget onBordingBody() => Container(
        child: SliderLayoutView(),
      );
}
