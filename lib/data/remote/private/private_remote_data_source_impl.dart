import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:new_movie_flutter/core/base/base_remote_service.dart';
import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/model/req/req_register.dart';
import 'package:new_movie_flutter/data/model/res/res_login.dart';
import 'package:new_movie_flutter/data/remote/private/private_remote_data_source.dart';
import 'package:new_movie_flutter/network/dio_provider.dart';

class PrivateRemoteDataSourceImpl extends BaseRemoteService
    implements PrivateRemoteDataSource {
  @override
  Future<BaseResponseModel> login(String noHp, String userPass) {
    var endpoint = '${DioProvider.baseUrl}api/login';
    var dioCall =
        dioClient.post(endpoint, data: {'no_hp': noHp, 'user_pass': userPass});

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponseModel> register(ReqRegisterModel registerModel) {
    var endpoint = '${DioProvider.baseUrl}api/register';
    var dioCall = dioClient.post(endpoint, data: registerModel);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponseModel> getUser(ResLogin resLogin) {
    var endpoint =
        '${DioProvider.baseUrl}api/getUserById?user_id=${resLogin.userId}&token=${resLogin.token}&token_key=${resLogin.tokenKey}&role_id=${resLogin.roleId}}';
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponseModel> getKapalHome(ResLogin resLogin) {
    var endpoint =
        '${DioProvider.baseUrl}api/getAllKapal?user_id=${resLogin.userId}&role_id=${resLogin.roleId}&token=${resLogin.token}&token_key=${resLogin.tokenKey}';
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponseModel> setKapalPhone(
      String id, String lat, String long, String noHp) {
    var endpoint = '${DioProvider.baseUrl}api/setkapalDanHP';
    var dioCall = dioClient.post(endpoint,
        data: {'kapal_id': id, 'long': long, 'lat': lat, 'no_hp': noHp});

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponseModel> setKapalLocation(
      String id, String lat, String long, String status) {
    var endpoint = '${DioProvider.baseUrl}api/setKapalAndLocation';
    var dioCall = dioClient.post(endpoint,
        data: {'kapal_id': id, 'long': long, 'lat': lat, 'sos_st': status});

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponseModel> logout(String kapalId) {
    var endpoint = '${DioProvider.baseUrl}api/logout';
    var dioCall =
        dioClient.post(endpoint, data: {'kapal_id': kapalId.toString()});

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponseModel> saveProfile(
      String userId, String noHp, String name, String alamat) {
    var endpoint = '${DioProvider.baseUrl}api/editProfile';
    var dioCall = dioClient.post(endpoint, data: {
      'user_id': userId,
      'no_hp': noHp,
      'nama_lengkap': name,
      'alamat': alamat
    });

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseResponse(response));
    } catch (e) {
      rethrow;
    }
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
