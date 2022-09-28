import 'package:get/get.dart';
import 'package:new_movie_flutter/routes/my_router.dart';
import 'package:new_movie_flutter/screen/auth/login/login_controller.dart';
import 'package:new_movie_flutter/screen/auth/new_auth_controller.dart';
import 'package:new_movie_flutter/screen/auth/new_auth_page.dart';
import 'package:new_movie_flutter/screen/auth/register/register_controller.dart';
import 'package:new_movie_flutter/screen/cuaca/cuaca_controller.dart';
import 'package:new_movie_flutter/screen/cuaca/cuaca_view.dart';
import 'package:new_movie_flutter/screen/detail_image/detail_image_controller.dart';
import 'package:new_movie_flutter/screen/detail_image/detail_image_view.dart';
import 'package:new_movie_flutter/screen/home/homescreen_controller.dart';
import 'package:new_movie_flutter/screen/home/homescreen_view.dart';
import 'package:new_movie_flutter/screen/kategori/kategori_controller.dart';
import 'package:new_movie_flutter/screen/kategori/kategori_view.dart';
import 'package:new_movie_flutter/screen/mainscreen_controller.dart';
import 'package:new_movie_flutter/screen/mainscreen_view.dart';
import 'package:new_movie_flutter/screen/setting/profile/profile_controller.dart';
import 'package:new_movie_flutter/screen/setting/profile/profile_view.dart';
import 'package:new_movie_flutter/screen/setting/setting_controller.dart';
import 'package:new_movie_flutter/screen/setting/setting_view.dart';
import 'package:new_movie_flutter/screen/sos/sos_controller.dart';
import 'package:new_movie_flutter/screen/sos/sos_view.dart';
import 'package:new_movie_flutter/screen/splash_controller.dart';
import 'package:new_movie_flutter/screen/splashscreen.dart';

class MyPages {
  MyPages._();

  static const initial = MyRouter.splashscreen;
  static final routes = [
    GetPage(
        name: MyRouter.splashscreen,
        page: () => const Splashscreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<SplashController>(() => SplashController());
        })),
    GetPage(
        name: MyRouter.newauthpage,
        page: () => const NewAuthPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<NewAuthController>(() => NewAuthController());
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
        })),
    GetPage(
        name: MyRouter.profilepage,
        page: () => ProfileView(),
        binding: BindingsBuilder((() {
          Get.lazyPut<ProfileController>(() => ProfileController());
        }))),
    GetPage(
        name: MyRouter.kategoriscreen,
        page: () => const KategoriView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<KategoriController>(() => KategoriController());
        })),
    GetPage(
        name: MyRouter.detailimagescreen,
        page: () => const DetailImageView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<DetailImageController>(() => DetailImageController());
        })),
    GetPage(
        name: MyRouter.sosscreen,
        page: () => const SosView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<SosController>(() => SosController());
        })),
  ];
}
