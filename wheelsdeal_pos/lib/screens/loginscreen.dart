// @dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheelsdeal_pos/screens/dashboard.dart';
import 'package:wheelsdeal_pos/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _pivisiblity = false;

  //Text Editing controller

  TextEditingController posicmobile = TextEditingController();
  TextEditingController posicpassword = TextEditingController();



  Widget formColumn(){
    return Column(
                  children: [
                    SizedBox(height: 30,),
                    Text("POS Login",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 24),),
                    SizedBox(height:25),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: posicmobile,
                        keyboardType: TextInputType.number,
                         inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
                        decoration: InputDecoration(
                          labelText: 'Enter 10 Digit Mobile Number',
                          suffixIcon: Icon(FontAwesomeIcons.mobile,size: 17,)
                        ),
                      ),
                    ),
                    SizedBox(height:25),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: posicpassword,
                        obscureText: true,
                         inputFormatters: [
              LengthLimitingTextInputFormatter(12),
            ],
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: Icon(FontAwesomeIcons.lockOpen,size: 17,)
                        ),
                      ),
                    ),
                    SizedBox(height:25.0),
                      Padding(
                        padding: const EdgeInsets.only(left :35,right:35),
                        child: Container(
                          height: 50,
                          width:double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(primary:Colors.green),
  onPressed: () {
      // Respond to button press
      if(posicmobile.text.length ==10 && posicpassword.text.length >=6){
        getAuth(posicmobile.text,posicpassword.text);
      }else{
        Get.defaultDialog(
          title: "User Id and Password are Mandatory !!",
          titleStyle: TextStyle(color: Colors.green),
          middleText: "",
          radius: 20.0,
          onConfirm: ()=>Get.back()
          
        );
      }
      
  },
  icon: Icon(FontAwesomeIcons.rightFromBracket, size: 18),
  label: Text("Login"),
),
                        ),
                      ),
                      SizedBox(height:15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right :35.0),
                            child: GestureDetector(
                              onTap: (){
                                print("yay");
                              },
                              child: Text("Forgot Password ?",style: TextStyle(color: Colors.green),)),
                          )
                      ],)
                  ],
                );
  }
  
  Future getAuth(String posmob, String pospassword)async{
    setState(() {
      _pivisiblity = true;
    });
    try{
        Utils util = Utils();
    final String finalbaseurl = util.baseurl;
      final String url = "${finalbaseurl}/pos/posauthbymob/${posmob}/${pospassword}";
      var response = await http.get(Uri.parse(url));
      // print(response.statusCode);
      
      var jsonresponse = jsonDecode(response.body);
      var status = jsonresponse[0]['status'];
    
            if(status == false){
            setState(() {
                _pivisiblity = false;
              });
              _showInvalidCredentialDialog();
            }else{
              setState(() {
                _pivisiblity = false;
              });
              String posicmo = posicmobile.text;
              final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString("posm", posicmo);
              Get.off(()=>DashBoard());
            
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
    catch(error){
      print(error);
    }
  
    
  }

  
  
   Future _showInvalidCredentialDialog()async{

    return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Invalid Credentials !"),
        actions: [
          TextButton(onPressed: (){
           Navigator.of(context).pop();
          }, child:const Text("Try Again!"))
        ],
      );
    },
  );

  }

 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: 
        GestureDetector(child:Stack(
          children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120
                  ),
                  child: Container(
                    color: Colors.white,
                    width : double.infinity,
                    height: 360,
                    child: formColumn(),
                  ),
                  ),
                ),
              ),
              Visibility(
            visible: _pivisiblity,
            child: Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),))
          ],

        )
        ),
      
    );
  }
}