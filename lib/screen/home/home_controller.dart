import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/paging_controller.dart';
import 'package:new_movie_flutter/data/model/upcoming_response.dart';
import 'package:new_movie_flutter/data/repository/public_repository.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';

class HomeController extends BaseController {
  final PublicRepository _repository =
      Get.find(tag: (PublicRepository).toString());

  final pagingController = PagingController<Upcoming>();

  List<Results>? mListResult;
  @override
  void onInit() {
    getUpcoming('movie');
    super.onInit();
  }

  void getUpcoming(String type) {
    callDataService(
      _repository.getUpcoming(type),
      onSuccess: _handleGetUpcoming,
    );
    pagingController.isLoadingPage = false;
  }

  void _handleGetUpcoming(Upcoming upcoming) => mListResult = upcoming.results;
}
