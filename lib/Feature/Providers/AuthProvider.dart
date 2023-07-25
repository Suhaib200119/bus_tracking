import 'package:bus_tracing/Feature/Models/Bus.dart';
import 'package:bus_tracing/Feature/Views/LoginScreen/LoginScreen.dart';
import 'package:bus_tracing/Feature/Views/SelectLineScreens/SelectLineScreen.dart';
import 'package:bus_tracing/Network/dioHelper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../GlobalWidgets/Dialog_C.dart';

class AuthProvider extends ChangeNotifier {
  bool login_btn_is_click = false;
  void changeLoginBtn(bool newVlaue) {
    this.login_btn_is_click = newVlaue;
    notifyListeners();
  }

  List<dynamic> lines = [];
  Future<Response> getAllLines() async {
    return await DioHelper.getMethod(
        apiName: "Driver/Line/GetAll/" + bus.companyId.toString(),
        headers: {
          "authorization": "Bearer " + accessToken,
        });
  }
// bool login_true=false;
  late Bus bus;
  late String accessToken = "";
  void login(
      {required String number,
      required String password,
      required BuildContext context}) {
    DioHelper.postMethod(
        apiName: "Driver/Bus/Login",
        body: {"number": number, "password": password}).then((value) {
      if (value.data["status"]) {
        accessToken = value.data["data"]["accessToken"];
        bus = Bus.fromJson(value.data["data"]["bus"]);
        notifyListeners();
        getAllLines().then((value) {
          lines = value.data["data"];
          login_btn_is_click = false;
          // login_true=true;
          notifyListeners();
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return SelectLineScreen(lines: lines);
            },
          ));
        });
      } else {
        login_btn_is_click = false;
        notifyListeners();
        showDialog(
          context: context,
          builder: (context) {
            return Dialog_C(message: value.data["message"]);
          },
        );
      }

    }).catchError((onError) {
      login_btn_is_click = false;
      notifyListeners();
      showDialog(
        context: context,
        builder: (context) {
          return Dialog_C(message: "some error , try later");

        },
      );
    });
  }

  void logout(
      {required BuildContext context}) {
    DioHelper.getMethod(
      apiName: "Driver/Bus/Logout/" + bus.id.toString(),
      headers: {
        "authorization": "Bearer " + accessToken,
      },
    ).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),);
    });
  }
}
