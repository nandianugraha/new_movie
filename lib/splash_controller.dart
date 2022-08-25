import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/routes/my_router.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

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
      if (animation.isCompleted) goHome();
    });
  }

  void goHome() => Get.offNamed(MyRouter.homepage);
}
