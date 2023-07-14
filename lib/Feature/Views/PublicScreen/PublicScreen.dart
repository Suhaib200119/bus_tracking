import 'package:bus_tracing/Feature/Views/LoginScreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import '../../../Core/ColorsManager.dart';
import '../../GlobalWidgets/Button_C.dart';

class PublicScreen extends StatelessWidget {
  const PublicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Color(0xffF3F3F3),
              padding: EdgeInsets.all(4),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Button_C(
                      function: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        },));
                      },
                      btn_title: "Login",
                      fontColor: ColorsManager.primaryColor,
                      backgroundColor: ColorsManager.grayColor,
                    ),
                  ),
                  SizedBox(width: 8,),
                  Expanded(
                    child: Button_C(
                      function: () {
                        print("Public");
                      },
                      btn_title: "Public",
                      fontColor: ColorsManager.grayColor,
                      backgroundColor: ColorsManager.primaryColor,

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
