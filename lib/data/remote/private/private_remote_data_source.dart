import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/model/req/req_register.dart';
import 'package:new_movie_flutter/data/model/res/res_login.dart';

abstract class PrivateRemoteDataSource {
  Future<BaseResponseModel> login(String noHp, String userPass);
  Future<BaseResponseModel> register(ReqRegisterModel registerModel);
  Future<BaseResponseModel> getUser(ResLogin resLogin);
  Future<BaseResponseModel> getKapalHome(ResLogin resLogin);
  Future<BaseResponseModel> setKapalPhone(
      String id, String lat, String long, String phone);
  Future<BaseResponseModel> setKapalLocation(
      String id, String lat, String long, String status);
  Future<BaseResponseModel> logout(String kapalId);
}
