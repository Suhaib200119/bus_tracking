import 'dart:collection';

import 'package:bus_tracing/Feature/GlobalWidgets/Dialog_C.dart';
import 'package:bus_tracing/Feature/Models/BusLine.dart';
import 'package:bus_tracing/Network/dioHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Views/HomeScreen_Map/HomeScreen_Map.dart';


class LineProvider extends ChangeNotifier {
  bool next_btn_is_click = false;
  void changeNextBtn(bool newVlaue) {
    this.next_btn_is_click = newVlaue;
    notifyListeners();
  }

  dynamic line_id = "";

  void changeLineId({required dynamic newValue}) {
    this.line_id = newValue;
    notifyListeners();
  }

  Future<BitmapDescriptor> _createMarkerIcon() async {
    const String assetName = 'Assets/images/bus_marker.jpg';
    return BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(10, 10)), // Desired size of the marker icon
      assetName,
    );
  }
  late double lat;
  late double lon;
  HashSet<Marker> markers = HashSet<Marker>();

  bool haspermission = false;
  late LocationPermission permission;
  checkGpsAndGetCurrentLocation(BuildContext context) async {
    bool servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }
      if (haspermission) {
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((value)async {
          final BitmapDescriptor markerIcon = await _createMarkerIcon();
          lat = value.latitude;
          lon = value.longitude;
          markers.add(Marker(
            markerId: MarkerId(0.toString()),
            position: LatLng(lat, lon),
            infoWindow: InfoWindow(),
            icon: markerIcon
          ),);
          notifyListeners();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomeScreen_Map(
                  lat: lat,
                  lon: lon,
                  markers: markers,
                );
              },
            ),
          );
        });
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
  }

  late BusLine busLine;

  void setBusInLineByLineId(
      {required String busId,
      required BuildContext context,
      required String accessToken}) {
    DioHelper.postMethod(apiName: "Driver/Line/SetBusInLineById", body: {
      "lineId": line_id,
      "busId": busId
    }, headers: {
      "authorization": "Bearer " + accessToken,
    }).then((value) {
      next_btn_is_click = false;
      notifyListeners();
      if (value.data["status"]) {
        busLine = BusLine.fromJson(value.data["data"]);
        notifyListeners();
        checkGpsAndGetCurrentLocation(context);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog_C(message: value.data["message"]);
          },
        );
      }
    }).catchError((onError) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog_C(message: onError.toString());
        },
      );
    });
  }

  void setBusInLineByLineCode(
      {required String busId,
      required String lineCode,
      required BuildContext context,
      required String accessToken}) {
    DioHelper.postMethod(apiName: "Driver/Line/SetBusInLineByCode", body: {
      "lineCode": lineCode,
      "busId": busId
    }, headers: {
      "authorization": "Bearer " + accessToken,
    }).then((value) {
      next_btn_is_click = false;
      notifyListeners();
      if (value.data["status"]) {
        busLine = BusLine.fromJson(value.data["data"]);
        notifyListeners();
        checkGpsAndGetCurrentLocation(context);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog_C(message: value.data["message"]);
          },
        );
      }
    }).catchError((onError) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog_C(message: onError.toString());
        },
      );
    });
  }
}
