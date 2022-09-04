import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:learningplatform_rb/Constans/locals_constans.dart';
import 'package:learningplatform_rb/RoyalServices/AllProvidersServices/AllProvidersServices.dart';
import 'package:learningplatform_rb/RoyalServices/AppInitilaizer/app_init.dart';
import 'package:learningplatform_rb/UI/PrivacyAndPolicy/privacy_and_policy.dart';
import 'package:provider/provider.dart';
import 'UI/onBoarding/screens/landing_page.dart';

void main() async {
  await AppInit().init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final bool ss = await Seen().checkseen();
  runApp(MultiProvider(
    providers: AllProvidersServices.allproviders,
    child: FirstScreen(ss),
  ));
}

class FirstScreen extends StatelessWidget {
  final bool seen;

  FirstScreen(this.seen);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: seen ? PrivacyAndPolicy() : LandingPage());
  }
}










class Seen {
  final Box seen = Hive.box(Local_Constans.seen);

  setReadingForPrivacyAndPolicy()async{
   return await seen.put(Local_Constans.privacyAndPolicy,'read');
  }
  bool privacyAndPolicy(){
    final dynamic localPolicy=seen.get(Local_Constans.privacyAndPolicy);
    if(localPolicy!=null && localPolicy=='read')return true;
    return false;
  }

  checkseen() async {
    if (seen.values.isEmpty) {
      return false;
    }
    if (await seen.get(Local_Constans.seen_key) == "Auth") {
      return true;
    }
    return false;
  }
}
