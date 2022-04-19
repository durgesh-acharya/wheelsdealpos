//@dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wheelsdeal_pos/models/Customer.dart';
import 'package:wheelsdeal_pos/screens/gatepass/gatepassaddvehicle.dart';
import 'package:wheelsdeal_pos/utils.dart';
import 'package:http/http.dart' as http;

class GatePassAddCustomer extends StatefulWidget {
  const GatePassAddCustomer({ Key key }) : super(key: key);

  @override
  State<GatePassAddCustomer> createState() => _GatePassAddCustomerState();
}

class _GatePassAddCustomerState extends State<GatePassAddCustomer> {
  Future fetchCust;
  var argumentsdata = Get.arguments;
  bool _pindicator = false;

  Future fetchCustomer(int outletid)async{
      try{
        Utils util = Utils();
      String url = util.baseurl;
      var response = await http.get(Uri.parse("${url}/customer/byoutletid/${outletid}"));
      var jsonresponse = jsonDecode(response.body);
      var status = jsonresponse[0]['status'];
      if(status == true){
        var responsedata = jsonresponse[0]['data'];
        print(responsedata);
        return responsedata.map((json) => Customer.fromJson(json)).toList();
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
        middleText: "HTTP Exception",
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
      }catch(error){
    Get.defaultDialog(
        title: "Something Went Wrong !!! Try again after sometime.",
        middleText: error.toString(),
        radius: 20.0,
        onConfirm: () => SystemNavigator.pop(),
      );
  }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCust = fetchCustomer(argumentsdata[1]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          FutureBuilder(future: fetchCust,
      builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length == 0 ? 0 : snapshot.data.length,
              itemBuilder: (BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.only(top :8.0),
                  child: GFListTile(
                    onTap: (){
                      Get.to(GatePassAddVehicle(),arguments: [argumentsdata[0],argumentsdata[1],snapshot.data[index].customerId]);
                    },
  color: Colors.green,
  title: Padding(
    padding: const EdgeInsets.only(top :8.0),
    child: Text(snapshot.data[index].customerName.toString(),style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
  ),
  subTitle: Padding(
    padding: const EdgeInsets.only(top :8.0,bottom: 8.0),
    child: Text(snapshot.data[index].customerMobile.toString(),style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
  ) ,
  
),
                );

              });
          }else{
            return Center(
              child: GFLoader(
                type: GFLoaderType.circle,
              ),
            );
          }
      },
      ),
      Visibility(
        visible: _pindicator,
        child: Center(
              child: GFLoader(
                type: GFLoaderType.circle,
              ),
            ))
        ],
      )
    );
  }
}