//@dart=2.9


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class GatePassDateRemarks extends StatefulWidget {
  const GatePassDateRemarks({ Key key }) : super(key: key);

  @override
  State<GatePassDateRemarks> createState() => _GatePassDateRemarksState();
}

class _GatePassDateRemarksState extends State<GatePassDateRemarks> {
  var argumentdata = Get.arguments;
  DateTime selectedDate;
  String afterformat;
  
 
 String formatDate(DateTime dt){
  var now = dt;
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    print(formattedTime);
    print(formattedDate);
    // setState(() {
    //   formattedDate = afterformat;
    // });
    // print(afterformat);
    return formattedDate;
 }
 
 Future selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2222));
    if (picked != null) {
      setState(() => selectedDate = picked);  
      print(picked);
      print(selectedDate.toString());
    }  
    else{
      print(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(),
     body:Column(
       mainAxisAlignment:MainAxisAlignment.center,
       children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
             width: double.infinity,
             child: ElevatedButton(onPressed: ()async{
               selectDate(context).whenComplete(() => afterformat = formatDate(selectedDate) );
             }, child: Text("Show Date")),
           ),
         ),
         Card(
           child: Text(afterformat == null ? " " : afterformat),
         ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
               width: double.infinity,
             child: ElevatedButton(onPressed: (){}, child: Text("Generate Gate Pass")),
           ),
         )
       ],
     )
    );
  }
}