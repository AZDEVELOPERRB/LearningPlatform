import 'package:flutter/material.dart';
import 'package:learningplatform_rb/providers/gamesProvider/informationGame/informationgameProvider.dart';
import 'package:learningplatform_rb/providers/userProvider/userProvider.dart';
import 'package:provider/provider.dart';
class RoyalNotifier extends StatelessWidget {
  final  child;
  RoyalNotifier({this.child});
  final UserProvider userProvider=UserProvider();
  final InformationGameProvider _informationGameProvider=InformationGameProvider();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_){userProvider.getUser();userProvider.refresh();userProvider.context=context;return userProvider;},
      child:ChangeNotifierProvider<InformationGameProvider>(create: (_){_informationGameProvider.initial();return _informationGameProvider;},child:child,));

  }
}
