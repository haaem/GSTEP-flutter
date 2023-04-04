import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:http/http.dart' as http;
import 'package:twentyone_days/core/params/user.dart';
import 'package:twentyone_days/pages/map/add_marker_popup.dart';

class MyMarker extends StatefulWidget {
  const MyMarker({Key? key, required this.latLng}) : super(key: key);
  final LatLng latLng;

  @override
  State<MyMarker> createState() => _MyMarkerState();
}

class _MyMarkerState extends State<MyMarker> {
  @override
  Widget build(BuildContext context) {
    late bool isMarkerAllowed;
    late bool isStepAllowed;
    if (userLevel >=2) {
      isStepAllowed = true;
    } else {
      isStepAllowed = false;
    }

    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width - 70,
        height: 60,
        decoration: BoxDecoration(
            color: isStepAllowed ? buttonColor : Color(0xff686868),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: isStepAllowed
                ? BodyText(
                    text: 'Plant Your Tree!',
                    color: Colors.white,
                    size: 18,
                    weight: FontWeight.w700,
                  )
                : BodyText(
                    text: 'You need more steps!',
                    color: Colors.white,
                    size: 18,
                    weight: FontWeight.w700,
                  )),
      ),
      onTap: () async {
        if (isStepAllowed) {
          isMarkerAllowed = await checkMarker();

          showDialog(context: context, builder: (BuildContext context) => isMarkerAllowed ? AddMarkerPopup(lat: widget.latLng.latitude, long: widget.latLng.longitude,) :
              AlertDialog(
                content: BodyText(
                  text: 'Too close to other trees!',
                  color: primaryBlack,
                  size: 17,
                  textAlign: TextAlign.start,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(buttonColor)),
                    child: BodyText(
                      text: 'OK',
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      size: 12,
                    ),
                  ),
                ],
                actionsPadding: EdgeInsets.only(bottom: 15, right: 15),
              ));
        }
      },
    );
  }

  Future<bool> checkMarker() async {
    final url = Uri.parse(
      'http://34.64.137.128:8080/marker/check/',
    );
    final response = await http.post(url, body: {
      "Longitude": widget.latLng.longitude.toString(),
      "Latitude": widget.latLng.latitude.toString(),
    });
    if (response.statusCode == 200) {
      return Future.value(true);
    }
    return Future.value(false);
  }
}
