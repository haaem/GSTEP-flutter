import 'package:get/get.dart';
import 'package:twentyone_days/pages/home/main_page.dart';
import 'package:twentyone_days/pages/login_page/login_page.dart';
import 'package:twentyone_days/pages/map/map_page.dart';
import 'package:twentyone_days/pages/mission/mission_page.dart';

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
    name: '/map',
    page: () => const MapPage(),
    transition: Transition.fade,
  ),
  GetPage(
    name: '/mission',
    page: () => const MissionPage(),
    transition: Transition.fade,
  ),
];