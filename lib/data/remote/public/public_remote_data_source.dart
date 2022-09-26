import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/model/res/res_cuaca.dart';

abstract class PublicRemoteDataSource {
  Future<BaseResponseModel> getLandingPage(
      String userId, String token, String tokenKey);
  Future<ResCuaca> getCuaca();
}
