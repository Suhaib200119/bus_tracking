import 'package:bus_tracing/Feature/Views/PublicScreen/Screens/BusesScreen.dart';
import 'package:bus_tracing/Feature/Views/PublicScreen/Screens/CentersScreen.dart';
import 'package:bus_tracing/Feature/Views/PublicScreen/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';

import '../../Network/dioHelper.dart';

class GlobalProvider extends ChangeNotifier{
  String defaultLang="ar";
  void change_default_lang(String defaultLang){
    this.defaultLang=defaultLang;
    notifyListeners();
  }
  List<Widget> items=[
    Icon(Icons.directions_bus_filled, size: 30,color: Colors.white,),
    Icon(Icons.home, size: 30,color: Colors.white,),
    Icon(Icons.center_focus_strong, size: 30,color: Colors.white,),
    Icon(Icons.exit_to_app, size: 30,color: Colors.white,),

  ];
  List<Widget> screens=[
      BusesScreen(),
     HomeScreen(),
     CentersScreen(),
  ];

  int bottomNavigationBarIndex=1;
  void changeBottomNavigationBar(int newValue){
    this.bottomNavigationBarIndex=newValue;
    notifyListeners();
  }

  int currentPageViewIndex=0;
void changeCurrentPageViewIndex(int newValue){
  this.currentPageViewIndex=newValue;
  notifyListeners();
}


  int countSmoothPageIndicator=0;
getLength(){
  DioHelper.getMethod(
      apiName: "Home/GetActiveLine", headers: {}).then((value){
                List<dynamic> data=value.data["data"];
               countSmoothPageIndicator=data.length;
                notifyListeners();
  });
}

}