import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/core/base/paging_controller.dart';
import 'package:new_movie_flutter/data/model/res/res_banner.dart';
import 'package:new_movie_flutter/data/model/res/res_category.dart';
import 'package:new_movie_flutter/data/model/res/res_informasi.dart';
import 'package:new_movie_flutter/data/model/upcoming_response.dart';
import 'package:new_movie_flutter/data/repository/public/public_repository.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';
import 'package:new_movie_flutter/util/preferences.dart';

class HomeController extends BaseController {
  final PublicRepository _repository =
      Get.find(tag: (PublicRepository).toString());

  final pagingController = PagingController<Upcoming>();

  var imageBanner = ''.obs;
  Rx<String> name = ''.obs;
  Rx<String> userId = ''.obs;
  Rx<String> token = ''.obs;
  Rx<String> tokenKey = ''.obs;
  Rx<bool> isLoading = false.obs;

  List<ResCategory>? allCategory = RxList();
  List<ResInfo>? allInformasi = RxList();

  @override
  void onInit() {
    // getUpcoming('movie');
    getData();
    super.onInit();
  }

  getData() async {
    name.value = await Preferences.getNama();
    userId.value = await Preferences.getUserId();
    token.value = await Preferences.getToken();
    tokenKey.value = await Preferences.getTokenKey();
    getLandingPage();
  }

  Future<void> reset() async {
    isLoading.value = true;
    getLandingPage();
  }

  void getLandingPage() {
    callDataService(
        _repository.getLandingPage(userId.value, token.value, tokenKey.value),
        onStart: () => isLoading.value = true,
        onError: ((exception) => isLoading.value = false),
        onSuccess: _handleLandingPage);
  }

  void _handleLandingPage(BaseResponseModel response) {
    Map data = jsonDecode(response.data!);
    List resultCategory = [];
    List resultInfo = [];
    Map resultBanner;
    data.forEach((key, value) {
      switch (key) {
        case "allKategori":
          {
            resultCategory = value;
            for (var element in resultCategory) {
              allCategory?.add(ResCategory.fromJson(element));
            }
            break;
          }
        case "allInfo":
          {
            resultInfo = value;
            for (var element in resultInfo) {
              allInformasi?.add(ResInfo.fromJson(element));
            }
            break;
          }
        case "banner":
          {
            resultBanner = value;
            resultBanner.forEach((key, value) {
              if (key == "nama_file") {
                imageBanner.value = value ?? '';
                isLoading.value = false;
              }
            });
            break;
          }
      }
    });
  }
}
