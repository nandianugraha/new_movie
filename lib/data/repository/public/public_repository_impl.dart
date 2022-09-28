import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/model/res/res_cuaca.dart';
import 'package:new_movie_flutter/data/model/upcoming_response.dart';
import 'package:new_movie_flutter/data/remote/public/public_remote_data_source.dart';
import 'package:new_movie_flutter/data/repository/public/public_repository.dart';

class PublicRepositoryImpl implements PublicRepository {
  final PublicRemoteDataSource _remoteSource =
      Get.find(tag: (PublicRemoteDataSource).toString());

  @override
  Future<BaseResponseModel> getLandingPage(
      String userId, String token, String tokenKey) {
    return _remoteSource.getLandingPage(userId, token, tokenKey);
  }

  @override
  Future<ResCuaca> getCuaca() {
    return _remoteSource.getCuaca();
  }

  @override
  Future<BaseResponseModel> getInfoByKategoriId(String kategoriId) {
    return _remoteSource.getInfoByKategoriId(kategoriId);
  }
}
