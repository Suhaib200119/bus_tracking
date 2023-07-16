import 'package:flutter/material.dart';

class CentersScreen extends StatelessWidget {
  const CentersScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Container(
        color: Colors.orange,
        child: Text("CentersScreen"),
      ),
    );
  }
}
