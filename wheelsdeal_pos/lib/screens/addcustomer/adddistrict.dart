import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheelsdeal_pos/models/District.dart';
import 'package:wheelsdeal_pos/utils.dart';
import 'package:http/http.dart' as http;

class Adddistrict extends StatefulWidget {
  const Adddistrict({ Key? key }) : super(key: key);

  @override
  State<Adddistrict> createState() => _AdddistrictState();
}

class _AdddistrictState extends State<Adddistrict> {

var argumentdata = Get.arguments;

  Future getDistrict(int stateid)async{
    try{
      Utils util = Utils();
    final String basicurl = util.baseurl;
    final String url = "${basicurl}/districtbystate/${stateid}";
    var response = await http.get(Uri.parse(url));
   
      var jsonresponse = jsonDecode(response.body);
      var status = jsonresponse[0]['status'];
      // print(jsonresponse);
      if(status == true){
        var jsond = jsonresponse[0]['data'];
        return jsond.map((json) => District.fromJson(json)).toList();
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
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDistrict(argumentdata[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(argumentdata[0].toString()),
    );
  }
}