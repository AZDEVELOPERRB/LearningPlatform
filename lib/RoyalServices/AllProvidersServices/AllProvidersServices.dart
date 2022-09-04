import 'package:learningplatform_rb/providers/gamesProvider/informationGame/informationgameProvider.dart';
import 'package:learningplatform_rb/providers/gradesProvider/gradeProvider.dart';
import 'package:learningplatform_rb/providers/userProvider/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AllProvidersServices{
 static List<Provider> allproviders=[
    Provider<UserProvider>(create: (BuildContext context){UserProvider _user=UserProvider();return _user;},),
    Provider<GradeProvider>(create: (BuildContext context){GradeProvider _gradeprovider=GradeProvider();return _gradeprovider;},),
 Provider<InformationGameProvider>(create: (BuildContext context){InformationGameProvider _informationgameprovider=InformationGameProvider();return _informationgameprovider;})
 ];
}