import 'dart:io';

import 'package:new_movie_flutter/network/exceptions/base_api_exception.dart';

class UnauthorizedException extends BaseApiException {
  UnauthorizedException(String message)
      : super(
            httpCode: HttpStatus.unauthorized, message: message, status: false);
}
