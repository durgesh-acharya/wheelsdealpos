import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class GatePassVehicleQrScan extends StatefulWidget {
  const GatePassVehicleQrScan({ Key? key }) : super(key: key);

  @override
  State<GatePassVehicleQrScan> createState() => _GatePassVehicleQrScanState();
}

class _GatePassVehicleQrScanState extends State<GatePassVehicleQrScan> {
    final qrKey = GlobalKey(debugLabel: 'QR');
   QRViewController? controller;
  Barcode? barcode;
   @override
  void dispose() {
    // TODO: implement dispose
     controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble()async{
    super.reassemble();

    if(Platform.isAndroid){
      await controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        buildQrView(context),
        Positioned(
          bottom: 20,
          left:40,
          child: buildResult())
      ],),
   
    );
  }
   Widget buildQrView(BuildContext context){
   return QRView(key: qrKey, onQRViewCreated: onQRViewCreated,overlay: QrScannerOverlayShape(
     cutOutSize: MediaQuery.of(context).size.width * 0.8,
     borderWidth: 10,
     borderLength: 20,
     borderRadius: 10,
     borderColor: Colors.green
   ),);
 }
  void onQRViewCreated(QRViewController controller){
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
     });
  }

  Widget buildResult(){
    return barcode == null ? Text("No Result Found") : Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Text(barcode != null ? 'AssetTag : ${barcode!.code}' : "",style: TextStyle(color: Colors.green),),
      ElevatedButton(onPressed: (){print(barcode!.code);}, child: Text("Next"))
    ],);
    
  }
}