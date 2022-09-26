import 'package:get/get.dart';
import 'package:new_movie_flutter/routes/my_router.dart';
import 'package:new_movie_flutter/screen/auth/login/login_controller.dart';
import 'package:new_movie_flutter/screen/auth/register/register_controller.dart';
import 'package:new_movie_flutter/screen/cuaca/cuaca_controller.dart';
import 'package:new_movie_flutter/screen/cuaca/cuaca_view.dart';
import 'package:new_movie_flutter/screen/home/homescreen_controller.dart';
import 'package:new_movie_flutter/screen/home/homescreen_view.dart';
import 'package:new_movie_flutter/screen/mainscreen_controller.dart';
import 'package:new_movie_flutter/screen/mainscreen_view.dart';
import 'package:new_movie_flutter/screen/setting/setting_controller.dart';
import 'package:new_movie_flutter/screen/setting/setting_view.dart';
import 'package:new_movie_flutter/splash_controller.dart';
import 'package:new_movie_flutter/splash_page.dart';

class MyPages {
  MyPages._();

  static const initial = MyRouter.splashscreen;
  static final routes = [
    GetPage(
        name: MyRouter.splashscreen,
        page: () => const SplashPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<SplashController>(() => SplashController());
          Get.lazyPut<LoginController>(() => LoginController());
          Get.lazyPut<RegisterController>(() => RegisterController());
        })),
    GetPage(
        name: MyRouter.mainscreen,
        page: () => const MainScreenView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<MainScreenController>(() => MainScreenController());
        })),
    GetPage(
        name: MyRouter.homescreen,
        page: () => const HomescreenView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<HomeController>(() => HomeController());
        })),
    GetPage(
        name: MyRouter.cuacascreen,
        page: () => const CuacaView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<CuacaController>(() => CuacaController());
        })),
    GetPage(
        name: MyRouter.settingscreen,
        page: () => SettingView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<SettingController>(() => SettingController());
        }))
  ];
}
