import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          body: TabBarView(
            children: [
              CommunityPage(),
              MapPage(),
              MainPage(),
              NewsPage(),
              MyPage(),
            ],
          ),
          bottomNavigationBar: const TabBar(
            indicator: ShapeDecoration(
              shape: Border(top: BorderSide(color: primaryNavy, width: 2))
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: primaryNavy,
            indicatorWeight: 9,
            labelColor: primaryNavy,
            labelStyle: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'SFProBold', fontSize: 9),
            unselectedLabelColor: primaryNavy,
            unselectedLabelStyle: TextStyle(fontFamily: 'SFPro', fontWeight: FontWeight.normal, fontSize: 9),
            tabs: [
              Tab(
                icon: Icon(SFSymbols.person_2, size: 28,),
                //text: 'Community',
              ),
              Tab(
                icon: Icon(SFSymbols.map, size: 28,),
                //text: 'Map',
              ),
              Tab(
                icon: Icon(SFSymbols.house, size: 28,),
                //text: 'Home',
              ),
              Tab(
                icon: Icon(SFSymbols.doc_text, size: 28,),
                //text: 'News',
              ),
              Tab(
                icon: Icon(SFSymbols.person, size: 28,),
                //text: 'My Page',
              ),
            ],
            isScrollable: false,
          )
        ),
      ),
    );
  }
}
