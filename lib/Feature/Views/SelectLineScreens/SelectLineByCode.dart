import 'package:bus_tracing/Core/ColorsManager.dart';
import 'package:bus_tracing/Feature/GlobalWidgets/Button_C.dart';
import 'package:bus_tracing/Feature/GlobalWidgets/Dialog_C.dart';
import 'package:bus_tracing/Feature/Views/LoginScreen/Widgets/TextField_C.dart';
import 'package:bus_tracing/Feature/Views/PublicScreen/PublicScreen.dart';
import 'package:bus_tracing/Feature/Views/SelectLineScreens/SelectLineScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../Providers/AuthProvider.dart';
import '../../Providers/LineProvider.dart';

class SelectLineByCode extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController tec_Code = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var lineProvider = Provider.of<LineProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              "Please enter the secret code for line ",
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.primaryColor),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextField_C(
                      hintText: "secret code",
                      keyboardType: TextInputType.text,
                      tec: tec_Code),
                  SizedBox(
                    height: 20,
                  ),
                  Conditional.single(
                    context: context,
                    conditionBuilder: (context) {
                      return lineProvider.next_btn_is_click == false;
                    },
                    widgetBuilder: (context) {
                      return Container(
                        width: 300,
                        child: Button_C(
                          function: () {
                            lineProvider.changeNextBtn(true);
                            if (tec_Code.text.toString().isNotEmpty) {
                              lineProvider.setBusInLineByLineCode(
                                  busId: authProvider.bus.id.toString(),
                                  lineCode: tec_Code.text.toString(),
                                  context: context,
                                  accessToken: authProvider.accessToken);
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog_C(
                                      message:
                                          "You must enter the required data");
                                },
                              );
                            }
                          },
                          btn_title: "Next",
                          fontColor: ColorsManager.grayColor,
                          backgroundColor: ColorsManager.primaryColor,
                        ),
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
                ],
              ),
            ),
            SizedBox(height: 4,),
            Container(
              width: 300,
              child: Button_C(
                function: () {
                  authProvider.logout( context: context);
                },
                btn_title: "Logout",
                fontColor: ColorsManager.grayColor,
                backgroundColor: ColorsManager.primaryColor,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
