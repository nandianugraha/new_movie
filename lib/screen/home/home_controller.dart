import 'package:get/get.dart';
import 'package:new_movie_flutter/data/repository/public_repository.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';

class HomeController extends BaseController {
  final PublicRepository _repository =
      Get.find(tag: (PublicRepository).toString());

  @override
  void onInit() {
    getUpcomingMovie('movie');
    super.onInit();
  }

  void getUpcomingMovie(String type) {
    callDataService(
      _repository.getUpcoming(type),
      onSuccess: (response) {
        print(response);
      },
    );
  }
}
