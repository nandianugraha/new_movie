import 'package:get/get.dart';
import 'package:new_movie_flutter/routes/my_router.dart';
import 'package:new_movie_flutter/screen/home/home_controller.dart';
import 'package:new_movie_flutter/screen/home/home_page.dart';
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
        })),
    GetPage(
        name: MyRouter.homepage,
        page: () => HomePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<HomeController>(() => HomeController());
        })),
  ];
}
