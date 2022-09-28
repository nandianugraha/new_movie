import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';
import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/model/res/res_category.dart';
import 'package:new_movie_flutter/data/model/res/res_informasi.dart';
import 'package:new_movie_flutter/data/repository/public/public_repository.dart';

class KategoriController extends BaseController {
  final PublicRepository _repositoryPublic =
      Get.find(tag: (PublicRepository).toString());

  var isLoading = false.obs;
  List<ResInfo> resInfo = [];

  var kategoriId = ''.obs;
  var kategoriJudul = ''.obs;

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  void getArguments() {
    var args = Get.arguments;

    if (args != null) {
      kategoriId.value = args['kategoriId'];
      kategoriJudul.value = args['kategoriJudul'];
    }
    getData();
  }

  void getData() {
    callDataService(_repositoryPublic.getInfoByKategoriId(kategoriId.value),
        onStart: () => isLoading.value = true,
        onError: ((exception) => isLoading.value = false),
        onSuccess: _handleGetCategori);
  }

  _handleGetCategori(BaseResponseModel response) {
    isLoading.value = false;

    // log(jsonDecode(response.data!));
    List list = jsonDecode(response.data!);
    resInfo.clear();
    for (var element in list) {
      resInfo.add(ResInfo.fromJson(element));
    }
  }
}
