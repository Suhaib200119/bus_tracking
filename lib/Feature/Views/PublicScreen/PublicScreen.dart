import 'package:bus_tracing/Feature/Views/LoginScreen/LoginScreen.dart';
import 'package:bus_tracing/Feature/Views/PublicScreen/Screens/LayoutScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Core/ColorsManager.dart';
import '../../GlobalWidgets/Button_C.dart';

class PublicScreen extends StatelessWidget {
  const PublicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            const Spacer(),
            Container(
              color: const Color(0xffF3F3F3),
              padding:const EdgeInsets.all(4),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Button_C(
                      function: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ));
                      },
                      btn_title: "Login",
                      fontColor: ColorsManager.primaryColor,
                      backgroundColor: ColorsManager.grayColor,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Button_C(
                      function: () {
                      },
                      btn_title: "Public",
                      fontColor: ColorsManager.grayColor,
                      backgroundColor: ColorsManager.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "Premium Buses.Enjoy the luxury",
              style: GoogleFonts.cairo(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.primaryColor),
            ),
            Text(
              "Premium and prestige bus daily rental.Experience the thrill at a lower price",
              style: GoogleFonts.cairo(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.grayColor_2),
            ),
            const SizedBox(
              height: 64,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 200,
                child: Button_C(
                    function: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return new LayoutScreen();
                        },
                      ));
                    },
                    btn_title: "Next",
                    fontColor: ColorsManager.whiteColor,
                    backgroundColor: ColorsManager.primaryColor),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
