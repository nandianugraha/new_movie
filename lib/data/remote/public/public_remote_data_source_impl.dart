import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:new_movie_flutter/core/base/base_remote_service.dart';
import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/model/res/res_cuaca.dart';
import 'package:new_movie_flutter/data/remote/public/public_remote_data_source.dart';
import 'package:new_movie_flutter/network/dio_provider.dart';

class PublicRemoteDataSourceImpl extends BaseRemoteService
    implements PublicRemoteDataSource {
  @override
  Future<BaseResponseModel> getLandingPage(
      String userId, String token, String tokenKey) async {
    var endpoint =
        "${DioProvider.baseUrl}api/landingpage?user_id=$userId&role_id=3&token=$token&token_key=$tokenKey";
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResCuaca> getCuaca() async {
    var endpoint =
        'https://peta-maritim.bmkg.go.id/public_api/perairan/F.11_Perairan%20Indramayu%20-%20Cirebon.json';
    var dioCall = dioClient.get(endpoint);
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseCuaca(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponseModel> getInfoByKategoriId(String kategoriId) {
    var endpoint =
        '${DioProvider.baseUrl}api/getInfoByKatId?kategori_id=$kategoriId';
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  ResCuaca _parseCuaca(Response response) {
    return ResCuaca.fromJson(response.data);
  }

  BaseResponseModel _parseResponse(Response response) {
    return convertToResponseModel(response);
  }

  static BaseResponseModel convertToResponseModel(Response response) {
    Map item = response.data;
    int code = 200;
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (item[HttpStatus.ok] is String) {
        code = int.parse(item[HttpStatus.ok]);
      } else if (item[HttpStatus.ok] is int) {
        code = item[HttpStatus.ok];
      }

      return BaseResponseModel(
          statusCode: item['status_code'],
          notifMsg: item['notif_msg'],
          data: jsonEncode(item['data'] ?? ''));
    }
    return null!;
  }
}
