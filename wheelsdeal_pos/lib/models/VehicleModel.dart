//@dart=2.9
// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromJson(jsonString);

import 'dart:convert';

VehicleModel vehicleModelFromJson(String str) => VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

class VehicleModel {
    VehicleModel({
        this.modelid,
        this.modelname,
        this.modelbrandid,
        this.modelpicurl,
    });

    int modelid;
    String modelname;
    int modelbrandid;
    dynamic modelpicurl;

    factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        modelid: json["modelid"],
        modelname: json["modelname"],
        modelbrandid: json["modelbrandid"],
        modelpicurl: json["modelpicurl"],
    );

    Map<String, dynamic> toJson() => {
        "modelid": modelid,
        "modelname": modelname,
        "modelbrandid": modelbrandid,
        "modelpicurl": modelpicurl,
    };
}
