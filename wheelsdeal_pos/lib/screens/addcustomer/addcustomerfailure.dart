import 'package:flutter/material.dart';

class AddCustomerFailure extends StatefulWidget {
  const AddCustomerFailure({ Key? key }) : super(key: key);

  @override
  State<AddCustomerFailure> createState() => _AddCustomerFailureState();
}

class _AddCustomerFailureState extends State<AddCustomerFailure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Icon(
  Icons.error_outlined,
  size: 16,
  color: Colors.red,
),
        ],
      ),
    );
  }
}