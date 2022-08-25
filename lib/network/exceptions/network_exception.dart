import 'package:new_movie_flutter/network/exceptions/base_exception.dart';

class NetworkException extends BaseException {
  NetworkException(String message) : super(message: message);
}
