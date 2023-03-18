import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
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
          appBar: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            backgroundColor: primaryLightGreen,
            leading: IconButton(
              icon: Icon(
                SFSymbols.map_fill,
                size: 28,
                color: Colors.white,
              ),
              onPressed: () {
                Get.toNamed('/map');
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  SFSymbols.square_list_fill,
                  size: 28,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.toNamed('/mission');
                },
              ),
            ],
          ),
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
                color: primaryLightGreen
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 65),
                  Image.asset('assets/images/tree_imsi.png', width: 210,),
                  SizedBox(height: 70,),
                ],
              ),
            ),
          ),
        )
    );
  }
}
