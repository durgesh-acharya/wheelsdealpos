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
  bool  _centervisiblity = false;
  dynamic argumentdata = Get.arguments;
  List customer;


  Widget trueresult(){
    return Container(
      height: 300,
      child : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Row(
                children: [
                  Text("Name :",style: TextStyle(color: Colors.green,fontSize: 16)),
                  SizedBox(width: 5.0,),
                  Text(customer[0] == null ? "" : customer[0],style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold))
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left :8.0),
              child: Row(
                children: [
                  Text("Mobile No. :",style: TextStyle(color: Colors.green,fontSize: 16)),
                  SizedBox(width: 5.0,),
                  Text(customer[1] == null ? "" : customer[1],style: TextStyle(color: Colors.green,fontSize: 14,fontWeight: FontWeight.bold))
                ],
              ),
            ),
   
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left :8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address :",style: TextStyle(color: Colors.green,fontSize: 16)),
                  Text(customer[2] == null ? "" : customer[2],style: TextStyle(color: Colors.green,fontSize: 14,fontWeight: FontWeight.bold))

                ],
              ),
            ),
            
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(onPressed: (){
                    
                }, 
                child: Text("Select and Make Gate Pass")),
              ),
            ),
             Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            child: TextButton(
              onPressed: () => print("hey"),
              child: Text("History",style: TextStyle(fontSize: 14),),)
          ),
        )
          ],
         ) ),
      ),
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
                   Get.off(AddCustomerSelectState(),arguments:[argumentdata[1],argumentdata[2],argumentdata[0]]);
               });
               
               
              },
              child: Text("Add Customer"),
            ),
          ),
        ),
        
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
            var jsonresponse = jsonDecode(response.body);
        var status = jsonresponse[0]['status'];
        if(status == false){
          setState(() {
            _pivisible = false;
            cstatus = false;
            _centervisiblity = true;
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
            _centervisiblity = true;
          });
        
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
    }on http.ClientException{
      Get.defaultDialog(
        title: "Something Went Wrong !!! Try again after sometime.",
        middleText: "Client Exception",
        radius: 20.0,
        onConfirm: () => SystemNavigator.pop(),
      );
    }
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var customer = argumentdata[0]['customermobile'];
    
    getCustomerinfo(argumentdata[0]);
    // print(argumentdata[1]);
    // print(argumentdata[2]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(),
     body: Stack(children: [
       Visibility(
         visible: _centervisiblity,
         child: Center(child: cstatus == true ? trueresult() : falseresult())),
       Visibility(
         visible: _pivisible,
         child: Center(child: CircularProgressIndicator(),))
     ],), 
    );
  }
}

