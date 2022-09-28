import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:new_movie_flutter/screen/splash_controller.dart';

import '../r.dart';

class Splashscreen extends GetView<SplashController> {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<SplashController>(builder: (controller) {
      return Stack(
        children: [
          Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(R.images_splashscreen),
                      fit: BoxFit.fill))),
          const Center(child: CircularProgressIndicator())
        ],
      );
    }));
  }
}
