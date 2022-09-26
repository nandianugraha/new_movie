import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';
import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/model/res/res_login.dart';
import 'package:new_movie_flutter/data/repository/private/private_repository.dart';
import 'package:new_movie_flutter/routes/my_router.dart';
import 'package:new_movie_flutter/util/ext.dart';
import 'package:new_movie_flutter/util/preferences.dart';
import 'package:toast/toast.dart';

class LoginController extends BaseController {
  final PrivateRepository _repository =
      Get.find(tag: (PrivateRepository).toString());

  final TextEditingController telpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode telpFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  Color colorLogin = const Color(0xff595959);
  Rx<bool> isLoading = false.obs;
  bool showPassword = false;

  int userId = 0;
  int roleId = 0;
  String token = '';
  String tokenKey = '';

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void togglevisibility() {
    showPassword = !showPassword;
  }

  void loginAction(String noHp, String userPass) async {
    log('masuk sini');
    callDataService(_repository.login(noHp, userPass),
        onStart: () => isLoading.value = true,
        onError: ((exception) => isLoading.value = false),
        onSuccess: loginHandle);
  }

  void getUser() async {
    callDataService(
        _repository.getUser(ResLogin(
            userId: userId, token: token, tokenKey: tokenKey, roleId: roleId)),
        onError: ((exception) => isLoading.value = false),
        onSuccess: getUserHandle);
  }

  void getUserHandle(BaseResponseModel response) {
    List data = jsonDecode(response.data!);
    Map user2 = data.first;
    Preferences.setNama(user2['nama_lengkap']);
    Preferences.setTelp(user2['no_hp']);
    Preferences.setAlamat(user2['alamat']);
    Future.delayed(const Duration(seconds: 1)).then((value) {
      // log('USERID  ${Preferences.getUserId().then((value) => print(value))}');

      Get.offNamed(MyRouter.mainscreen);
    });
  }

  void loginHandle(BaseResponseModel response) {
    ToastContext().init(Get.context!);
    isLoading.value = false;
    log('berhasil masuk');
    Toast.show(response.notifMsg.toString(), gravity: Toast.bottom);
    // ScaffoldMessenger.of(Get.context!)
    // .showSnackBar(SnackBar(content: Text(response.notifMsg.toString())));
    var result = ResLogin.fromJson(jsonDecode(response.data!));
    userId = result.userId ?? 0;
    roleId = result.roleId ?? 0;
    tokenKey = result.tokenKey ?? '';
    token = result.token ?? '';
    Preferences.setUserId('${result.userId}');
    Preferences.setRoleId('${result.roleId}');
    Preferences.setTokenKey('${result.tokenKey}');
    Preferences.setToken('${result.token}');
    getUser();
  }
}
