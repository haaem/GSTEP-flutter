import 'package:get/get.dart';
import 'package:twentyone_days/pages/home/home_page.dart';
import 'package:twentyone_days/pages/login_page/login_page.dart';

final List<GetPage> routes = [
  GetPage(
      name: '/login',
      page: () => const LoginPage(),
      transition: Transition.zoom
  ),
  GetPage(
    name: '/home',
    page: () => const HomePage(),
    transition: Transition.fade,
  ),
];