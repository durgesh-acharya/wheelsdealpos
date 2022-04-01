//@dart=2.9
import 'dart:convert';

Provision provisionFromJson(String str) => Provision.fromJson(json.decode(str));

String provisionToJson(Provision data) => json.encode(data.toJson());

class Provision {
    Provision({
        this.stateId,
        this.stateName,
    });

    int stateId;
    String stateName;

    factory Provision.fromJson(Map<String, dynamic> json) => Provision(
        stateId: json["state_id"],
        stateName: json["state_name"],
    );

    Map<String, dynamic> toJson() => {
        "state_id": stateId,
        "state_name": stateName,
    };
}