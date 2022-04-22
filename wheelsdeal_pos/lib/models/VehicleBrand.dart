//@dart=2.9

// To parse this JSON data, do
//
//     final vehicleBrands = vehicleBrandsFromJson(jsonString);

import 'dart:convert';

VehicleBrands vehicleBrandsFromJson(String str) => VehicleBrands.fromJson(json.decode(str));

String vehicleBrandsToJson(VehicleBrands data) => json.encode(data.toJson());

class VehicleBrands {
    VehicleBrands({
        this.brandid,
        this.brandname,
        this.brandurl,
    });

    int brandid;
    String brandname;
    String brandurl;

    factory VehicleBrands.fromJson(Map<String, dynamic> json) => VehicleBrands(
        brandid: json["brandid"],
        brandname: json["brandname"],
        brandurl: json["brandurl"],
    );

    Map<String, dynamic> toJson() => {
        "brandid": brandid,
        "brandname": brandname,
        "brandurl": brandurl,
    };
}
