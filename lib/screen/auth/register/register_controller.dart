import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';
import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/model/req/req_register.dart';
import 'package:new_movie_flutter/data/repository/private/private_repository.dart';

class RegisterController extends BaseController {
  final PrivateRepository _repository =
      Get.find(tag: (PrivateRepository).toString());

  final TextEditingController name = TextEditingController();
  final TextEditingController telp = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confPassword = TextEditingController();
  final TextEditingController alamat = TextEditingController();
  final TextEditingController kapal1 = TextEditingController();
  final TextEditingController kapal2 = TextEditingController();
  final TextEditingController kapal3 = TextEditingController();

  Rx<bool> isLoading = false.obs;
  bool showPassword = false;
  bool showConfPassword = false;
  Color colorRegister = const Color(0xff595959);

  List kapal = [];

  final formKey = GlobalKey<FormState>();

  void togglevisibility() {
    showPassword = !showPassword;
  }

  void registerAction(ReqRegisterModel registerModel) async {
    log('register sini');

    print(registerModel.toJson());

    callDataService(_repository.register(registerModel),
        onError: ((exception) => isLoading.value = false),
        onStart: () => isLoading.value = true,
        onSuccess: handleRegister);
  }

  void handleRegister(BaseResponseModel response) {
    log(response.notifMsg.toString());
  }
  // void registerAction(BuildContext context) async {
  //   var response = await RemoteData(context:context).register(
  //       _controllerName.text,
  //       _controllerTelp.text,
  //       _controllerPassword.text,
  //       _controllerConfPassword.text,
  //       _controllerAlamat.text,
  //       _controllerKapal1.text,
  //       _controllerKapal2.text,
  //       _controllerKapal3.text);

  //   if (response.status == Constant.SUCCESS_CODE) {
  //     // print(jsonDecode(response.message));
  //     UserInterface.of(context).dialogPopUp(
  //         title: 'Sukses',
  //         content: response.message,
  //         isSuccess: true,
  //         buttonText: 'OK',
  //         onTap: () {
  //           AppRouter.pop(context);
  //           Future.delayed(Duration(seconds: 2)).then((value) {
  //             AppRouter.makeFirst(context, NewAuthScreen());
  //           });
  //         });
  //   }
  // }
}
