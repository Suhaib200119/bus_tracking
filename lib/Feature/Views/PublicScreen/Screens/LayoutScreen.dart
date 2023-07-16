import 'package:bus_tracing/Feature/Providers/GlobalProvider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Core/ColorsManager.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);
//
  @override
  Widget build(BuildContext context) {
    var globalProvider = Provider.of<GlobalProvider>(context);
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor:
            ColorsManager.primaryColor, //لون العنصر الموجود في الناف بار
        color: ColorsManager.primaryColor, // لون الناف بار نفسه
        animationCurve:
            Curves.decelerate, // طريقة تحرك العنصر الموجود في الناف بار
        buttonBackgroundColor: ColorsManager
            .orangeColor, //لون البوتون الموجود في العنصر الموجود في الناف بار
        items: globalProvider.items,
        onTap: (index) {
          if(index==3){
            Navigator.pop(context);
          }else{
            globalProvider.changeBottomNavigationBar(index);

          }

        }, // استرجاع الاندكس الخاص في عنصر الناف البار الذي تم الضغط عليه
        index: globalProvider.bottomNavigationBarIndex,
      ),
      body: globalProvider.screens[globalProvider.bottomNavigationBarIndex],
    );
  }
}
