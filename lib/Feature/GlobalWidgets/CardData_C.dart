import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Core/ColorsManager.dart';

class CardData_C extends StatelessWidget {
  String busName;
  String busNumber;
  String busCompany;
  String busImage;
  int index;

  CardData_C(
      {required this.busName,
      required this.busNumber,
      required this.busCompany,
      required this.busImage,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${busCompany} company",
            style: GoogleFonts.cairo(
              color: ColorsManager.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              busImage,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            busName,
            style: GoogleFonts.cairo(
              color: ColorsManager.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            busNumber,
            style: GoogleFonts.cairo(
              color: ColorsManager.grayColor_2,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
