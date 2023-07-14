import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier{
  String defaultLang="ar";
  void change_default_lang(String defaultLang){
    this.defaultLang=defaultLang;
    notifyListeners();
  }


}