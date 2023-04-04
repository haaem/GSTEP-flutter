import 'package:get/get.dart';
import 'package:twentyone_days/pages/camera/mission_explanation_page.dart';
import 'package:twentyone_days/pages/home/main_page.dart';
import 'package:twentyone_days/pages/login_page/login_page.dart';
import 'package:twentyone_days/pages/login_page/profile_setting_page.dart';
import 'package:twentyone_days/pages/map/map_page.dart';
import 'package:twentyone_days/pages/mission/mission_page.dart';
import 'package:twentyone_days/pages/setting/color_setting.dart';

import '../pages/setting/tree_setting.dart';

final List<GetPage> routes = [
  GetPage(
      name: '/login',
      page: () => const LoginPage(),
      transition: Transition.zoom
  ),
  GetPage(
    name: '/main',
    page: () => const MainPage(),
    transition: Transition.fade,
  ),
  GetPage(
    name: '/mission',
    page: () => const MissionPage(),
    transition: Transition.fade,
  ),
  GetPage(
    name: '/color_setting',
    page: () => const ColorSetting(),
    transition: Transition.fade,
  ),
  GetPage(
    name: '/tree_setting',
    page: () => const TreeSetting(),
    transition: Transition.fade,
  ),
  GetPage(
    name: '/profile_setting',
    page: () => const ProfileSettingPage(),
    transition: Transition.fade,
  ),
  GetPage(
    name: '/explain',
    page: () => MissionExplanationPage(missionId: '0'),
    transition: Transition.fade,
  ),
];