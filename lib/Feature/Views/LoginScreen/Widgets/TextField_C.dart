import 'package:flutter/material.dart';

import '../../../../Core/ColorsManager.dart';

class TextField_C extends StatelessWidget {
  String hintText;
  TextInputType keyboardType;
  TextEditingController tec;

  TextField_C({required this.hintText,required this.keyboardType,required this.tec});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: tec,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: "$hintText",
        hintStyle: TextStyle(
          color: ColorsManager.primaryColor,
          fontWeight: FontWeight.bold
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: ColorsManager.primaryColor),
          borderRadius: BorderRadius.circular(15),

        ),

        focusedBorder: OutlineInputBorder( 
          borderSide: BorderSide(
              width: 1, color:ColorsManager.grayColor),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
