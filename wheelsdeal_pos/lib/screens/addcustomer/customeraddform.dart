//@dart=2.9
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomerAddForm extends StatefulWidget {
  const CustomerAddForm({ Key key }) : super(key: key);

  @override
  State<CustomerAddForm> createState() => _CustomerAddFormState();
}

class _CustomerAddFormState extends State<CustomerAddForm> {
  var argumentdata = Get.arguments;
//name text field
  Widget nametextfield(){
    return  Padding(
               padding: const EdgeInsets.all(10.0),
               child: TextFormField(
   cursorColor: Theme.of(context).cursorColor,
   initialValue: '',
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
   cursorColor: Theme.of(context).cursorColor,
   initialValue: '',
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
                 keyboardType: TextInputType.number,
   cursorColor: Theme.of(context).cursorColor,
   initialValue: '',
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

Widget mobilenumbertextfield(){
    return  Padding(
               padding: const EdgeInsets.all(10.0),
               child: TextFormField(
                 keyboardType: TextInputType.number,
   cursorColor: Theme.of(context).cursorColor,
   initialValue: '',
   maxLength: 10,
   decoration: InputDecoration(
     icon: Icon(FontAwesomeIcons.mobile),
     labelText: 'Mobile Number',
     labelStyle: TextStyle(
       color: Colors.green,
     ),
     helperText: 'Enter Customer Mobile Number',
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

  Widget addButton(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: (){
            print("hey");
          },
          child: Text("Add Customer"),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //name text field
            nametextfield(),
            addresstextfield(),
             pincodetextfield(),
             mobilenumbertextfield(),
             addButton()
            
          ],
        ),
      ),
    );
  }
}