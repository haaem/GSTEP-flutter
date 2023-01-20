import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:twentyone_days/pages/community/community_page.dart';
import 'package:twentyone_days/pages/home/main_page.dart';
import 'package:twentyone_days/pages/map/map_page.dart';
import 'package:twentyone_days/pages/my_page/my_page.dart';
import 'package:twentyone_days/pages/news/news_page.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:twentyone_days/config/theme/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: pageIndex,
          children: [
            CommunityPage(),
            MapPage(),
            MainPage(),
            NewsPage(),
            MyPage(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          elevation: 15,
          notchMargin: 5,
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Spacer(flex: 5,),
                NavigationIconButton(
                    index: 0,
                    name: "Community",
                    icon: (pageIndex==0) ? SFSymbols.person_2_fill : SFSymbols.person_2,
                ),
                Spacer(flex: 5,),
                NavigationIconButton(
                    index: 1,
                    name: "Map",
                    icon: (pageIndex==1) ? SFSymbols.map_fill : SFSymbols.map,
                ),
                Spacer(flex: 5,),
                NavigationIconButton(
                  index: 2,
                  name: "Home",
                  icon: (pageIndex==2) ? SFSymbols.house_fill : SFSymbols.house,
                ),
                Spacer(flex: 5,),
                NavigationIconButton(
                  index: 3,
                  name: "News",
                  icon: (pageIndex==3) ? SFSymbols.doc_text_fill : SFSymbols.doc_text,
                ),
                Spacer(flex: 5,),
                NavigationIconButton(
                  index: 4,
                  name: "My Page",
                  icon: (pageIndex==4) ? SFSymbols.person_fill : SFSymbols.person,
                ),
                Spacer(flex: 5,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget NavigationIconButton({required int index, required String name, required IconData icon}) {
    bool isCurrent = (index==pageIndex);
    return SizedBox(
      height: 60,
      width: 60,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)
        ),
        onTap: () {
          setState(() {
            pageIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: primaryNavy,
            ),
            SizedBox(height: 5,),
            BodyText(text: name, color: primaryNavy, textAlign: TextAlign.center, weight: isCurrent ? FontWeight.w600: FontWeight.normal, size: 10,)
          ],
        ),
      ),
    );
  }
}
