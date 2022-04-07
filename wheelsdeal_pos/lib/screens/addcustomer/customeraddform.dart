//@dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheelsdeal_pos/screens/addcustomer/addcustomerfailure.dart';
import 'package:wheelsdeal_pos/screens/addcustomer/addcustomersuccess.dart';
import 'package:wheelsdeal_pos/utils.dart';
import 'package:http/http.dart' as http;

class CustomerAddForm extends StatefulWidget {
  const CustomerAddForm({ Key key }) : super(key: key);

  @override
  State<CustomerAddForm> createState() => _CustomerAddFormState();
}

class _CustomerAddFormState extends State<CustomerAddForm> {
  bool _pivisible = false;
  var argumentdata = Get.arguments;
  TextEditingController _name = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  String obtainnum;
  List pos;
 
//name text field
  Widget nametextfield(){
    return  Padding(
               padding: const EdgeInsets.all(10.0),
               child: TextFormField(
                 controller: _name,
   cursorColor: Colors.green,
   //initialValue: '',
   maxLength: 20,
   decoration: InputDecoration(
     icon: Icon(FontAwesomeIcons.userLarge),
     labelText: 'Name',
     labelStyle: TextStyle(
       color: Colors.green,
     ),
     helperText: 'Enter Customer Name',
    //  suffixIcon: Icon(
    //    Icons.check_circle,
    //  ),
     enabledBorder: UnderlineInputBorder(
       borderSide: BorderSide(color: Colors.green),
     ),
   ),
 ),
    );
  }

  // address text field

  Widget addresstextfield(){
    return  Padding(
               padding: const EdgeInsets.all(10.0),
               child: TextFormField(
                 controller: _address,
   cursorColor: Theme.of(context).cursorColor,
   //initialValue: '',
   maxLength: 100,
   decoration: InputDecoration(
     icon: Icon(FontAwesomeIcons.mapLocation),
     labelText: 'Address',
     labelStyle: TextStyle(
       color: Colors.green,
     ),
     helperText: 'Enter Customer Address',
    //  suffixIcon: Icon(
    //    Icons.check_circle,
    //  ),
     enabledBorder: UnderlineInputBorder(
       borderSide: BorderSide(color: Colors.green),
     ),
   ),
 ),
    );
  }
//pincode textfiled
Widget pincodetextfield(){
    return  Padding(
               padding: const EdgeInsets.all(10.0),
               child: TextFormField(
                 controller: _pincode,
                 keyboardType: TextInputType.number,
   cursorColor: Theme.of(context).cursorColor,
   //initialValue: '',
   maxLength: 6,
   decoration: InputDecoration(
     icon: Icon(FontAwesomeIcons.locationPin),
     labelText: 'Pincode',
     labelStyle: TextStyle(
       color: Colors.green,
     ),
     helperText: 'Enter Customer Pincode',
    //  suffixIcon: Icon(
    //    Icons.check_circle,
    //  ),
     enabledBorder: UnderlineInputBorder(
       borderSide: BorderSide(color: Colors.green),
     ),
   ),
 ),
    );
  }
//mobile number textfield

//  Widget mobilenumbertextfield(){
//     return  Padding(
//                padding: const EdgeInsets.all(10.0),
//                child: TextFormField(
//                  controller: _mobile,
//                  keyboardType: TextInputType.number,
//    cursorColor: Theme.of(context).cursorColor,
//    initialValue: argumentdata[4],
//    maxLength: 10,
//    decoration: InputDecoration(
//      icon: Icon(FontAwesomeIcons.mobile),
//      labelText: 'Mobile Number',
//      labelStyle: TextStyle(
//        color: Colors.green,
//      ),
//      helperText: 'Enter Customer Mobile Number',
//     //  suffixIcon: Icon(
//     //    Icons.check_circle,
//     //  ),
//      enabledBorder: UnderlineInputBorder(
//        borderSide: BorderSide(color: Colors.green),
//      ),
//    ),
//  ),
//     );
//   }

  Widget addButton(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: (){
           addCustomer(argumentdata[3], argumentdata[2], argumentdata[1], argumentdata[0], _name.text, argumentdata[4], _address.text, int.parse(_pincode.text));
          },
          child: Text("Add Customer"),
        ),
      ),
    );
  }

  Future addCustomer(int outletid,int posid, int stateid,int districtid,String name,String mobile,String address, int pincode)async{
        setState(() {
          _pivisible = true;
        });
          Map customermap = {
        'outletid' : outletid,
        'posid': posid,
        'stateid':stateid,
        'districtid':districtid,
        'name': name,
        'mobile': mobile,
        'address': address,
        'pincode': pincode,
      };

    Utils util = Utils();
    final String basicurl = util.baseurl;
    final String url = "${basicurl}/customer/create";

    var response = await http.post(Uri.parse(url),
  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(customermap) 
);

if (response.statusCode == 200){
  
  var jsonresponse = jsonDecode(response.body);
  var insertedid = jsonresponse['id'];
  var status = jsonresponse['status'];

  if(status == true){
    Timer(Duration(microseconds: 2000), (){
      Get.to(AddCustomerSuccess(),arguments: [insertedid]);
    });
  }

}else{
  Timer(Duration(microseconds: 2000), (){
      Get.to(AddCustomerFailure());
    });
}
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     
  print(argumentdata[0]);
   print(argumentdata[1]);
    print(argumentdata[2]);
     print(argumentdata[3]);
  }

    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Stack(
          children: [
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //name text field
              nametextfield(),
              addresstextfield(),
               pincodetextfield(),
              //  mobilenumbertextfield(),
               addButton()
              
            ],
          ),
          Visibility(
            visible: _pivisible,
            child: Center(
              child: Container(child: Card(child: Row(children: [
                CircularProgressIndicator(),
                Text("Adding Customer")
              ],),),),
            ))
          ],
        ),
      ),
    );
  }
}