import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:twentyone_days/config/theme/tree.dart';
import 'package:twentyone_days/pages/home/panel_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    PanelController _pc = new PanelController();
    bool panelClosed = true;

    return SafeArea(
        child: Scaffold(
          body: SlidingUpPanel(
            controller: _pc,
            panelBuilder: (controller) => PanelWidget(
              controller: controller,
            ),
            minHeight: 260,
            maxHeight: height,
            borderRadius: radius,
            color: Colors.white,
            // 바탕
            body: Container(
              decoration: BoxDecoration(
                color: backgroundColor
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.map_rounded,
                        size: 28,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.toNamed('/map');
                      },
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.format_list_bulleted_rounded,
                        size: 28,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.toNamed('/mission');
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 120),
                      Image.asset(myTree, width: 210,),
                      Center(child: SizedBox(height: 70,)),
                    ],
                  ),
                  Positioned(
                    bottom: 315,
                      right: 30,
                      child: GestureDetector(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white70,
                          ),
                          child: Icon(Icons.autorenew_rounded, color: Colors.black54,),
                        ),
                        onTap: () {
                          Get.toNamed('/color_setting');
                        },
                      )
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
