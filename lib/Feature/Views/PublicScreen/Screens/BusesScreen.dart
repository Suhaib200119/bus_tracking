import 'dart:convert';
import 'package:bus_tracing/Network/dioHelper.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../Core/ColorsManager.dart';
import '../../../GlobalWidgets/CardData_C.dart';

class BusesScreen extends StatelessWidget {
  const BusesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: DioHelper.getMethod(
              apiName: "Line/GetAllActiveLine", headers: {}),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dynamic snapshotData = jsonDecode(snapshot.data.toString());
              if (snapshotData["status"]) {
                List<dynamic> data = snapshotData["data"];
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(color: ColorsManager.primaryColor,),
                    );
                  },
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return MaterialButton(
                      onPressed: (){
                        print("LINE ID: ${data[index]["id"]}");

                      },
                      child: CardData_C(
                          busName: data[index]["bus"]["name"],
                          busNumber: data[index]["bus"]["number"],
                          busCompany: data[index]["bus"]["company"]["name"],
                          busImage: "Assets/images/bus.png",
                          index: index),
                    );
                  },
                );
              } else {
                return const Text("NO Buses");
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: ColorsManager.primaryColor,
                  size: 50,
                ),
              );
            } else {
              return const Text("SOME ERROR!");
            }
          },
        ),
      ),
    );
  }
}
