import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';
import 'package:new_movie_flutter/data/model/res/res_cuaca.dart';
import 'package:new_movie_flutter/data/repository/public/public_repository.dart';
import 'package:new_movie_flutter/r.dart';

class CuacaController extends BaseController {
  final PublicRepository _repositoryPublic =
      Get.find(tag: (PublicRepository).toString());

  ResCuaca? weather;
  List<Data>? listData = RxList();

  var isLoading = false.obs;
  var pos = 0.obs;

  @override
  void onInit() {
    getCuaca();
    super.onInit();
  }

  Future<void> reset() async {
    isLoading.value = true;
    pos.value = 0;
    getCuaca();
  }

  void getCuaca() {
    callDataService(_repositoryPublic.getCuaca(),
        onStart: () => isLoading.value = true,
        onError: ((exception) => isLoading.value = false),
        onSuccess: _handleCuaca);
  }

  void _handleCuaca(ResCuaca response) {
    isLoading.value = false;

    weather = response;
    response.data?.forEach((element) {
      listData?.add(Data.fromJson(element));
    });
  }

  String condition(String? cuaca) {
    switch (cuaca) {
      case 'Cerah':
        return R.images_cerah;
      case 'Cerah Berawan':
        return R.images_cerahberawan;
      case 'Berawan':
        return R.images_berawan;
      case 'Berkabut':
        return R.images_kabut;
      case 'Hujan Ringan':
        return R.images_hujan;
      case 'Badai':
        return R.images_badai;
      default:
        return R.images_cerahberawan;
    }
  }
}
