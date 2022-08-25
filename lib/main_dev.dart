import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/binding/initial_binding.dart';
import 'package:new_movie_flutter/config/build_config.dart';
import 'package:new_movie_flutter/config/env_config.dart';
import 'package:new_movie_flutter/config/environment.dart';
import 'package:new_movie_flutter/routes/my_pages.dart';
import 'package:new_movie_flutter/routes/my_router.dart';

void main() {
  EnvConfig devConfig = EnvConfig(
    appName: "Flutter Movie Dev",
    baseUrl: "https://api.themoviedb.org/3/",
    shouldCollectCrashLog: true,
  );

  BuildConfig.instantiate(
    envType: Environment.DEVELOPMENT,
    envConfig: devConfig,
  );

  runApp(GetMaterialApp(
    theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
    })),
    initialBinding: InitialBinding(),
    initialRoute: MyRouter.splashscreen,
    getPages: MyPages.routes,
    debugShowCheckedModeBanner: false,
  ));
}
