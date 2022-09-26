import 'dart:convert';

import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';
import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/model/res/res_login.dart';
import 'package:new_movie_flutter/data/repository/private/private_repository.dart';
import 'package:new_movie_flutter/routes/my_router.dart';
import 'package:new_movie_flutter/util/preferences.dart';

class SettingController extends BaseController {
  final PrivateRepository _repositoryPrivate =
      Get.find(tag: (PrivateRepository).toString());

  var isLoading = false.obs;

  ResLogin? user;
  Rx<String> name = ''.obs;
  Rx<String> noHp = ''.obs;
  Rx<String> alamat = ''.obs;
  Rx<String> userId = ''.obs;
  Rx<String> token = ''.obs;
  Rx<String> tokenKey = ''.obs;
  Rx<String> kapalId = ''.obs;
  // String kapalId = '';

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    name.value = await Preferences.getNama();
    noHp.value = await Preferences.getTelp();
    userId.value = await Preferences.getUserId();
    token.value = await Preferences.getToken();
    tokenKey.value = await Preferences.getTokenKey();
    kapalId.value = await Preferences.getKapalId();
  }

  Future<void> reset() async {
    isLoading.value = true;
    getUser();
  }

  void getUser() {
    isLoading.value = true;
    callDataService(
        _repositoryPrivate.getUser(ResLogin(
            userId: int.parse(userId.value),
            token: token.value,
            tokenKey: tokenKey.value)),
        onStart: () => isLoading.value = true,
        onError: ((exception) => isLoading.value = false),
        onSuccess: getUserHandle);
  }

  void getUserHandle(BaseResponseModel response) {
    isLoading.value = false;
    List data = jsonDecode(response.data!);
    Map user2 = data.first;
    Preferences.setNama(user2['nama_lengkap']);
    Preferences.setTelp(user2['no_hp']);
    Preferences.setAlamat(user2['alamat']);
  }

  void logout() {
    isLoading.value = true;
    callDataService(_repositoryPrivate.logout(kapalId.value),
        onStart: () => isLoading.value = true,
        onError: ((exception) => isLoading.value = false),
        onSuccess: _handleLogout);
  }

  void _handleLogout(BaseResponseModel response) {
    Preferences().logout();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      isLoading.value = false;

      Preferences.getUserId().then((value) => print(value));
      Get.offNamed(MyRouter.splashscreen);
    });
  }
}
