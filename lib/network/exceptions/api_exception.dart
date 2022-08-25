import 'package:new_movie_flutter/network/exceptions/base_api_exception.dart';

class ApiException extends BaseApiException {
  ApiException({
    required int httpCode,
    required bool status,
    String message = "",
  }) : super(httpCode: httpCode, status: status, message: message);
}
