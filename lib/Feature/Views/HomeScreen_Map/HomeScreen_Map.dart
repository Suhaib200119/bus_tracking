import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../Core/ColorsManager.dart';
import '../../GlobalWidgets/Button_C.dart';
import '../../Providers/AuthProvider.dart';
import 'package:geolocator/geolocator.dart';

import '../../Providers/LineProvider.dart';

class HomeScreen_Map extends StatelessWidget {
  double lat, lon;
  HashSet<Marker> markers;
  HomeScreen_Map({required this.lat, required this.lon, required this.markers});
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var lineProvider = Provider.of<LineProvider>(context);


    return Scaffold(
      drawer: Drawer(
        child: Column(

          children: [
            DrawerHeader(
              padding: EdgeInsets.only(left: 8, top: 4),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/3/3d/Plaxton_Elite_YN10_FKM_Selwyns_National_Express.jpg",
                      width: 150,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authProvider.bus.name.toString(),
                        style: GoogleFonts.cairo(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: ColorsManager.primaryColor),
                      ),
                      Text(
                        authProvider.bus.company!.name.toString(),
                        style: GoogleFonts.cairo(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: ColorsManager.primaryColor),
                      ),
                      Text(
                        authProvider.bus.number.toString(),
                        style: GoogleFonts.cairo(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff949498)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Align(
                   alignment: Alignment.topLeft,
                   child: Text(
                     lineProvider.busLine.name.toString(),
                     style: GoogleFonts.cairo(
                         fontSize: 16,
                         fontWeight: FontWeight.w700,
                         color:ColorsManager.primaryColor,),
                   ),
                 ),

                 Align(
                   alignment: Alignment.topLeft,
                   child: Text(
                     lineProvider.busLine.company!.name.toString(),
                     style: GoogleFonts.cairo(
                         fontSize: 12,
                         fontWeight: FontWeight.w700,
                         color:ColorsManager.primaryColor),
                   ),
                 ),

               ],
            ),
          ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 300,
                  child: Button_C(
                    function: () {
                      authProvider.logout(context: context);
                    },
                    btn_title: "Logout",
                    fontColor: ColorsManager.grayColor,
                    backgroundColor: ColorsManager.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16,),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, lon),
            zoom: 18.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: markers,
        ),
        // child:Text("ss"),
      ),
    );
  }
}
