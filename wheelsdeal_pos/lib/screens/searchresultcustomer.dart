// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wheelsdeal_pos/screens/addcustomer/selectstate.dart';
import 'package:wheelsdeal_pos/utils.dart';
import 'package:http/http.dart' as http;

class SearchCustomerResult extends StatefulWidget {
  const SearchCustomerResult({ Key key }) : super(key: key);

  @override
  State<SearchCustomerResult> createState() => _SearchCustomerResultState();
}

class _SearchCustomerResultState extends State<SearchCustomerResult> {
  bool  _pivisible = false;
  bool cstatus;
  dynamic argumentdata = Get.arguments;
  List customer;
  Widget trueresult(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(customer[0] == null ? "" : customer[0],style: TextStyle(color: Colors.green,fontSize: 22),),
        SizedBox(height: 10,),
        Text(customer[1] == null ? "" : customer[1],style: TextStyle(color: Colors.green,fontSize: 18)),
        SizedBox(height: 10,),
        Text(customer[2] == null ? "" : customer[2],style: TextStyle(color: Colors.green,fontSize: 14)),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(onPressed: (){
                
            }, 
            child: Text("Continue")),
          ),
        )
      ],
    );
  }

  Widget falseresult(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No Record Found"),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){
              
               
               Timer(Duration(milliseconds: 1000),(){
                   Get.off(AddCustomerSelectState());
               });
               
               
              },
              child: Text("Add Customer"),
            ),
          ),
        )
      ],
    );
  }
  
  Future getCustomerinfo(String mobileno)async{
    setState(() {
      _pivisible = true;
    });
    try{
      Utils util = Utils();
    final String urlbase = util.baseurl;
    final String url = "${urlbase}/customer/${mobileno}";
    var response = await http.get(Uri.parse(url));
        if(response.statusCode == 200){
            var jsonresponse = jsonDecode(response.body);
        var status = jsonresponse[0]['status'];
        if(status == false){
          setState(() {
            _pivisible = false;
            cstatus = false;
          });
        }else{
          var customerid = jsonresponse[0]['data'][0]['customer_id'];
          var customername = jsonresponse[0]['data'][0]['customer_name'];
          var customermobile = jsonresponse[0]['data'][0]['customer_mobile'];
          var customeraddress = jsonresponse[0]['data'][0]['customer_address'];
          List customerDetail = [customername,customermobile,customeraddress,customerid];
           
          setState(() {
            _pivisible = false;
            cstatus = true;
            customer = customerDetail;
          });
        
        }
    }else{
      //  Get.snackbar(
      //         "Something went wrong",
      //          "Hello everyone",
               
      //          snackPosition: SnackPosition.BOTTOM,
                 
      //          );
      //          Timer(Duration(microseconds: 5000), (){
      //             SystemNavigator.pop();
      //          });

      Get.defaultDialog(
        title: "Something Went Wrong!!",
        radius: 20.0,
        onConfirm: () {
          SystemNavigator.pop();
        },
      );
    }
    }on SocketException{
       Get.defaultDialog(
        title: "Something Went Wrong !!! Try again after sometime.",
        middleText: "Socket Exception",
        radius: 20.0,
        onConfirm: () => SystemNavigator.pop(),
      );

    }on HttpException{
       Get.defaultDialog(
        title: "Something Went Wrong !!! Try again after sometime.",
        middleText: "Http Exception",
        radius: 20.0,
        onConfirm: () => SystemNavigator.pop(),
      );

    }on FormatException{
       Get.defaultDialog(
        title: "Something Went Wrong !!! Try again after sometime.",
        middleText: "Format Exception",
        radius: 20.0,
        onConfirm: () => SystemNavigator.pop(),
      );
    }
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var customer = argumentdata[0]['customermobile'];
    getCustomerinfo(customer);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(),
     body: Stack(children: [
       Center(child: cstatus == true ? trueresult() : falseresult()),
       Visibility(
         visible: _pivisible,
         child: Center(child: CircularProgressIndicator(),))
     ],), 
    );
  }
}