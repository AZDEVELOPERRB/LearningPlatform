import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/DevelopingCertificate/developing_certificate.dart';
import 'package:learningplatform_rb/UI/About/background_of_app_info.dart';
import 'package:package_info_plus/package_info_plus.dart';
class AppInformation extends StatelessWidget {
 const AppInformation();
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          RoyalLiquidWidget(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children:[
              SizedBox(height:size.height/15,),
              SizedBox(height:size.height/5,child: Image.asset(Constans.logoPath),),

              SizedBox(height:size.height/6,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(Constans.AppDescription,textAlign:TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight:FontWeight.w800),)),
                ),
              ),
              Center(
                child: RaisedButton(
                  shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
                  color:Colors.blue,
                  child: Text('رجوع',style:const TextStyle(color: Colors.white),),
                  onPressed:()=>Navigator.pop(context),
                ),
              ),
           const   Center(child: RoyalBoardDevelopingCertificate()),
              const SizedBox(height:10,)

            ],
          ),

          Positioned(
              top: size.height/5.5,
              right:8,
              child: Column(children: [  FutureBuilder<PackageInfo>(
              future:getAppInfo(),
              builder:(BuildContext context,snap){
                if(snap.hasError)return SizedBox();
                PackageInfo appInfo=snap.data;
                return  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${appInfo?.version??""}',style:const TextStyle(color: Colors.blue),),
                    const   Text('اصدار التطبيق ',style:const TextStyle(color: Colors.black54),),

                  ],
                );
              }),
                const   Text(Constans.founder,style:const TextStyle(color: Colors.black54,fontWeight: FontWeight.w800),),
              ],))
        ],
      ),
    );
  }
  Future<PackageInfo> getAppInfo()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }
}
