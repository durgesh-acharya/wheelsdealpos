
// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);
//@dart=2.9
import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
    Customer({
        this.customerId,
        this.customerOutletId,
        this.customerPosId,
        this.customerState,
        this.customerDistrict,
        this.customerName,
        this.customerMobile,
        this.customerAddress,
        this.customerPincode,
        this.customerDateTime,
    });

    int customerId;
    int customerOutletId;
    int customerPosId;
    int customerState;
    int customerDistrict;
    String customerName;
    String customerMobile;
    String customerAddress;
    int customerPincode;
    DateTime customerDateTime;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customerId: json["customer_id"],
        customerOutletId: json["customer_outlet_id"],
        customerPosId: json["customer_pos_id"],
        customerState: json["customer_state"],
        customerDistrict: json["customer_district"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        customerAddress: json["customer_address"],
        customerPincode: json["customer_pincode"],
        customerDateTime: DateTime.parse(json["customer_date_time"]),
    );

    Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_outlet_id": customerOutletId,
        "customer_pos_id": customerPosId,
        "customer_state": customerState,
        "customer_district": customerDistrict,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "customer_address": customerAddress,
        "customer_pincode": customerPincode,
        "customer_date_time": customerDateTime.toIso8601String(),
    };
}
