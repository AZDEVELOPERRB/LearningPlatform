import 'package:flutter/material.dart';
import 'package:learningplatform_rb/Models/GPS/Countries.dart';
import 'package:learningplatform_rb/database/base_local.dart';
// ignore: must_be_immutable
class CountriesUI extends StatefulWidget {
   String cid='';
   String subid='';
  @override
  _CountriesUIState createState() => _CountriesUIState();
}

class _CountriesUIState extends State<CountriesUI> {
List<Countries> _countries=[];
String cid;
int catindex;
String subid;
@override
@mustCallSuper
  void initState() {

  lan();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _countries==null?Container():
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 55,
            decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(15)),

            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: DropdownButtonFormField<String>(

                hint: Text("اختر بلدك"),


                items: _countries.map((value) {
                  return DropdownMenuItem<String>(
                    value: value.id,
                    child: Text(value.name),
                  );
                }).toList(),
                onChanged: (v) {

                  setState(() {
                    widget.cid=v;
                    cid=v;});

                  },
              ),
            ),
          ),
        ),
       cid==null?Container(): Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 55,
            decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(15)),

            child: Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8),
              child: DropdownButtonFormField<String>(

                hint: Text("اختر محافظتك"),


                items: _countries.firstWhere((element) {

                return element.id==cid?true:false;
                }).CS.map((value) {
                  return DropdownMenuItem<String>(
                    value: value.id,
                    child: Text(value.name),
                  );
                }).toList(),
                onChanged: (v) {

                  setState(() {
                    subid=v;
                    widget.subid=v;
                  });

                },
              ),
            ),
          ),
        ),
      ],
    )
    ;
  }


  lan()async{
  var d=await BaseLocal().bringCountries();
  setState(() {
    _countries=d;
  });
  }
}
