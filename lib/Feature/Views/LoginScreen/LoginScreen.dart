import 'package:bus_tracing/Core/ColorsManager.dart';
import 'package:bus_tracing/Feature/GlobalWidgets/Button_C.dart';
import 'package:bus_tracing/Feature/GlobalWidgets/Dialog_C.dart';
import 'package:bus_tracing/Feature/Views/LoginScreen/Widgets/TextField_C.dart';
import 'package:bus_tracing/Feature/Views/PublicScreen/PublicScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../Providers/AuthProvider.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController tec_number = new TextEditingController();
  TextEditingController tec_password = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    var authProvider = Provider.of<AuthProvider>(context);

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
                        print("Login");
                      },
                      btn_title: "Login",
                      fontColor: ColorsManager.grayColor,
                      backgroundColor: ColorsManager.primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Button_C(
                      function: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PublicScreen();
                            },
                          ),
                        );
                      },
                      btn_title: "Public",
                      fontColor: ColorsManager.primaryColor,
                      backgroundColor: ColorsManager.grayColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextField_C(
                      hintText: "ID | Bus Id",
                      keyboardType: TextInputType.text,
                      tec: tec_number),
                  SizedBox(
                    height: 4,
                  ),
                  TextField_C(
                    hintText: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    tec: tec_password,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Conditional.single(
                    context: context,
                    conditionBuilder: (context) {
                      return authProvider.login_btn_is_click == false;
                    },
                    widgetBuilder: (context) {
                      return Container(
                        width: 300,
                        child: Button_C(
                          function: () {
                            if (tec_number.text.toString().isNotEmpty &&
                                tec_password.text.toString().isNotEmpty) {
                              authProvider.changeLoginBtn(true);
                              authProvider.login(
                                  number: tec_number.text.toString(),
                                  password: tec_password.text.toString(),
                                  context: context);
                              if(authProvider.accessToken.isNotEmpty){
                                authProvider.getAllLines();
                              }
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
                          btn_title: "Loing",
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
          ],
        ),
      ),
    );
  }
}
