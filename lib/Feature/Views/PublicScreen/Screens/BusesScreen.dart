import 'package:flutter/material.dart';

class BusesScreen extends StatelessWidget {
  const BusesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
     child:  Container(
       color: Colors.orange,
       child: Text("BusesScreen"),
     ),
    );
  }
}
