//@dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:wheelsdeal_pos/models/VehicleBrand.dart';
import 'package:wheelsdeal_pos/screens/stock/addvehicleselectmodel.dart';
import 'package:wheelsdeal_pos/utils.dart';

class AddVehicleSelectBrand extends StatefulWidget {
  const AddVehicleSelectBrand({ Key key }) : super(key: key);

  @override
  State<AddVehicleSelectBrand> createState() => _AddVehicleSelectBrandState();
}

class _AddVehicleSelectBrandState extends State<AddVehicleSelectBrand> {
 

  Future brands()async{
    try{
      Utils util = Utils();
      final String basicurl = util.baseurl;
      final String url = "${basicurl}/vehiclebrand/all";
      var response = await http.get(Uri.parse(url));
       var jsonresponse = jsonDecode(response.body);
      //  print(jsonresponse);
      var status = jsonresponse[0]['status'];
      if(status == true){
       var data = jsonresponse[0]['data'];
       return data.map((json) => VehicleBrands.fromJson(json)).toList();
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
        middleText: "Error ${err}",
        onConfirm: ()=>Get.back()
      );

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    brands();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(),
    body: Stack(
      children: [
        //future builder
        FutureBuilder(
      future: brands(),
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
                       Get.off(AddCustomerSelectModel(),arguments: [snapshot.data[index].brandid])
                      },
                      dense:true,
                      title: Text(snapshot.data[index].brandname,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                  ),
                );
            });
        }
      },
    ),
    //circular progress indicator
//     Visibility(
//       visible: isloading,
//       child: Center(
//         child: GFLoader(
//    type:GFLoaderType.circle
//  ),
//       ))
      ],
    )  
    );
  }
}