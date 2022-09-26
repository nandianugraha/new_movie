import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:new_movie_flutter/config/build_config.dart';
import 'package:new_movie_flutter/network/dio_provider.dart';
import 'package:new_movie_flutter/network/error_handlers.dart';
import 'package:new_movie_flutter/network/exceptions/base_exception.dart';
import 'package:new_movie_flutter/util/ext.dart';

abstract class BaseRemoteService {
  Dio get dioClient => DioProvider.dioWithHeaderToken;

  final logger = BuildConfig.instance.config.logger;

  Future<Response<T>> callApiWithErrorParser<T>(Future<Response<T>> api) async {
    try {
      Response<T> response = await api;
      var data = response.data as Map<String, dynamic>;

      if (data['status_code'] != null) {
        if (data['status_code'] != HttpStatus.ok) {
          // TODO
          showSnackbar(data['notif_msg']);
        }
      } else {
        if (response.statusCode != HttpStatus.ok) {
          //
          showSnackbar('Error');
        }
      }

      return response;
    } on DioError catch (dioError) {
      Exception exception = handleDioError(dioError);
      logger.e(
          "Throwing error from repository: >>>>>>> $exception : ${(exception as BaseException).message}");
      throw exception;
    } catch (error) {
      logger.e("Generic error: >>>>>>> $error");

      if (error is BaseException) {
        rethrow;
      }

      throw handleError("$error");
    }
  }
}
