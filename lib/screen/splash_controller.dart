import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';
import 'package:new_movie_flutter/routes/my_router.dart';
import 'package:new_movie_flutter/util/preferences.dart';

class SplashController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  var isLoading = false.obs;

  @override
  void onInit() {
    animationInitilization();
    super.onInit();
  }

  animationInitilization() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => update());
    animationController.forward();
    animationController.addListener(() {
      if (animation.isCompleted) _goRouter();
    });
  }

  void _goRouter() {
    Preferences.getToken().then((value) {
      if (value.isEmpty || value == 'null') {
        isLoading.value = false;
        Get.offAllNamed(MyRouter.newauthpage);
      } else {
        // AppRouter.makeFirst(context, MainScreen());
        Get.offAllNamed(MyRouter.mainscreen);
      }
    });
  }
}
