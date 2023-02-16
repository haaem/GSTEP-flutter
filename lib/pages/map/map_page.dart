import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/data/marker_sample_data.dart';
import 'dart:ui' as ui;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

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
    super.initState();
    currentGps = getCurrentLocation();
    _addMarkers();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // 현재위치
  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    final position = await location.getLocation();
    return position;
  }

  //마커
   void _createMarker(String markerId, LatLng latLng, String markerImagePath, String owner) async {
    //마커 이미지 변환
     markerIcon = await BitmapDescriptor.fromAssetImage(
       ImageConfiguration(),
       markerImagePath,
     );
     markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: latLng,
          icon: markerIcon,
          infoWindow: InfoWindow(
            title: owner,
          ),
        )
     );
  }

  void _addMarkers() {
    for (int i=0; i<markerList.length; i++) {
      _createMarker(markerList[i].markerId, LatLng(markerList[i].latitude, markerList[i].longitude), markerList[i].imagePath, markerList[i].owner);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 15,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                markers: markers,
              ),
              Positioned(
                 child: FloatingActionButton(
                    onPressed: () async {
                      currentGps = await getCurrentLocation();
                      mapController.animateCamera(
                        CameraUpdate.newLatLng(LatLng(currentGps.latitude, currentGps.longitude))
                      );
                    },
                    child: Icon(Icons.my_location_rounded, color: primaryBlack,),
                    backgroundColor: Colors.white,
                  ),
                bottom: 32,
                left: 10,
              )
            ],
          ),
        )
    );
  }
}
