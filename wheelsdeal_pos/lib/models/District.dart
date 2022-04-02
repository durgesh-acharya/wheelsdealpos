// To parse this JSON data, do
//
//     final district = districtFromJson(jsonString);
//@dart=2.9
import 'dart:convert';

District districtFromJson(String str) => District.fromJson(json.decode(str));

String districtToJson(District data) => json.encode(data.toJson());

class District {
    District({
        this.districtId,
        this.districtName,
        this.districtStateid,
    });

    int districtId;
    String districtName;
    int districtStateid;

    factory District.fromJson(Map<String, dynamic> json) => District(
        districtId: json["district_id"],
        districtName: json["district_name"],
        districtStateid: json["district_stateid"],
    );

    Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "district_name": districtName,
        "district_stateid": districtStateid,
    };
}
