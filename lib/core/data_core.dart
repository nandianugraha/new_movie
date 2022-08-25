// ignore_for_file: library_prefixes

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:new_movie_flutter/util/constant.dart';
import 'package:new_movie_flutter/util/ext.dart';

class PublicDataSource {
  final Dio _dio = Dio();

  PublicDataSource() {
    _dio.options.baseUrl = BASEURL;
    _dio.options.connectTimeout = 10000; //5s
    _dio.options.receiveTimeout = 0;
    _dio.options.contentType = Headers.jsonContentType;
    _dio.interceptors.addAll([LogInterceptors(), AdapterDataFactory()]);
  }

  // PublicDataService get publicService => PublicDataService();
}

class ErrorConverter {
  static String getError(Map<String, dynamic> data) {
    String error = 'Opps... Something Wrong';
    String lang =
        GetX.Get.locale != null ? GetX.Get.locale!.languageCode : "id";

    try {
      if (data["error"] != null) {
        if (data["error"] is List) {
          List<dynamic> listError = data["error"] as List<dynamic>;
          if (listError.isNotEmpty) {
            var errorData = listError[0];
            if (errorData["code"] != "999") {
              error = errorData["message"] ?? error;
              if (errorData["messageData"] != null) {
                String objectLang = lang == "en" ? "en" : "in";
                if (errorData["messageData"][objectLang] != null) {
                  error = errorData["messageData"][objectLang];
                }
              }
            }
          }
        }
      }
      // errorMessage =
    } on Exception catch (_) {}
    return error;
  }

  static Map<String, dynamic> getErrorData(Map<String, dynamic> data) {
    String error = 'Opps... Something Wrong';
    String code = "987";
    String lang =
        GetX.Get.locale != null ? GetX.Get.locale!.languageCode : "id";

    try {
      if (data["error"] != null) {
        if (data["error"] is List) {
          List<dynamic> listError = data["error"] as List<dynamic>;
          if (listError.isNotEmpty) {
            var errorData = listError[0];
            code = errorData["code"];
            if (errorData["code"] != "999") {
              error = errorData["message"] ?? error;
              if (errorData["messageData"] != null) {
                String objectLang = lang == "en" ? "en" : "in";
                if (errorData["messageData"][objectLang] != null) {
                  error = errorData["messageData"][objectLang];
                }
              }
            } else {}
          }
        }
      }
      // errorMessage =
    } on Exception catch (_) {}
    return {"code": code, "message": error};
  }

  static Map<String, dynamic> getErrorDataMembership(
      Map<String, dynamic> data) {
    String error = "Terjadi kesalahan";
    String code = "987";

    try {
      if (data["message"] != null) {
        error = data["message"];
      }
      // errorMessage =
    } on Exception catch (_) {}
    return {"code": code, "message": error};
  }
}

class AdapterDataFactory extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data["status"] != true) {
      var tempResponse = ErrorConverter.getErrorData(response.data);
      tempResponse["status"] = false;
      tempResponse["data"] = null;

      response.data = tempResponse;
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}, ${err.response?.data}] => PATH: ${err.requestOptions.path}');
    handler.resolve(Response(
        requestOptions: err.requestOptions,
        data: {'status': false, 'message': 'Opps... Something Wrong'}));
  }
}

class LogInterceptors extends Interceptor {
  LogInterceptors();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    printInfo(
      info:
          '\nREQUEST[${options.method}] => PATH: ${options.baseUrl + options.path}\nHEADERS:\n${getPrettyJSONString(options.headers)}\nDATA:\n${getPrettyJSONString(options.data)}',
    );
    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    printInfo(
        info:
            '\nRESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.baseUrl + response.requestOptions.path}\nRESPONSE:\n${getPrettyJSONString(response.data)}');
    if (response.data["code"] == "500") {
      response.data["message"] = "Opps, Terjadi Kesalahan";
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    printError(
        info:
            '\nERROR_RESPONSE[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}\nRESPONSE:\n${err.response?.data}');
    super.onError(err, handler);
  }
}

