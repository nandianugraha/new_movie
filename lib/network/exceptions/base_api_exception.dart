import 'package:new_movie_flutter/network/exceptions/app_exception.dart';

abstract class BaseApiException extends AppException {
  final int httpCode;
  final bool status;

  BaseApiException(
      {this.httpCode = -1, this.status = false, String message = ""})
      : super(message: message);
}
