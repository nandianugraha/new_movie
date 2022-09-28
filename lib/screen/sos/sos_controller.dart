import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';
import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/repository/private/private_repository.dart';
import 'package:new_movie_flutter/util/ext.dart';

class SosController extends BaseController {
  final PrivateRepository _repositoryPrivate =
      Get.find(tag: (PrivateRepository).toString());

  var kapalId = ''.obs;
  var noHP = ''.obs;
  var lat = ''.obs;
  var long = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  void getArguments() {
    var args = Get.arguments;

    if (args != null) {
      kapalId.value = args['kapalId'];
      noHP.value = args['noHp'];
      lat.value = args['lat'];
      long.value = args['long'];
    }
  }

  void sendSOS() {
    isLoading.value = true;
    callDataService(
        _repositoryPrivate.setKapalLocation(
            id: kapalId.value, lat: lat.value, long: long.value, status: 'ya'),
        onStart: () => isLoading.value = true,
        onError: ((exception) => isLoading.value = false),
        onSuccess: _handleSOS);
  }

  void _handleSOS(BaseResponseModel response) {
    isLoading.value = false;

    Get.dialog(dialogPopUp(
        title: 'Perhatian',
        content: response.notifMsg,
        isSuccess: true,
        onTap: () {
          Get
            ..back()
            ..back();
        }));
  }
}
