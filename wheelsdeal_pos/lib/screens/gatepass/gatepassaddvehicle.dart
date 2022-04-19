import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/types/gf_border_type.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wheelsdeal_pos/screens/gatepass/gatepassdateremark.dart';
import 'package:wheelsdeal_pos/screens/gatepass/gatepassvehicleqrscan.dart';

class GatePassAddVehicle extends StatefulWidget {
  const GatePassAddVehicle({ Key? key }) : super(key: key);

  @override
  State<GatePassAddVehicle> createState() => _GatePassAddVehicleState();
}

class _GatePassAddVehicleState extends State<GatePassAddVehicle> {
 
  var argumentdata = Get.arguments;
 

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right :20.0),
        //     child: GestureDetector(
        //       onTap: (){
        //        Get.to(GatePassVehicleQrScan());
        //       },
        //       child: Row(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.only(right :8.0),
        //             child: Icon(FontAwesomeIcons.qrcode),
        //           ),
        //           Text("Scan QR")
        //         ],
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: Center(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 250.0,
          width: double.infinity,
          child: GFBorder(
            
            color: Color(0xFF19CA4B),
    dashedLine: [2, 0],
    type: GFBorderType.rect,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top :18.0),
                  child: Text("Enter Chassis Number Manually",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
  
  decoration: InputDecoration(
    
    border: OutlineInputBorder(),
    
  ),
),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton.icon(onPressed: (){}, icon: Icon(FontAwesomeIcons.searchengin), label: Text("Search",style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                ),
              
              ],
            )
          ),
        ),
      ),
      
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: ()=>Get.to(GatePassVehicleQrScan()), label: Text("Tap to Scan"),icon: Icon(FontAwesomeIcons.camera),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

 
}