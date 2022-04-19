import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCustomerSuccess extends StatefulWidget {
  const AddCustomerSuccess({ Key? key }) : super(key: key);

  @override
  State<AddCustomerSuccess> createState() => _AddCustomerSuccessState();
}

class _AddCustomerSuccessState extends State<AddCustomerSuccess> {
  var argumentdata = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Icon(
  Icons.done_outlined,
  size: 75.0,
  color: Colors.green,
),
           ],
         ),
         SizedBox(height: 10.0,),
         Text("Customer Added Successfully!",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.green),),
          SizedBox(height: 10.0,),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
             width: double.infinity,
             child: ElevatedButton(onPressed: (){
                
             }, child: Text("Make Use To Generate Gate Pass")),
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
             width: double.infinity,
             child: ElevatedButton(onPressed: (){}, child: Text("Go To Dashboard")),
           ),
         )
        ],
      )
    );
  }
}