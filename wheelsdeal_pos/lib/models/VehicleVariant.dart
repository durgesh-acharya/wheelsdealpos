
// To parse this JSON data, do
//
//     final vehicleVariant = vehicleVariantFromJson(jsonString);
//@dart=2.9
import 'dart:convert';

VehicleVariant vehicleVariantFromJson(String str) => VehicleVariant.fromJson(json.decode(str));

String vehicleVariantToJson(VehicleVariant data) => json.encode(data.toJson());

class VehicleVariant {
    VehicleVariant({
        this.variantid,
        this.variantname,
        this.variantpicurl,
        this.variantmodelid,
        this.variantbrandid,
    });

    int variantid;
    String variantname;
    String variantpicurl;
    int variantmodelid;
    int variantbrandid;

    factory VehicleVariant.fromJson(Map<String, dynamic> json) => VehicleVariant(
        variantid: json["variantid"],
        variantname: json["variantname"],
        variantpicurl: json["variantpicurl"],
        variantmodelid: json["variantmodelid"],
        variantbrandid: json["variantbrandid"],
    );

    Map<String, dynamic> toJson() => {
        "variantid": variantid,
        "variantname": variantname,
        "variantpicurl": variantpicurl,
        "variantmodelid": variantmodelid,
        "variantbrandid": variantbrandid,
    };
}
