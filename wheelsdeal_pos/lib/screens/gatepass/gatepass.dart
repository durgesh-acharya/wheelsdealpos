import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheelsdeal_pos/screens/gatepass/gatepassaddcustomer.dart';

class GatePass extends StatefulWidget {
  const GatePass({ Key? key }) : super(key: key);

  @override
  State<GatePass> createState() => _GatePassState();
}

class _GatePassState extends State<GatePass> {
  var argumentsdata = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: IconButton(onPressed: (){
                Timer(Duration(milliseconds: 2000), (){
                  Get.off(GatePassAddCustomer(),arguments: [argumentsdata[0],argumentsdata[1]]);
                });
            }, icon: Icon(
  Icons.add_outlined,
),
),
          )
        ],
      ),
      body: Center(child: Text("Gate Pass Data"),),
    );
  }
}