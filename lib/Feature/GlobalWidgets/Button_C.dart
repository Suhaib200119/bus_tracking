import 'package:bus_tracing/Core/ColorsManager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button_C extends StatelessWidget {
  Function function;
  String btn_title;
  Color fontColor;
  Color backgroundColor;
  Button_C(
      {required this.function,
      required this.btn_title,
      required this.fontColor,
      required this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      border: Border.all(width: 2, color:backgroundColor),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
      child: MaterialButton(
        onPressed:(){
          function();
        },
        child: Text(
          btn_title,
          style: GoogleFonts.cairo(
            color: fontColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
