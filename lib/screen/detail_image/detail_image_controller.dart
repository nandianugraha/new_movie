import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';

class DetailImageController extends BaseController {

  var urlImage = ''.obs;
  var isNet = false.obs;

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  void getArgument() {
    var args = Get.arguments;

    if (args != null) {
      urlImage.value = args['urlImage'];
      isNet.value = args['isNet'];
    }
  }
}