// class LoginInterceptors extends Interceptor {
//   @override
//   Future<void> onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     String bodyData = "";
//     String stringBody = "";

//     if (options.data != null && options.data is! FormData) {
//       bodyData = jsonEncode(options.data).replaceAll(RegExp(r"\s+"), "");
//     }
//     stringBody = bodyData.hashSha256;
//     String? accessKey = await SessionManager().getAccessKey();
//     String dataAccess = Ext.hmac256(stringBody, accessKey ?? "");

//     String stamp = Ext.getDateNow("yyyyMMddHHmmss");

//     options.headers.addAll({
//       "X-Bayarind-Auth": dataAccess,
//       "X-Bayarind-Access": accessKey,
//       "X-Bayarind-Key": (stamp + "BAYARIND".hashSha256).hashSha256,
//       "X-Bayarind-Time": stamp
//     });
//     // log('REQUEST[${options.method}] => PATH: ${options.baseUrl + options.path},\n HEADERS: ${options.headers}, \n DATA: ${options.data}');

//     super.onRequest(options, handler);
//   }

//   @override
//   Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
//     log('ERROR_LOGIN_LOG[${err.response?.statusCode}, ${err.response?.data}] => PATH: ${err.requestOptions.path}');
//     if (err.response != null) {
//       if (err.response!.data != null) {
//         //need check data type
//         if (err.response!.data is! String) {
//           var tempResponse = ErrorConverter.getErrorData(err.response!.data);
//           if (tempResponse["code"] == "113" ||
//               tempResponse["code"] == "110" ||
//               tempResponse["code"] == "927") {
//             await SessionManager().setAccessKey(null);
//             await SessionManager().setSecretKey(null);
//             await SessionManager().setPhoneNumber(null);
//             await SessionManager().setUseFingerprintForPin(false);
//             await EventAnalytics().setUserId(null);
//             GetX.Get.offAllNamed(BayarindRoutes.splashPage);
//           }
//         }
//       }
//     }
//     super.onError(err, handler);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) async {
//     if (response.data != null) {
//       //need check data type
//       if (response.data is! String) {
//         var tempResponse = ErrorConverter.getErrorData(response.data);
//         if (tempResponse["code"] == "113" ||
//             tempResponse["code"] == "110" ||
//             tempResponse["code"] == "927") {
//           await SessionManager().setAccessKey(null);
//           await SessionManager().setSecretKey(null);
//           await SessionManager().setPhoneNumber(null);
//           await SessionManager().setUseFingerprintForPin(false);
//           await EventAnalytics().setUserId(null);
//           GetX.Get.offAllNamed(BayarindRoutes.splashPage);
//         }
//       }
//     }

//     super.onResponse(response, handler);
//   }
// }

// class AdapterDataFactoryMembership extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // TODO: implement onRequest
//     super.onRequest(options, handler);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     if (response.data["status"] != true) {
//       var tempResponse = ErrorConverter.getErrorDataMembership(response.data);
//       tempResponse["status"] = false;
//       tempResponse["data"] = null;

//       response.data = tempResponse;
//     }

//     super.onResponse(response, handler);
//   }

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     // TODO: implement onError
//     log('ERROR[${err.response?.statusCode}, ${err.response?.data}] => PATH: ${err.requestOptions.path}');
//     Map<String, dynamic> resp = {
//       'status': false,
//       'message': "Terjadi Kesalahan 2"
//     };
//     if (err.response != null) {
//       if (err.response!.data != null) {
//         resp = ErrorConverter.getErrorDataMembership(err.response!.data!);
//         resp["status"] = false;
//         resp["data"] = null;
//       }
//     }
//     handler.resolve(Response(requestOptions: err.requestOptions, data: resp));
//   }
// }
