//@dart = 2.9
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wheelsdeal_pos/models/VehicleModel.dart';
import 'package:wheelsdeal_pos/screens/stock/addvehicleselectvariant.dart';
import 'package:wheelsdeal_pos/utils.dart';
import 'package:http/http.dart' as http;

class AddCustomerSelectModel extends StatefulWidget {
  const AddCustomerSelectModel({ Key key }) : super(key: key);

  @override
  State<AddCustomerSelectModel> createState() => _AddCustomerSelectModelState();
}

class _AddCustomerSelectModelState extends State<AddCustomerSelectModel> {

  Future fetchmodel;
  var argumentsdata = Get.arguments;
  
  Future model(int brandid)async{
    try{
      Utils util = Utils();
      String burl = util.baseurl;
      String url = "${burl}/vehiclemodel/${brandid}";
      var response = await http.get(Uri.parse(url));
      var jsondata = jsonDecode(response.body);
      print(jsondata);
      var status = jsondata[0]['status'];
      if(status == true){
        var data = jsondata[0]['data'];
        return data.map((json) => VehicleModel.fromJson(json)).toList();
        
      }
    } on SocketException{
       Get.defaultDialog(
        title: "Something Went Wrong!",
        radius: 20.0,
        middleText: "Socket Exception",
        onConfirm: ()=>Get.back()
      );

    }on FormatException{
       Get.defaultDialog(
        title: "Something Went Wrong!",
        radius: 20.0,
        middleText: "Format Exception",
        onConfirm: ()=>Get.back()
      );

    }on HttpException{
       Get.defaultDialog(
        title: "Something Went Wrong!",
        radius: 20.0,
        middleText: "Http Exception",
        onConfirm: ()=>Get.back()
      );

    }catch(err){
       Get.defaultDialog(
        title: "Something Went Wrong!",
        radius: 20.0,
        middleText: "Error code ${err}",
        onConfirm: ()=>Get.back()
      );
      
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchmodel = model(argumentsdata[0]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  FutureBuilder(
      future: fetchmodel,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(
        child: GFLoader(
   type:GFLoaderType.circle
 ),
      );
        }else{
          return ListView.builder(
            itemCount: snapshot.data.length == 0 ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: const EdgeInsets.only(top:14.0),
                  child: Container(
                    color: Colors.green,
                    child: ListTile(
                      onTap: ()=>{
                      Get.off(AddVehicleSelectVariant(),arguments: [snapshot.data[index].modelid])
                      },
                      dense:true,
                      title: Text(snapshot.data[index].modelname,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                  ),
                );
            });
        }
      },
    ),
    );
  }
}