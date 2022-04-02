import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheelsdeal_pos/models/Provision.dart';
import 'package:wheelsdeal_pos/screens/addcustomer/adddistrict.dart';
import 'package:wheelsdeal_pos/utils.dart';
import 'package:http/http.dart' as http;

class AddCustomerSelectState extends StatefulWidget {
  const AddCustomerSelectState({ Key? key }) : super(key: key);

  @override
  State<AddCustomerSelectState> createState() => _AddCustomerSelectStateState();
}

class _AddCustomerSelectStateState extends State<AddCustomerSelectState> {

   bool isloading = true;
   
   

  Future fetchState()async{
    try{
      Utils util = Utils();
      final String basicurl = util.baseurl;
      final String url = "${basicurl}/state";
      var response = await http.get(Uri.parse(url));
      var jsonresponse = jsonDecode(response.body);
      var status = jsonresponse[0]['status'];
      print(status);
      if(status == true){
        var data = jsonresponse[0]['data'];
        return data.map((json) => Provision.fromJson(json)).toList();
      }
    
    } on SocketException{
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
    }

  }

 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: fetchState(),
        builder:(BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
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
                        // print(snapshot.data[index].stateId.toString())
                        Get.to(Adddistrict(),arguments: [snapshot.data[index].stateId])
                      },
                      dense:true,
                      title: Text(snapshot.data[index].stateName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
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