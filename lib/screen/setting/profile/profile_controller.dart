import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';
import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/repository/private/private_repository.dart';
import 'package:new_movie_flutter/util/ext.dart';
import 'package:new_movie_flutter/util/preferences.dart';
import 'package:new_movie_flutter/widget/confirmation_dialog.dart';

class ProfileController extends BaseController {
  final PrivateRepository _repositoryPrivate =
      Get.find(tag: (PrivateRepository).toString());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode alamatFocus = FocusNode();

  Color colorBackground = const Color(0xffFAFAFA);
  Color colorBackgroundtrue = Colors.white;
  Color shadowBox = Colors.grey.withOpacity(0.5);
  Color shadowBoxTrue = Colors.grey.withOpacity(0.0);
  Color colorTextField = Colors.white;
  Color colorTextFieldtrue = Colors.grey;
  var appBar = 'Profile'.obs;
  var button = 'Edit'.obs;

  var isEdit = false.obs;
  var isLoading = false.obs;
  var isReady = false.obs;

  Rx<String> name = ''.obs;
  Rx<String> noHp = ''.obs;
  Rx<String> alamat = ''.obs;
  Rx<String> userId = ''.obs;
  Rx<String> token = ''.obs;
  Rx<String> tokenKey = ''.obs;
  Rx<String> kapalId = ''.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    name.value = await Preferences.getNama();
    alamat.value = await Preferences.getAlamat();
    noHp.value = await Preferences.getTelp();
    userId.value = await Preferences.getUserId();
    kapalId.value = await Preferences.getKapalId();
    setData();
  }

  setData() {
    nameController.text = isEdit.value
        ? name.value
        : name.value.isEmpty
            ? '-'
            : name.value;
    phoneController.text = isEdit.value
        ? noHp.value
        : noHp.value.isEmpty
            ? '-'
            : noHp.value;
    alamatController.text = isEdit.value
        ? alamat.value
        : alamat.value.isEmpty
            ? '-'
            : alamat.value;

    if (isEdit.value) {
      checkValid();
    }
  }

  checkValid() {
    bool check = true;
    if (nameController.text.isEmpty) check = false;
    if (phoneController.text.isEmpty) check = false;
    if (alamatController.text.isEmpty) check = false;

    if (check) {
      isReady.value = true;
    } else {
      isReady.value = false;
    }
  }

  void saveProfile() {
    callDataService(
        _repositoryPrivate.saveProfile(userId.value, phoneController.text,
            nameController.text, alamatController.text),
        onStart: () => isLoading.value = true,
        onError: ((exception) => isLoading.value = false),
        onSuccess: _handleSaveProfile);
  }

  _handleSaveProfile(BaseResponseModel response) {
    isLoading.value = false;
    Get.dialog(dialogPopUp(
        title: 'Sukses',
        content: response.notifMsg,
        isSuccess: true,
        buttonText: 'OK',
        onTap: () {
          Get.back();
          print('response ${jsonDecode(response.data!)}');
          Preferences.setNama(nameController.text);
          Preferences.setTelp(phoneController.text);
          Preferences.setAlamat(alamatController.text);
          appBar.value = 'Profile';
          button.value = 'Edit';
          isEdit.value = false;
        }));
  }
}
