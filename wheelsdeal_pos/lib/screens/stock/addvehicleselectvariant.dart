//@dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wheelsdeal_pos/models/VehicleVariant.dart';
import 'package:wheelsdeal_pos/utils.dart';
import 'package:http/http.dart' as http;

class AddVehicleSelectVariant extends StatefulWidget {
  const AddVehicleSelectVariant({ Key key }) : super(key: key);

  @override
  State<AddVehicleSelectVariant> createState() => _AddVehicleSelectVariantState();
}

class _AddVehicleSelectVariantState extends State<AddVehicleSelectVariant> {
  Future fetchvariant;
  var argumentsdata = Get.arguments;

  Future variant(int modelid)async{
    try{
      Utils util = Utils();
      String baseurl = util.baseurl;
      String url = "${baseurl}/vehiclevariant/${modelid}";
      var response = await http.get(Uri.parse(url));
      var jsonresponse = jsonDecode(response.body);
      // print (jsonresponse);
      var status = jsonresponse[0]['status'];
      if(status == true){
        var data = jsonresponse[0]['data'];
        return data.map((json)=>VehicleVariant.fromJson(json)).toList();
      }

    }on SocketException{
       Get.defaultDialog(
        title: "Something Went Wrong!",
        radius: 20.0,
        middleText: "Socket Exception",
        onConfirm: ()=>Get.back()
      );

    }on HttpException{
       Get.defaultDialog(
        title: "Something Went Wrong!",
        radius: 20.0,
        middleText: "Http Exception",
        onConfirm: ()=>Get.back()
      );

    }on FormatException{
       Get.defaultDialog(
        title: "Something Went Wrong!",
        radius: 20.0,
        middleText: "Format Exception",
        onConfirm: ()=>Get.back()
      );

    }catch(err){
       Get.defaultDialog(
        title: "Something Went Wrong!",
        radius: 20.0,
        middleText: "Error : ${err}",
        onConfirm: ()=>Get.back()
      );

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchvariant = variant(argumentsdata[0]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
      future: fetchvariant,
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
                      
                      },
                      dense:true,
                      title: Text(snapshot.data[index].variantname,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
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