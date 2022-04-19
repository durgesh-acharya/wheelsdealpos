// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wheelsdeal_pos/screens/customerscreen.dart';
import 'package:wheelsdeal_pos/screens/gatepass/gatepass.dart';
import 'package:wheelsdeal_pos/screens/loginscreen.dart';
import 'package:wheelsdeal_pos/utils.dart';
import 'package:http/http.dart' as http;

class DashBoard extends StatefulWidget {
  const DashBoard({ Key key }) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  bool _piindicator = false;
  List pos = [];
  String obtainnum;
  //build navigation drawer

   Widget buildNaigationDrawer(String name , String mob){
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            color:Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:28.0),
                  child: Text(name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Text(mob,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: ListTile(
              leading: Icon(FontAwesomeIcons.user,color:Colors.green,size: 24.0,),
              title: Text("Profile",style: TextStyle(color:Colors.green,fontSize: 16.0),),
            ),
          ),
          Divider(color: Colors.grey),
            ListTile(
            leading: Icon(FontAwesomeIcons.idCard,color:Colors.green,size: 24.0,),
            title: Text("KYC",style: TextStyle(color:Colors.green,fontSize: 16.0),),
          ),
           Divider(color: Colors.grey),
           ListTile(
              leading: Icon(FontAwesomeIcons.powerOff,color:Colors.green,size: 24.0,),
              title: Text("Log Out",style: TextStyle(color:Colors.green,fontSize: 16.0),),
              onTap: ()async{
                   setState(() {
              _piindicator = true;
            });
                removeCredential().whenComplete(() => Timer(Duration(microseconds: 3000), ()=> Get.off(LoginScreen())));
              },
            ),
            Divider(color: Colors.grey),
        ],
      ),
    );
  }

  // grid 

  Widget gridCustomer(){
    return GestureDetector(
      onTap: () => Get.to(CustomerScreen(),arguments: [pos[0],pos[1]]),
      child: Container(
                  
                  color: Colors.green,
                  margin: EdgeInsets.all(5.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Icon(Icons.account_circle_outlined,color: Colors.white,size: 40,),
                    SizedBox(height: 10.0,),
                    Text("Customer",style: TextStyle(color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.bold),)
                  ],),
                ),
    );
  }

  Widget gridGatepass(){
    return GestureDetector(
      onTap: () => Get.to(GatePass(),arguments: [pos[0],pos[1]]),
      child: Container(
                  
                  color: Colors.green,
                  margin: EdgeInsets.all(5.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Icon(
  Icons.description_outlined,color: Colors.white,size: 40,),
                    SizedBox(height: 10.0,),
                    Text("Gate Pass",style: TextStyle(color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.bold),)
                  ],),
                ),
    );
  }

  Widget gridStock(){
    return GestureDetector(
      onTap: () => print("yay"),
      child: Container(
                  
                  color: Colors.green,
                  margin: EdgeInsets.all(5.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Icon(Icons.electric_bike_outlined,color: Colors.white,size: 40,),
                    SizedBox(height: 10.0,),
                    Text("Stock",style: TextStyle(color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.bold),)
                  ],),
                ),
    );
  }

  Widget gridPairing(){
    return GestureDetector(
      onTap: () => fetchPosDetail("7990991439"),
      child: Container(
                  
                  color: Colors.green,
                  margin: EdgeInsets.all(5.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Icon(Icons.swap_vertical_circle_outlined,color: Colors.white,size: 40,),
                    SizedBox(height: 10.0,),
                    Text("Pairing",style: TextStyle(color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.bold),)
                  ],),
                ),
    );
  }

    Widget gridBattery(){
    return GestureDetector(
      onTap: () => print("hi"),
      child: Container(
                  
                  color: Colors.green,
                  margin: EdgeInsets.all(5.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Icon(Icons.battery_full,color: Colors.white,size: 40,),
                    SizedBox(height: 10.0,),
                    Text("Battery",style: TextStyle(color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.bold),)
                  ],),
                ),
    );
  }

    Future removeCredential()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("posm");
  }

    //fetch pos
  Future fetchPos()async{

     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var obtainid = sharedPreferences.getString("posm");
  setState(() {
    obtainnum = obtainid;
  });
  print(obtainnum);
  }

  Future fetchPosDetail(String mob)async{
  try{
      Utils util = Utils();
    final String burl = util.baseurl;
    final String url = "${burl}/pos/posinfo/${mob}";
    var response = await http.get(Uri.parse(url));
     
      var jsonresponse = jsonDecode(response.body);
      var status = jsonresponse[0]['status'];
      if(status == true){
        var data = jsonresponse[0]['data'];
        print(data);
        var posid = data[0]['pos_id'];
        var posbid = data[0]['pos_banch_id'];
        var posname = data[0]['pos_ic_name'];
        var posmob = data[0]['pos_ic_mobile'];
        List posdetails = [posid,posbid,posname,posmob];
        setState(() {
          pos = posdetails;
        });
        // print(pos);
        // print(pos.length);
      
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
    
  }catch(error){
    Get.defaultDialog(
        title: "Something Went Wrong !!! Try again after sometime.",
        middleText: error,
        radius: 20.0,
        onConfirm: () => SystemNavigator.pop(),
      );
  }
    
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPos().whenComplete(() => fetchPosDetail(obtainnum));
    
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      drawer: buildNaigationDrawer(pos.length == 0 ? "" : pos[2],pos.length == 0 ?"" : pos[3]),
      body: GestureDetector(child: Stack(children: [
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding:  EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 50
              ),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24, right: 24),
              children: [
             gridCustomer(),
             gridGatepass(),
             gridStock(),
             gridPairing(),
             gridBattery()
              // Text(posnum == null ? "" : posnum)
                
              ],
              ),
              
          ),
          Visibility(
            visible: _piindicator,
            child: Center(child: CircularProgressIndicator(backgroundColor: Color(0xff000080),),))
        ],)),
    );
  }
}