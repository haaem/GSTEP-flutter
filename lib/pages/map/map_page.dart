import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/core/params/my_marker.dart';
import 'package:twentyone_days/data/marker_sample_data.dart';
import 'package:twentyone_days/pages/map/add_mymarker_button.dart';
import 'package:twentyone_days/pages/map/marker_popup.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key, required this.location}) : super(key: key);
  final LocationData location;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  late var currentGps;
  late var markerIcon;
  Set<Marker> markers = Set();

  //일단 연세대학교 시작 주소로
  final LatLng _center = const LatLng(37.5658, 126.9386);

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation().then((value) {
      setState(() {
        currentGps = value;
      });
    });
    _createMarker().then((value) {
      setState(() {
        markers = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController.dispose();
  }

  // 현재위치
  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    final position = await location.getLocation();
    return position;
  }

  //마커
  Future<Set<Marker>> _createMarker() async {
    //마커 이미지 변환 & 마커 추가
    Set<Marker> markersSet = {};
    for (int i = 0; i < markerList.length; i++) {
      var markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),
        "assets/images/marker_others.png",
      );
      markersSet.add(Marker(
          markerId: MarkerId(markerList[i].markerId),
          position: LatLng(markerList[i].latitude, markerList[i].longitude),
          icon: markerIcon,
          //팝업
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => MarkerPopup());
          }));
    }
    return markersSet;
  }

  @override
  Widget build(BuildContext context) {
    _createMarker().then((value) {
      setState(() {
        markers = value;
      });
    });


    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: false,
            markers: markers,
            minMaxZoomPreference: MinMaxZoomPreference(15, 20),
          ),
          // 메인페이지로 돌아가기
          Positioned(
            child: IconButton(
              icon: Icon(
                SFSymbols.arrow_left,
                color: primaryGrey,
                size: 30,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            top: 7,
            left: 10,
          ),
          // 내위치
          // Positioned(
          //   child: FloatingActionButton(
          //     onPressed: () async {
          //       currentGps = await getCurrentLocation();
          //       mapController.animateCamera(CameraUpdate.newLatLng(
          //           LatLng(currentGps.latitude, currentGps.longitude)));
          //       setState(() {});
          //     },
          //     child: Icon(
          //       Icons.my_location_rounded,
          //       color: primaryBlack,
          //     ),
          //     backgroundColor: Colors.white,
          //   ),
          //   bottom: 105,
          //   right: 15,
          // ),
          Positioned(
            child: MyMarker(
                latLng: LatLng(currentGps.latitude, currentGps.longitude)),
            bottom: 30,
            left: 35,
          )
        ],
      ),
    ));
  }

  Widget button() {
    if (hasMarker) {
      return FloatingActionButton(
        onPressed: () async {
          currentGps = await getCurrentLocation();
          mapController.animateCamera(CameraUpdate.newLatLng(
              LatLng(currentGps.latitude, currentGps.longitude)));
          setState(() {});
        },
        child: Icon(
          Icons.my_location_rounded,
          color: primaryBlack,
        ),
        backgroundColor: Colors.white,
      );
    }
    return MyMarker(
        latLng: LatLng(currentGps.latitude, currentGps.longitude)
    );
  }
}
