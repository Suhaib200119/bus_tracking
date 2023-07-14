import 'dart:io';

import 'package:bus_tracing/Core/ColorsManager.dart';
import 'package:bus_tracing/Feature/GlobalWidgets/Button_C.dart';
import 'package:bus_tracing/Feature/Views/SelectLineScreens/SelectLineByCode.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../Providers/AuthProvider.dart';
import '../../Providers/LineProvider.dart';

class SelectLineScreen extends StatefulWidget {
  List<dynamic> lines;
  SelectLineScreen({required this.lines});

  @override
  State<SelectLineScreen> createState() => _SelectLineScreenState();
}

class _SelectLineScreenState extends State<SelectLineScreen> {
  dynamic selectedValue;
  @override
  Widget build(BuildContext context) {
    var lineProvider = Provider.of<LineProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              "Select line",
              style: GoogleFonts.cairo(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.primaryColor),
            ),
            Text(
              "Please choose the line you want to go",
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.primaryColor),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: ColorsManager.primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<dynamic>(
                  isExpanded: true,
                  hint: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: widget.lines
                      .map((dynamic item) => DropdownMenuItem<dynamic>(
                            value: item["id"],
                            child: Text(
                              item["name"],
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (dynamic value) {
                    setState(() {
                      selectedValue = value;
                    });
                    lineProvider.changeLineId(newValue: value.toString());
                    print(lineProvider.line_id);
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: 140,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Conditional.single(
              context: context,
              conditionBuilder: (context) {
                return lineProvider.next_btn_is_click==false;
              },
              widgetBuilder: (context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Button_C(
                      function: () {
                        lineProvider.changeNextBtn(true);
                        lineProvider.setBusInLineByLineId(
                            busId: authProvider.bus.id.toString(),
                            accessToken: authProvider.accessToken,
                            context: context);
                      },
                      btn_title: "Next",
                      fontColor: ColorsManager.whiteColor,
                      backgroundColor: ColorsManager.primaryColor),
                );
              },
              fallbackBuilder: (context) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: ColorsManager.primaryColor,
                    size: 50,
                  ),
                );
              },
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Use another company's line.",
                  style: GoogleFonts.cairo(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff8E8E8E),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return SelectLineByCode();
                    },));
                  },
                  child: Text(
                    "Click here.",
                    style: GoogleFonts.cairo(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFEB97A),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
