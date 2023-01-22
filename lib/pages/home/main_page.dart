import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:twentyone_days/config/theme/text/title_text.dart';

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
            toolbarHeight: 110,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: TitleText(
              text: '21Days',
              size: 17,
              color: primaryNavy,
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: MediaQuery.of(context).size.height - 290,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(blurRadius: 3, spreadRadius: 1, color: Colors.grey.withOpacity(0.2))
                  ]
              ),
              child: Column(
                children: [
                  SizedBox(height: 75,),
                  BodyText(text: '아직 시작되지 않았어요!', size: 14, weight: FontWeight.w600,)
                ],
              ),
            ),
          ),
        ),
    );
  }
}
