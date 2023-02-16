import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:twentyone_days/config/theme/text/title_text.dart';
import 'package:twentyone_days/pages/provider/date.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late DateTime startTime;
  final DateTime leftTime = DateTime(0, 0, 21);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, _) {
          final dateState = ref.watch(dateProvider);
          // 21일 시작 전
          if (dateState == TwentyOneDate.none) {
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
                      height: MediaQuery
                          .of(context)
                          .size
                          .height - 290,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(blurRadius: 3,
                                spreadRadius: 1,
                                color: Colors.grey.withOpacity(0.2))
                          ]
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 75,),
                          BodyText(text: '아직 시작되지 않았어요!',
                            size: 14,
                            weight: FontWeight.w600,),
                          //일단 시작버튼
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: () {
                              ref.read(dateProvider.notifier).start();
                              startTime = DateTime.now();


                            },
                            child: Container(
                              child: BodyText(text: '시작하기',),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            );
            // 21일 진행 중
          } else if (dateState == TwentyOneDate.ongoing) {
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
                      height: MediaQuery
                          .of(context)
                          .size
                          .height - 250,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(blurRadius: 3,
                                spreadRadius: 1,
                                color: Colors.grey.withOpacity(0.2))
                          ]
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            alignment: Alignment.center,
                            child: BodyText(text: '${leftTime.day} : ${leftTime.hour} : ${leftTime.minute} : ${leftTime.second}', weight: FontWeight.w600, size: 14,),
                          ),
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .width - 40,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 40,
                            color: Color(0xffF2F2F7),
                          ),
                          SizedBox(height: 25,),
                          Center(
                            child: GestureDetector(
                              child: CircleAvatar(
                                backgroundColor: Color(0xffD9D9D9),
                                child: Icon(SFSymbols.camera_fill, color: Color(0xff999999), size: 24,),
                                radius: 27,
                              ),
                              onTap: () {
                                ref.read(dateProvider.notifier).finishCycle();
                                setState(() {});
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            );
            // 21일 마무리 & sns 공유
          } else {
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 70),
                  child: Consumer(
                      builder: (context, ref, _) {
                        return Container(
                          height: MediaQuery.of(context).size.height - 140,
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
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width - 40,
                                alignment: Alignment.center,
                                child: BodyText(text: '21일 동안 유저님이 이렇게 세상을 바꾸었어요!', size: 14, color: primaryNavy,),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.width - 40,
                                width: MediaQuery.of(context).size.width - 40,
                                color: Color(0xffF2F2F7),
                              ),
                              Container(
                                height: 80,
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    ref.read(dateProvider.notifier).done();
                                    setState(() {});
                                  },
                                  child: Icon(Icons.share, color: Color(0xff999999), size: 25,),
                                )
                              )
                            ],
                          ),
                        );
                      }
                  ),
                ),
              ),
            );
          }
        }
    );
  }
}
