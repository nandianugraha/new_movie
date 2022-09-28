import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/model/req/req_register.dart';
import 'package:new_movie_flutter/data/model/res/res_login.dart';
import 'package:new_movie_flutter/data/remote/private/private_remote_data_source.dart';
import 'package:new_movie_flutter/data/repository/private/private_repository.dart';

class PrivateRepositoryImpl extends PrivateRepository {
  final PrivateRemoteDataSource _remoteSource =
      Get.find(tag: (PrivateRemoteDataSource).toString());

  @override
  Future<BaseResponseModel> login(String noHp, String userPass) {
    return _remoteSource.login(noHp, userPass);
  }

  @override
  Future<BaseResponseModel> register(ReqRegisterModel registerModel) {
    return _remoteSource.register(registerModel);
  }

  @override
  Future<BaseResponseModel> getUser(ResLogin resLogin) {
    return _remoteSource.getUser(resLogin);
  }

  @override
  Future<BaseResponseModel> getKapalHome(ResLogin resLogin) {
    return _remoteSource.getKapalHome(resLogin);
  }

  @override
  Future<BaseResponseModel> setKapalPhone(
      String id, String lat, String long, String phone) {
    return _remoteSource.setKapalPhone(id, lat, long, phone);
  }

  @override
  Future<BaseResponseModel> logout(String kapalId) {
    return _remoteSource.logout(kapalId);
  }

  @override
  Future<BaseResponseModel> saveProfile(
      String userId, String noHp, String name, String alamat) {
    return _remoteSource.saveProfile(userId, noHp, name, alamat);
  }

  @override
  Future<BaseResponseModel> setKapalLocation(
      {String? id, String? lat, String? long, String? status}) {
    return _remoteSource.setKapalLocation(id!, lat!, long!, status!);
  }
}
