import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get/get.dart';
import 'package:twentyone_days/config/theme/color.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                SFSymbols.map_fill,
                size: 28,
                color: primaryGrey,
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
                  color: primaryGrey,
                ),
                onPressed: () {
                  Get.toNamed('/mission');
                },
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 150),
                Image.asset('assets/images/tree_imsi.png'),
                SizedBox(height: 70,),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      SFSymbols.plus_circle_fill,
                      color: primaryGrey,
                      size: 50,
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}
