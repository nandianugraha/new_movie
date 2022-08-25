import 'dart:io';

import 'package:new_movie_flutter/network/exceptions/api_exception.dart';

class NotFoundException extends ApiException {
  NotFoundException(String message, bool status)
      : super(httpCode: HttpStatus.notFound, status: status, message: message);
}
