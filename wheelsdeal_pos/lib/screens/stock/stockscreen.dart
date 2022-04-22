import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:wheelsdeal_pos/screens/stock/addvehicleselectbrand.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({ Key? key }) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right :8.0),
            child: ElevatedButton.icon(onPressed: ()=>Get.to(AddVehicleSelectBrand()), icon: Icon(FontAwesomeIcons.add), label: Text("Add Vehicle")),
          )
        ],
      ),
      body: Center(child: Text("StockScreen"),),
    );
  }
}