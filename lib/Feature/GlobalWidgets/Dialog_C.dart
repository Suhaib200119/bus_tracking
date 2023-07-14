import 'package:bus_tracing/Core/ColorsManager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dialog_C extends StatelessWidget {

  String message;
  Dialog_C({ required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              color: ColorsManager.primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
