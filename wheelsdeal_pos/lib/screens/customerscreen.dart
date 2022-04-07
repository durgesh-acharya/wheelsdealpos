import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wheelsdeal_pos/screens/searchresultcustomer.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({ Key? key }) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState(); 
}

class _CustomerScreenState extends State<CustomerScreen> {
  bool pivisible = false;

  var argumentdata = Get.arguments;

  TextEditingController _customermobile = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(argumentdata[0]);
    print(argumentdata[1]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Stack(children: [
         Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                      controller: _customermobile,
                      keyboardType: TextInputType.number,
                       inputFormatters: [
            LengthLimitingTextInputFormatter(10),
          ],
                      decoration: InputDecoration(
                        labelText: 'Enter 10 Digit Mobile Number',
                        suffixIcon: Icon(FontAwesomeIcons.mobile,size: 17,)
                      ),
                    ),
            )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
      
            child: ElevatedButton(onPressed: (){
             if(_customermobile.text.length == 10){
                setState(() {
                pivisible = true;
              });
              Timer(Duration(microseconds: 1000), (){
                 Get.off(SearchCustomerResult(),arguments: [_customermobile.text,argumentdata[0],argumentdata[1]]);
              });
             }
               
            }, child: Text("Search",style: TextStyle(color: Colors.white),)),
          ),
        )
      ],
    ),
         Visibility(
           visible: pivisible,
           child: Center(child: CircularProgressIndicator()))
      ],)
    );
  }
}

